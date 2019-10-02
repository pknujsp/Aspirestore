package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import etc.OrderInformation;
import model.ItemsDTO;
import model.OrderPaymentDAO;

public class ServletCreateOrderForm extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			@SuppressWarnings("unchecked")
			ArrayList<OrderInformation> informations = (ArrayList<OrderInformation>) request
					.getAttribute("ORDER_INFORMATIONS");

			OrderPaymentDAO orderPaymentDAO = (OrderPaymentDAO) servletContext.getAttribute("ORDER_PAYMENT_DAO");
			ArrayList<ItemsDTO> items = orderPaymentDAO.getItemsInfo(informations);

			request.setAttribute("ITEMS", items);
			request.setAttribute("ORDER_INFORMATIONS", informations);
			request.setAttribute("VIEWURL", "forward:/order/orderform.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}
