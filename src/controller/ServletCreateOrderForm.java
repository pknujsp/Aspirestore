package controller;

import java.io.IOException;
import java.util.ArrayList;

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

			ArrayList<ItemsDTO> basketData = basketDAO.getBooksFromBasket(userId);
			UserDTO userData = userDao.getUserInfo(userId);

			if (userData != null) // 최초 주문 X
			{
				request.getSession().setAttribute("USER_INFO_SESSION", userData);
			}

			request.setAttribute("BOOKS", basketData);
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

			@SuppressWarnings("unchecked")
			ArrayList<ItemsDTO> orderBooks = (ArrayList<ItemsDTO>) request.getAttribute("ORDER_INFORMATIONS");

			ItemsDAO itemsDAO = (ItemsDAO) servletContext.getAttribute("itemsDAO");
			boolean result = itemsDAO.getBookForOrderForm(orderBooks.get(0));

			UserDTO userData = userDao.getUserInfo(userId);

			if (result)
			{
				if (userData != null) // 최초 주문 X
				{
					request.getSession().setAttribute("USER_INFO_SESSION", userData);
				}

				request.setAttribute("BOOKS", orderBooks);
				request.setAttribute("VIEWURL", "forward:/order/orderform.jsp");
			}
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}