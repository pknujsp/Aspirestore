package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import etc.OrderInformation;
import model.AuthorDAO;
import model.AuthorDTO;
import model.BasketDAO;
import model.BasketDTO;
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
			String userId = request.getSession().getAttribute("SESSIONKEY").toString();

			BasketDAO basketDAO = (BasketDAO) servletContext.getAttribute("BASKET_DAO");
			OrderPaymentDAO orderPaymentDAO = (OrderPaymentDAO) servletContext.getAttribute("ORDER_PAYMENT_DAO");
			AuthorDAO authorDAO = (AuthorDAO) servletContext.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) servletContext.getAttribute("PUBLISHER_DAO");

			ArrayList<BasketDTO> basket = basketDAO.getBasket(userId);
			ArrayList<ItemsDTO> items = orderPaymentDAO.getItemsInfoBasket(basket);

			ArrayList<OrderInformation> orderInformations = new ArrayList<OrderInformation>(basket.size());

			for (int i = 0; i < basket.size(); ++i)
			{
				orderInformations.add(new OrderInformation().setItem_code(basket.get(i).getItem_code())
						.setItem_category(basket.get(i).getCategory_code())
						.setOrder_quantity(basket.get(i).getQuantity())
						.setItem_price(items.get(i).getItem_selling_price())
						.setTotal_price());
			}
			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");
			UserDTO userData = userDao.getUserInfo(userId);

			ArrayList<Integer> authorCodes = new ArrayList<Integer>(basket.size()); // 저자 코드 리스트
			ArrayList<Integer> publisherCodes = new ArrayList<Integer>(basket.size()); // 출판사 코드 리스트

			for (int i = 0; i < basket.size(); ++i)
			{
				authorCodes.add(items.get(i).getItem_author_code());
				publisherCodes.add(items.get(i).getItem_publisher_code());
			}

			ArrayList<AuthorDTO> authors = authorDAO.getAuthors(authorCodes); // 저자 정보
			ArrayList<PublisherDTO> publishers = publisherDAO.getPublishers(publisherCodes); // 출판사 정보

			if (userData != null) // 최초 주문 X
			{
				request.getSession().setAttribute("USER_INFO_SESSION", userData);
			}
			
			request.setAttribute("ITEMS", items);
			request.setAttribute("AUTHORS", authors);
			request.setAttribute("PUBLISHERS", publishers);
			request.setAttribute("ORDER_INFORMATIONS", orderInformations);
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

			@SuppressWarnings("unchecked")
			ArrayList<OrderInformation> informations = (ArrayList<OrderInformation>) request
					.getAttribute("ORDER_INFORMATIONS");

			OrderPaymentDAO orderPaymentDAO = (OrderPaymentDAO) servletContext.getAttribute("ORDER_PAYMENT_DAO");
			AuthorDAO authorDAO = (AuthorDAO) servletContext.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) servletContext.getAttribute("PUBLISHER_DAO");
			ArrayList<ItemsDTO> items = orderPaymentDAO.getItemsInfo(informations);

			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");
			UserDTO userData = userDao.getUserInfo(userId);

			ArrayList<Integer> authorCodes = new ArrayList<Integer>(items.size()); // 저자 코드 리스트
			ArrayList<Integer> publisherCodes = new ArrayList<Integer>(items.size()); // 출판사 코드 리스트

			for (int i = 0; i < items.size(); ++i)
			{
				authorCodes.add(items.get(i).getItem_author_code());
				publisherCodes.add(items.get(i).getItem_publisher_code());
			}

			ArrayList<AuthorDTO> authors = authorDAO.getAuthors(authorCodes); // 저자 정보
			ArrayList<PublisherDTO> publishers = publisherDAO.getPublishers(publisherCodes); // 출판사 정보

			if (userData != null) // 최초 주문 X
			{
				request.getSession().setAttribute("USER_INFO_SESSION", userData);
			}

			request.setAttribute("ITEMS", items);
			request.setAttribute("AUTHORS", authors);
			request.setAttribute("PUBLISHERS", publishers);
			request.setAttribute("ORDER_INFORMATIONS", informations);
			request.setAttribute("VIEWURL", "forward:/order/orderform.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}