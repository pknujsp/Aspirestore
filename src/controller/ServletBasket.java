package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AuthorDAO;
import model.AuthorDTO;
import model.BasketDAO;
import model.BasketDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.PublisherDAO;
import model.PublisherDTO;

public class ServletBasket extends HttpServlet
{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "ADD":
			addBookToTheBasket(request, response);
			break;

		case "DELETE":
			deleteBooksFromBasket(request, response);
			break;

		case "GET_BASKET":
			getBasket(request, response);
			break;
		}
	}

	protected void addBookToTheBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");
			BasketDTO data = (BasketDTO) request.getAttribute("BOOK_TO_ADD");
			basketDAO.addBookToTheBasket(data);

			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void deleteBooksFromBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");

			@SuppressWarnings("unchecked")
			ArrayList<BasketDTO> list = (ArrayList<BasketDTO>) request.getAttribute("BOOKS_TO_BE_DELETED");
			basketDAO.deleteBooksFromBasket(list);

			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("ITEMS_DAO");
			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) sc.getAttribute("PUBLISHER_DAO");

			ArrayList<BasketDTO> basket = basketDAO
					.getBasket(request.getSession().getAttribute("SESSIONKEY").toString()); // 장바구니

			Map<Integer, String> codeMap = new HashMap<Integer, String>(basket.size()); // itemCode, categoryCode

			for (int i = 0; i < basket.size(); ++i)
			{
				codeMap.put(basket.get(i).getItem_code(), basket.get(i).getCategory_code());
			}

			ArrayList<ItemsDTO> items = itemsDAO.getitemsForBasket(codeMap); // 아이템 정보

			ArrayList<Integer> authorCodes = new ArrayList<Integer>(items.size());
			ArrayList<Integer> publisherCodes = new ArrayList<Integer>(items.size());

			for (int i = 0; i < items.size(); ++i)
			{
				authorCodes.add(items.get(i).getItem_author_code());
				publisherCodes.add(items.get(i).getItem_publisher_code());
			}

			ArrayList<AuthorDTO> authors = authorDAO.getAuthors(authorCodes); // 저자 정보
			ArrayList<PublisherDTO> publishers = publisherDAO.getPublishers(publisherCodes); // 출판사 정보

			request.setAttribute("ITEMS", items);
			request.setAttribute("AUTHORS", authors);
			request.setAttribute("PUBLISHERS", publishers);
			request.setAttribute("BASKET", basket);
			request.setAttribute("VIEWURL", "forward:/basket.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}