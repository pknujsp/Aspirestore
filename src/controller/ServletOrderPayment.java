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
import model.AddressDAO;
import model.AddressDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.OrderPaymentDAO;
import model.OrderhistoryDTO;
import model.SalehistoryDTO;
import model.UserDAO;
import model.UserDTO;

public class ServletOrderPayment extends HttpServlet
{
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();
			final String userId = (String) request.getSession().getAttribute("SESSIONKEY");

			UserDTO requestUserData = (UserDTO) request.getAttribute("USER_INFO_REQUEST");
			UserDTO sessionUserData = (UserDTO) request.getSession().getAttribute("USER_INFO_SESSION");
			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");

			if (sessionUserData != null) // 최초 주문 X
			{
				// true - 주문자 정보가 수정된 경우
				if (!(requestUserData.getUser_name().equals(sessionUserData.getUser_name())
						&& requestUserData.getMobile1().equals(sessionUserData.getMobile1())
						&& requestUserData.getMobile2().equals(sessionUserData.getMobile2())
						&& requestUserData.getMobile3().equals(sessionUserData.getMobile3())
						&& requestUserData.getGeneral1().equals(sessionUserData.getGeneral1())
						&& requestUserData.getGeneral2().equals(sessionUserData.getGeneral2())
						&& requestUserData.getGeneral3().equals(sessionUserData.getGeneral3())))
				{
					request.getSession().removeAttribute("USER_INFO_SESSION");
					userDao.updateUserInfo(requestUserData);
				}
			} else // 최초 주문 O
			{
				userDao.insertUserInfo(requestUserData);
			}

			AddressDAO addressDAO = (AddressDAO) servletContext.getAttribute("ADDRESS_DAO");

			if (request.getAttribute("NEW_ADDRESS") != null)   // 신규 입력
			{
				AddressDTO address = (AddressDTO) request.getAttribute("NEW_ADDRESS");
				addressDAO.insertAddressToBook(address);
			} else
			{
				addressDAO.updateLastUsageDateTime(userId, Integer.parseInt((String)request.getAttribute("address_code")));
			}

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