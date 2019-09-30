package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ItemsDAO;

import model.ItemsDTO;

public class ServletShowItems extends HttpServlet
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			String ccode = (String) request.getAttribute("CCODE");
			String cpcode = (String) request.getAttribute("CPCODE");
			ItemsDAO dao = (ItemsDAO) servletContext.getAttribute("itemsDAO");
			ArrayList<ItemsDTO> bookList = dao.getItemList(Integer.parseInt(ccode));

			request.setAttribute("BOOKLIST", bookList);
			request.setAttribute("VIEWURL", "forward:/items/itemlist.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

	}

}
