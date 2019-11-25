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
import model.AddressDAO;
import model.AddressDTO;
import model.AuthorDAO;
import model.AuthorDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.OrderPaymentDAO;
import model.OrderhistoryDTO;
import model.PublisherDAO;
import model.PublisherDTO;
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
			final String userId = request.getSession().getAttribute("SESSIONKEY").toString();

			// orderform페이지에서 전달받은 주문자 정보 데이터
			UserDTO requestUserData = (UserDTO) request.getAttribute("USER_INFO_REQUEST");

			// DB에 존재하는 주문자 정보 데이터
			UserDTO sessionUserData = (UserDTO) request.getSession().getAttribute("USER_INFO_SESSION");

			// 주문할 도서목록 (코드, 수량)
			ArrayList<ItemsDTO> books = (ArrayList<ItemsDTO>) request.getAttribute("BOOKS");

			UserDAO userDao = (UserDAO) servletContext.getAttribute("USER_DAO");
			AddressDAO addressDAO = (AddressDAO) servletContext.getAttribute("ADDRESS_DAO");
			OrderPaymentDAO orderPaymentDAO = (OrderPaymentDAO) servletContext.getAttribute("ORDER_PAYMENT_DAO");
			ItemsDAO itemsDAO = (ItemsDAO) servletContext.getAttribute("itemsDAO");

			if (sessionUserData != null)
			{
				// 최초 주문이 아닌 경우에 orderform페이지와 DB의 주문자 정보 데이터를 비교한다
				// true - 주문자 정보가 수정된 경우
				if (!(requestUserData.getUser_name().equals(sessionUserData.getUser_name())
						&& requestUserData.getMobile1().equals(sessionUserData.getMobile1())
						&& requestUserData.getMobile2().equals(sessionUserData.getMobile2())
						&& requestUserData.getMobile3().equals(sessionUserData.getMobile3())
						&& requestUserData.getGeneral1().equals(sessionUserData.getGeneral1())
						&& requestUserData.getGeneral2().equals(sessionUserData.getGeneral2())
						&& requestUserData.getGeneral3().equals(sessionUserData.getGeneral3())))
				{
					// 주문자 정보가 수정된 경우 DB내의 정보를 orderform에서 작성된 데이터로 갱신한다
					request.getSession().removeAttribute("USER_INFO_SESSION");
					userDao.updateUserInfo(requestUserData);
				}
			} else // 최초 주문 인 경우
			{
				// DB에 주문자 정보를 저장한다
				userDao.insertUserInfo(requestUserData);
			}

			if (request.getAttribute("NEW_ADDRESS") != null)
			{
				// 배송지 신규 입력인 경우
				// 배송지 정보를 DB에 저장한다
				AddressDTO address = (AddressDTO) request.getAttribute("NEW_ADDRESS");
				addressDAO.insertAddressToBook(address);
			} else
			{
				// 배송지 정보의 사용시간을 갱신한다
				addressDAO.updateLastUsageDateTime(userId,
						Integer.parseInt((String) request.getAttribute("address_code")));
			}

			// 수령자 정보, 배송지 정보, 주문자 정보, 배송 수단, 결제 수단 데이터
			OrderhistoryDTO orderFormData = (OrderhistoryDTO) request.getAttribute("ORDER_FORM_DATA");
			OrderhistoryDTO orderHistory = null;
			ArrayList<SalehistoryDTO> saleHistory = null;

			int totalPriceDB = itemsDAO.calculateTotalPrice(books);

			if (totalPriceDB == orderFormData.getTotal_price())
			{
				// orderhistory, salehistory 테이블에 주문 정보 저장
				orderPaymentDAO.requestOrderProcessing(orderFormData, books);
			} else
			{
				// ERROR
			}

			// 주문 정보, 도서 정보 세션 저장소에 저장
			orderHistory = orderPaymentDAO.getLatestOrderInfo(userId);
			saleHistory = orderPaymentDAO.getSaleHistory(orderHistory.getOrder_code(), userId);

			HttpSession session = request.getSession();

			session.setAttribute("ORDER_HISTORY", orderHistory);
			session.setAttribute("SALE_HISTORY", saleHistory);
			request.setAttribute("VIEWURL", "redirect:/AspireStore/order/confirmorder.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

}