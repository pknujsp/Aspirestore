package controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.fileDTO;
import model.FileDAO;
import model.QnaDAO;
import model.QnaDTO;

public class ServletQna extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_QUESTION_LIST": // 문의글 목록 가져오기
			getQuestionList(request, response);
			break;
		case "GET_QUESTION_POST": // 글 읽기
			getQuestionPost(request, response);
			break;
		case "CREATE_ANSWER_FORM":
			createAnswerForm(request, response);
			break;
		case "GET_ANSWER_LIST":
			getAnswerList(request, response);
			break;
		case "GET_RECORDS_SIZE":
			getListSize(request, response);
			break;
		case "GET_ANSWER_POST":
			getAnswerPost(request, response);
			break;
		}
	}

	private void getQuestionList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			String userId = request.getAttribute("USER_ID").toString();
			int currentPage = 1;

			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			if (request.getAttribute("CURRENT_PAGE") != null)
			{
				currentPage = Integer.parseInt(request.getAttribute("CURRENT_PAGE").toString());
			}
			// 전체 레코드의 개수를 가져온다.
			int listSize = qnaDAO.getListSize(userId, "QUESTION");
			HashMap<String, Integer> pageData = new HashMap<String, Integer>();

			pageData.put("total_page", 0);
			pageData.put("total_block", 0);
			pageData.put("num_per_page", 10);
			pageData.put("page_per_block", 5);
			pageData.put("list_size", 0);
			pageData.put("total_record", 0);
			pageData.put("current_page", currentPage);
			pageData.put("current_block", 1);
			pageData.put("begin_index", 0);
			pageData.put("end_index", 10);

			// 문의글 목록을 불러오기 전 페이지 데이터를 처리한다.
			calculatePageData(pageData, listSize);
			// begin_index , end_index에 따라 문의글 목록을 가져온다. (시간 올림차순)
			ArrayList<QnaDTO> questionList = qnaDAO.getQuestionList(userId, pageData);

			// 조건하에 가져온 문의글 목록의 레코드 개수를 저장한다.
			pageData.put("list_size", questionList.size());

			request.setAttribute("PAGE_DATA", pageData);
			request.setAttribute("QUESTION_LIST", questionList);
			request.setAttribute("VIEWURL", "forward:/csservice/csconsult.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void calculatePageData(HashMap<String, Integer> pageData, int total_records)
	{
		pageData.put("total_record", total_records);

		int numPerPage = pageData.get("num_per_page");
		int totalRecord = pageData.get("total_record");
		int currentPage = pageData.get("current_page");
		int pagePerBlock = pageData.get("page_per_block");

		pageData.put("begin_index", (currentPage * numPerPage) - numPerPage);
		pageData.put("end_index", numPerPage);
		pageData.put("total_page", (int) (Math.ceil((double) (totalRecord) / numPerPage)));
		pageData.put("current_block", (int) (Math.ceil((double) (currentPage) / pagePerBlock)));

		int totalPage = pageData.get("total_page");

		pageData.put("total_block", (int) (Math.ceil((double) (totalPage) / pagePerBlock)));
	}

	private void getQuestionPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");
			String userId = request.getAttribute("USER_ID").toString();
			int questionCode = Integer.parseInt(request.getAttribute("QUESTION_CODE").toString());
			int currentPage = Integer.parseInt(request.getAttribute("CURRENT_PAGE").toString());

			// 문의 글 데이터
			QnaDTO questionPostData = qnaDAO.getQuestionPost(userId, questionCode);
			QnaDTO answerData = null;

			// 첨부파일 가져오기
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
			ArrayList<fileDTO> questionFiles = null;
			ArrayList<fileDTO> answerFiles = null;

			if (questionPostData.getNumFiles() > 0)
			{
				questionFiles = fileDAO.getFiles(questionPostData.getQuestion_code(), questionPostData.getUser_id(),
						"QUESTION");
			}

			if (questionPostData.getStatus().equals("답변 완료"))
			{
				answerData = qnaDAO.getAnswerPost(questionCode);

				if (answerData.getNumFiles() > 0)
				{
					answerFiles = fileDAO.getFiles(answerData.getAnswer_code(), answerData.getUser_id(), "ANSWER");
				}
			}

			request.setAttribute("CURRENT_PAGE", currentPage);
			request.setAttribute("QUESTION_DATA", questionPostData);
			request.setAttribute("ANSWER_DATA", answerData);
			request.setAttribute("QUESTION_FILES", questionFiles);
			request.setAttribute("ANSWER_FILES", answerFiles);
			request.setAttribute("VIEWURL", "forward:/csservice/viewCPost.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void createAnswerForm(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");

			String questionerId = request.getAttribute("CUSTOMER_ID").toString();
			int questionCode = Integer.parseInt(request.getAttribute("QUESTION_CODE").toString());

			// questionCode, customerId를 가지고 문의글 데이터를 가져온다.
			QnaDTO questionData = qnaDAO.getQuestionPost(questionerId, questionCode);

			ArrayList<fileDTO> questionFiles = null;
			if (questionData.getNumFiles() > 0)
			{
				questionFiles = fileDAO.getFiles(questionData.getQuestion_code(), questionData.getUser_id(),
						"QUESTION");
			}

			request.setAttribute("QUESTION_DATA", questionData);
			request.setAttribute("QUESTION_FILES", questionFiles);
			request.setAttribute("VIEWURL", "forward:/management/qnamanagement/writeAnswer.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void getAnswerList(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			String managerId = request.getAttribute("MANAGER_ID").toString();
			int beginIndex = Integer.parseInt(request.getAttribute("BEGIN_INDEX").toString());
			int endIndex = Integer.parseInt(request.getAttribute("END_INDEX").toString());
			ArrayList<QnaDTO> list = qnaDAO.getAnswerList(managerId, beginIndex, endIndex);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int i = 0; i < list.size(); ++i)
			{
				JSONObject data = new JSONObject();
				JSONObject answer = new JSONObject();
				JSONObject question = new JSONObject();

				question.put("question_code", list.get(i).getQuestion_code());
				question.put("questioner_id", list.get(i).getUser_id());

				answer.put("answer_code", list.get(i).getAnswer_code());
				answer.put("subject", list.get(i).getSubject());
				answer.put("category", list.get(i).getCategory_desc());
				answer.put("post_date", list.get(i).getPost_date());

				data.put("QUESTION", question);
				data.put("ANSWER", answer);
				rootArr.put(data);
			}

			rootObj.put("POST_DATA", rootArr);
			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void getAnswerPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			int questionCode = Integer.parseInt(request.getAttribute("QUESTION_CODE").toString());
			int answerCode = Integer.parseInt(request.getAttribute("ANSWER_CODE").toString());
			String managerId = request.getAttribute("ANSWERER_ID").toString();
			String questionerId = request.getAttribute("QUESTIONER_ID").toString();

			QnaDTO questionData = qnaDAO.getQuestionPost(questionerId, questionCode);
			QnaDTO answerData = qnaDAO.getAnswerPost(managerId, answerCode);

			request.setAttribute("QUESTION_DATA", questionData);
			request.setAttribute("ANSWER_DATA", answerData);
			request.setAttribute("VIEWURL", "forward:/management/qnamanagement/viewPost.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void getListSize(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");
			String tableType = request.getAttribute("TABLE_TYPE").toString();
			int listSize = qnaDAO.getListSize(null, tableType);

			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(String.valueOf(listSize));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}