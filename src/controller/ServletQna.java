package controller;

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

import org.json.JSONArray;
import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.ImageDTO;
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
		case "APPLY_ANSWER":
			applyAnswer(request, response);
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
		case "APPLY_QUESTION":
			applyQuestion(request, response);
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

			if (questionPostData.getStatus().equals("답변 완료"))
			{
				answerData = qnaDAO.getAnswerPost(questionCode);
			}

			request.setAttribute("CURRENT_PAGE", currentPage);
			request.setAttribute("QUESTION_DATA", questionPostData);
			request.setAttribute("ANSWER_DATA", answerData);
			request.setAttribute("VIEWURL", "forward:/csservice/viewCPost.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private void applyAnswer(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		final String SAVEFOLDER = "C:/programming/eclipseprojects/AspireStore/WebContent/qnaiImages";
		final String ENCTYPE = "UTF-8";
		final int MAXSIZE = 10 * 1024 * 1024;
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			MultipartRequest multipartRequest = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());

			@SuppressWarnings("rawtypes")
			Enumeration files = multipartRequest.getFileNames();

			ArrayList<ImageDTO> fileList = new ArrayList<ImageDTO>();

			String currentTime = etc.Util.getCurrentDateTime();
			String managerId = request.getAttribute("MANAGER_ID").toString();
			int questionCode = Integer.parseInt(multipartRequest.getParameter("question_code"));
			String subject = multipartRequest.getParameter("inputSubject");
			int categoryCode = Integer.parseInt(multipartRequest.getParameter("inputCategory"));
			String content = multipartRequest.getParameter("textareaContent");

			// 파일 첨부가 된 경우
			while (files.hasMoreElements())
			{
				String file = (String) files.nextElement();
				String fileName = multipartRequest.getFilesystemName(file);

				fileList.add(new ImageDTO().setFile_name(fileName)
						.setFile_size((int) multipartRequest.getFile(fileName).length()).setFile_uri(SAVEFOLDER)
						.setUploaded_date_time(currentTime).setUploader_id(managerId));
			}

			QnaDTO answerData = new QnaDTO().setQuestion_code(questionCode).setUser_id(managerId).setSubject(subject)
					.setCategory_code(categoryCode).setContent(content).setPost_date(currentTime)
					.setNumFiles(fileList.size()).setIp("1111");

			int answerCode = qnaDAO.applyAnswer(answerData, 'a');

			if (!fileList.isEmpty())
			{
				// 첨부 파일이 존재하는 경우 DB에 파일정보 저장
				qnaDAO.uploadFiles(fileList, answerCode);
			}

			request.setAttribute("VIEWURL", "redirect:/management/qnamanagement/answerlist.jsp");
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

			String customerId = request.getAttribute("CUSTOMER_ID").toString();
			int questionCode = Integer.parseInt(request.getAttribute("QUESTION_CODE").toString());

			// questionCode, customerId를 가지고 문의글 데이터를 가져온다.
			QnaDTO questionData = qnaDAO.getQuestionPost(customerId, questionCode);

			request.setAttribute("QUESTION_DATA", questionData);
			request.setAttribute("VIEWURL", "forward:/management/qnamanagement/answerpost.jsp");
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

	private void applyQuestion(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		final String SAVEFOLDER = "C:/programming/eclipseprojects/AspireStore/WebContent/qnaiImages";
		final String ENCTYPE = "UTF-8";
		final int MAXSIZE = 10 * 1024 * 1024;
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			MultipartRequest multipartRequest = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());

			@SuppressWarnings("rawtypes")
			Enumeration files = multipartRequest.getFileNames();

			ArrayList<ImageDTO> fileList = new ArrayList<ImageDTO>();

			String currentTime = etc.Util.getCurrentDateTime();
			String questionerId = request.getAttribute("QUESTIONER_ID").toString();
			String subject = multipartRequest.getParameter("inputSubject");
			String content = multipartRequest.getParameter("textareaContent");
			int categoryCode = Integer.parseInt(multipartRequest.getParameter("selectCategory"));

			// 파일 첨부가 된 경우
			while (files.hasMoreElements())
			{
				String file = (String) files.nextElement();
				String fileName = multipartRequest.getFilesystemName(file);

				fileList.add(new ImageDTO().setFile_name(fileName)
						.setFile_size((int) multipartRequest.getFile(fileName).length()).setFile_uri(SAVEFOLDER)
						.setUploaded_date_time(currentTime).setUploader_id(questionerId));
			}

			QnaDTO questionData = new QnaDTO().setUser_id(questionerId).setSubject(subject)
					.setCategory_code(categoryCode).setContent(content).setPost_date(currentTime).setIp("1111")
					.setStatus("n").setNumFiles(fileList.size());

			int questionCode = qnaDAO.applyAnswer(questionData, 'q');

			if (!fileList.isEmpty())
			{
				// 첨부 파일이 존재하는 경우 DB에 파일정보 저장
				qnaDAO.uploadFiles(fileList, questionCode);
			}

			request.setAttribute("type", "GET_QUESTION_POST");
			request.setAttribute("current_page", "1");
			request.setAttribute("question_code", String.valueOf(questionCode));
			request.setAttribute("VIEWURL", "forward:/csservice/qna.aspire");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}