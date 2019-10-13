package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import etc.OrderInformation;
import model.ItemsDAO;
import model.ItemsDTO;
import model.OrderPaymentDAO;
import model.OrderhistoryDTO;
import model.SalehistoryDTO;

public class ServletOrderPayment extends HttpServlet
{
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			OrderhistoryDTO orderFromData = (OrderhistoryDTO) request.getAttribute("ORDER_FORM_DATA");
			ArrayList<OrderInformation> orderedItems = (ArrayList<OrderInformation>) request
					.getAttribute("ORDERED_ITEMS");

			OrderPaymentDAO orderPaymentDAO = (OrderPaymentDAO) servletContext.getAttribute("ORDER_PAYMENT_DAO");
			int[] codes = orderPaymentDAO.requestOrderProcessing(orderFromData, orderedItems,
					orderFromData.getUser_id());

			request.getSession().setAttribute("ORDER_SALE_CODES", codes);
			request.setAttribute("VIEWURL", "redirect:/AspireStore/confirm/confirmorder.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}