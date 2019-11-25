package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

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
import model.OrderPaymentDAO;
import model.PublisherDAO;
import model.PublisherDTO;
import model.UserDAO;
import model.UserDTO;

public class ServletCreateOrderForm extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		String type = request.getAttribute("TYPE").toString();

		switch (type)
		{
		case "BASKET_ORDER":
			basketOrder(request, response);
			break;

		case "ONE_ORDER":
			oneOrder(request, response);
			break;
		}
	}

	protected void basketOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();
			final String userId = request.getSession().getAttribute("SESSIONKEY").toString();

			BasketDAO basketDAO = (BasketDAO) servletContext.getAttribute("BASKET_DAO");
			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");

			String[] icodes = (String[]) request.getAttribute("BOOK_CODES");
			String[] ccodes = (String[]) request.getAttribute("CATEGORY_CODES");
			HashMap<Integer, String> bookCodeMap = new HashMap<Integer, String>();

			for (int i = 0; i < icodes.length; i++)
			{
				bookCodeMap.put(Integer.valueOf(icodes[i]), ccodes[i]);
			}

			BasketDTO books = basketDAO.getBasket(userId, bookCodeMap);
			UserDTO userData = userDao.getUserInfo(userId);

			if (userData != null) // 최초 주문 X
			{
				request.getSession().setAttribute("USER_INFO_SESSION", userData);
			}

			request.setAttribute("ORDER_BOOKS", books);
			request.setAttribute("VIEWURL", "forward:/order/orderform.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void oneOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();
			String userId = request.getSession().getAttribute("SESSIONKEY").toString();
			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");
			BasketDTO orderBook = (BasketDTO) request.getAttribute("ORDER_BOOK");

			ItemsDAO itemsDAO = (ItemsDAO) servletContext.getAttribute("itemsDAO");

			boolean result = itemsDAO.getBookForOrderForm(orderBook);
			UserDTO userData = userDao.getUserInfo(userId);

			if (result)
			{
				if (userData != null) // 최초 주문 X
				{
					request.getSession().setAttribute("USER_INFO_SESSION", userData);
				}

				request.setAttribute("ORDER_BOOKS", orderBook);
				request.setAttribute("VIEWURL", "forward:/order/orderform.jsp");
			}
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}