package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		case "GET_ANSWER_POST":
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
			int listSize = qnaDAO.getQuestionListSize(userId);
			HashMap<String, Integer> pageData = new HashMap<String, Integer>();

			pageData.put("total_page", 0);
			pageData.put("total_block", 0);
			pageData.put("num_per_page", 1);
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

			Integer answerCode = null;
			// 답변 코드
			if (questionPostData.getStatus().equals("답변 완료"))
			{
				answerCode = qnaDAO.getAnswerCode(questionPostData.getQuestion_code(), userId);
			}

			HashMap<String, Integer> pageData = new HashMap<String, Integer>();
			pageData.put("answer_code", answerCode);
			pageData.put("current_page", currentPage);

			request.setAttribute("QUESTION_PAGE_DATA", pageData);
			request.setAttribute("QUESTION_POST_DATA", questionPostData);
			request.setAttribute("VIEWURL", "forward:/csservice/questionpost.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}