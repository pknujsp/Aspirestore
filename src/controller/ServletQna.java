package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

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
		case "GET_QUESTION_LIST_SIZE": // 문의글 목록 가져오기
			getQuestionListSize(request, response);
			break;
		case "GET_QUESTION_POST": // 글 읽기
			getQuestionPost(request, response);
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
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			ArrayList<QnaDTO> questionList = qnaDAO.getQuestionList(userId);

			request.setAttribute("QUESTION_LIST", questionList);
			request.setAttribute("VIEWURL", "return:/csservice/csconsult.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
	
	private void getQuestionListSize(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			String userId = request.getAttribute("USER_ID").toString();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			int listSize = qnaDAO.getQuestionListSize(userId);

			request.setAttribute("QUESTION_LIST_SIZE", listSize);
			request.setAttribute("VIEWURL", "return:/csservice/csconsult.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
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

			QnaDTO questionPostData = qnaDAO.getQuestionPost(userId, questionCode);

			request.setAttribute("QUESTION_POST_DATA", questionPostData);
			request.setAttribute("VIEWURL", "forward:/csservice/viewquestion.jsp");

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}