package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import etc.OrderInformation;
import model.ItemsDTO;
import model.OrderhistoryDTO;
import model.SalehistoryDTO;
import model.SignupDTO;
import model.UserDTO;

public class ServletDispatcher extends HttpServlet
{
	private HttpServletRequest request = null;

	@SuppressWarnings("unchecked")
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String servletPath = request.getServletPath();
		try
		{
			String pageControllerPath = null;
			this.request = request;

			switch (servletPath)
			{
			case "/signup.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/signup";
					request.setAttribute("SIGNUPDTO",
							new SignupDTO(request.getParameter("InputEmail"), request.getParameter("InputPassword"),
									request.getParameter("InputName"), request.getParameter("InputNickName"),
									request.getParameter("SetBirthdate"), request.getParameter("InputPhoneNumber"),
									request.getParameter("InputGender")));
				}
				break;

			case "/signin.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/signin";
					request.setAttribute("EMAIL", request.getParameter("InputEmail"));
					request.setAttribute("PASSWORD", request.getParameter("InputPassword"));
				}
				break;

			case "/logout.aspire":
				pageControllerPath = "/logout";
				break;

			case "/items/itemlist.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/items/itemlist";
					request.setAttribute("CCODE", request.getParameter("ccode"));
					request.setAttribute("CPCODE", request.getParameter("cpcode"));
				}
				break;

			case "/items/item.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/items/item";
					request.setAttribute("CCODE", request.getParameter("ccode"));
					request.setAttribute("ICODE", request.getParameter("icode"));
				}
				break;

			case "/orderpayment.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/orderpayment";

					request.setAttribute("USER_INFO_REQUEST",
							new UserDTO().setUser_id((String) request.getSession().getAttribute("SESSIONKEY"))
									.setMobile1(request.getParameter("orderer_mobile_1"))
									.setMobile2(request.getParameter("orderer_mobile_2"))
									.setMobile3(request.getParameter("orderer_mobile_3"))
									.setGeneral1(request.getParameter("orderer_general_1"))
									.setGeneral2(request.getParameter("orderer_general_2"))
									.setGeneral3(request.getParameter("orderer_general_3"))
									.setUser_name(request.getParameter("orderer_name")));

					request.setAttribute("ORDER_FORM_DATA",
							new OrderhistoryDTO().setOrderer_name(request.getParameter("orderer_name"))
									.setOrderer_mobile1(request.getParameter("orderer_mobile_1"))
									.setOrderer_mobile2(request.getParameter("orderer_mobile_2"))
									.setOrderer_mobile3(request.getParameter("orderer_mobile_3"))
									.setOrderer_general1(request.getParameter("orderer_general_1"))
									.setOrderer_general2(request.getParameter("orderer_general_2"))
									.setOrderer_general3(request.getParameter("orderer_general_3"))
									.setOrderer_email(request.getParameter("orderer_email"))
									.setRecepient_name(request.getParameter("recepient_name"))
									.setRecepient_mobile1(request.getParameter("recepient_mobile_1"))
									.setRecepient_mobile2(request.getParameter("recepient_mobile_2"))
									.setRecepient_mobile3(request.getParameter("recepient_mobile_3"))
									.setRecepient_general1(request.getParameter("recepient_general_1"))
									.setRecepient_general2(request.getParameter("recepient_general_2"))
									.setRecepient_general3(request.getParameter("recepient_general_3"))
									.setPostal_code(request.getParameter("postal_code"))
									.setRoad(request.getParameter("road_name_address"))
									.setNumber(request.getParameter("number_address"))
									.setDetail(request.getParameter("detail_address"))
									.setPayment_method(request.getParameter("payment_method"))
									.setDelivery_method(request.getParameter("delivery_method"))
									.setRequested_term(request.getParameter("requested_term"))
									.setUser_id((String) request.getSession().getAttribute("SESSIONKEY"))
									.setTotal_price(Integer.parseInt(request.getParameter("total_price"))));

					request.setAttribute("ORDERED_ITEMS",
							(ArrayList<OrderInformation>) request.getSession().getAttribute("ORDER_LIST"));
					request.getSession().removeAttribute("ORDER_LIST");

				}
				break;

			case "/orderform.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/orderform";

					ArrayList<OrderInformation> orderInformations = new ArrayList<OrderInformation>();

					if (request.getParameter("itemCode") != null)
					{
						int itemCode = Integer.parseInt(request.getParameter("itemCode"));
						String itemCategory = request.getParameter("itemCategory");
						int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
						int quantity = Integer.parseInt(request.getParameter("quantity"));

						orderInformations
								.add(new OrderInformation().setItem_code(itemCode).setItem_category(itemCategory)
										.setItem_price(itemPrice).setOrder_quantity(quantity).setTotal_price());

						orderInformations.trimToSize();

					} else
					{
						orderInformations = (ArrayList<OrderInformation>) request.getAttribute("orderInformations");
					}
					request.setAttribute("ORDER_INFORMATIONS", orderInformations);
				}
				break;
			}
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(pageControllerPath);
			requestDispatcher.include(request, response);
			String viewUrl = (String) request.getAttribute("VIEWURL");

			if (viewUrl.startsWith("redirect:"))
			{
				response.sendRedirect(viewUrl.substring(9));

			} else if (viewUrl.startsWith("forward:"))
			{
				requestDispatcher = request.getRequestDispatcher(viewUrl.substring(8));
				requestDispatcher.forward(request, response);
			} else
			{
				requestDispatcher = request.getRequestDispatcher(viewUrl);
				requestDispatcher.include(request, response);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	private boolean checkNullParameters()
	{
		Enumeration<String> parameterNames = request.getParameterNames();
		boolean checkNull = true;

		while (parameterNames.hasMoreElements())
		{
			if (request.getParameter(parameterNames.nextElement()) == null)
			{
				checkNull = false;
			}
		}
		return checkNull;
	}
}
