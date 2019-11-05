package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ReviewDAO;

public class ServletItemReview extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_S_REVIEW_SIZE":
			getRecordSize(request, response);
			break;
		case "GET_D_REVIEW_SIZE":
			getRecordSize(request, response);
			break;
		case "GET_S_REVIEW_JSON":
			getSimpleReview(request, response);
			break;
		case "GET_D_REVIEW_JSON":
			getDetailReview(request, response);
			break;
		}
	}

	protected void getRecordSize(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");

			String type = request.getAttribute("TYPE").toString();
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			int size = 0;

			if (type.equals("GET_S_REVIEW_SIZE"))
			{
				// simple
				size = reviewDAO.getRecordSize(icode, ccode, "SIMPLE");
			} else
			{
				// detail
				size = reviewDAO.getRecordSize(icode, ccode, "DETAIL");
			}

			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(String.valueOf(size));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getSimpleReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			int icode = (int) request.getAttribute("ICODE");
			String ccode = request.getAttribute("CCODE").toString();
			int beginIndex = Integer.parseInt(request.getAttribute("BEGIN_INDEX").toString());
			int endIndex = Integer.parseInt(request.getAttribute("END_INDEX").toString());
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getDetailReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{

	}
}