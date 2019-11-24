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

import org.json.JSONArray;
import org.json.JSONObject;

import etc.Util;
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
			ItemsDTO book = (ItemsDTO) request.getAttribute("BOOK_TO_ADD");
			final String userId = request.getSession().getAttribute("SESSIONKEY").toString();
			final String currentTime = Util.getCurrentDateTime();

			JSONArray jsonArr = new JSONArray();
			JSONObject result = new JSONObject();

			if (!basketDAO.checkDuplication(userId, book.getItem_code())) // 중복X
			{
				basketDAO.addBookToTheBasket(book, userId, currentTime);
				result.put("MESSAGE", "장바구니에 추가되었습니다.");
				result.put("RESULT", "true");
			} else
			{
				result.put("MESSAGE", "이 도서는 이미 장바구니에 존재합니다.");
				result.put("RESULT", "false");
			}

			jsonArr.put(result);
			response.setContentType("application/json");
			response.getWriter().write(jsonArr.toString());
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
			BasketDTO basket = (BasketDTO) request.getAttribute("BOOKS_TO_BE_DELETED");
			basketDAO.deleteBooksFromBasket(basket);

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
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			final String userId = request.getSession().getAttribute("SESSIONKEY").toString();

			BasketDTO basket = basketDAO.getBasket(userId); // 장바구니

			request.setAttribute("ITEMS", items);
			request.setAttribute("BASKET", basket);
			request.setAttribute("VIEWURL", "forward:/basket.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}