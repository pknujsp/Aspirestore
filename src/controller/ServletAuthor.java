package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AuthorDAO;
import model.AuthorDTO;

public class ServletAuthor extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		authorInfo(request, response);
	}

	protected void authorInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");

			int acode = Integer.parseInt(request.getAttribute("ACODE").toString());

			AuthorDTO author = authorDAO.getAuthorInformation(acode);

			request.setAttribute("AUTHOR", author);
			request.setAttribute("VIEWURL", "forward:/author/authorInfo.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}