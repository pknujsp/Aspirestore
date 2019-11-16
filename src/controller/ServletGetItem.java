package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AuthorDAO;
import model.AuthorDTO;
import model.FileDAO;
import model.FileDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.PublisherDAO;

public class ServletGetItem extends HttpServlet
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			String ccode = request.getAttribute("CCODE").toString();
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			ItemsDAO dao = (ItemsDAO) servletContext.getAttribute("itemsDAO");
			FileDAO fileDAO = (FileDAO) servletContext.getAttribute("FILE_DAO");
			
			ItemsDTO item = dao.getItem(ccode, icode);

			AuthorDAO authordao = (AuthorDAO) servletContext.getAttribute("authorDAO");
			int acode = item.getItem_author_code();

			AuthorDTO author = authordao.getAuthorInformation(acode);

			PublisherDAO publisherDAO = (PublisherDAO) servletContext.getAttribute("PUBLISHER_DAO");
			String publisherName = publisherDAO.getPublisherName(item.getItem_publisher_code());
			
			ArrayList<FileDTO> images = fileDAO.getItemImages(icode, ccode);

			for (int index = 0; index < images.size(); ++index)
			{
				if (images.get(index).getImage_position().equals("MAIN"))
				{
					request.setAttribute("MAIN_IMAGE", images.get(index));
				} else if (images.get(index).getImage_position().equals("INFO"))
				{
					request.setAttribute("INFO_IMAGE", images.get(index));
				}
			}

			request.setAttribute("PUBLISHER_NAME", publisherName);
			request.setAttribute("AUTHOR", author);
			request.setAttribute("ITEM", item);
			request.setAttribute("VIEWURL", "forward:/items/item.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		this.doGet(request, response);
	}
}