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
import model.OrderPaymentDTO;

public class ServletOrderPayment extends HttpServlet
{
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			OrderPaymentDTO dto = (OrderPaymentDTO) request.getAttribute("ORDERPAYMENTDTO");
			ArrayList<OrderInformation> orderInformations = (ArrayList<OrderInformation>) request
					.getAttribute("ORDERINFORMATIONS");

			OrderPaymentDAO dao = (OrderPaymentDAO) servletContext.getAttribute("orderpaymentDAO");
			String userId = request.getSession().getId();

			if (dao.orderPayment(dto, orderInformations, userId))
			{
				request.setAttribute("VIEWURL", "redirect:/payment/orderresult.jsp");
			}

		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

}