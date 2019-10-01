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

import etc.OrderInformation;
import model.ItemsDTO;
import model.OrderPaymentDTO;
import model.SignupDTO;

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

			case "/payment.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/payment";

					OrderPaymentDTO orderPaymentDTO = new OrderPaymentDTO();

					orderPaymentDTO.setSalehistory_address(request.getParameter("address"));
					orderPaymentDTO.setSalehistory_payment_method(request.getParameter("payment_method"));
					orderPaymentDTO.setSalehistory_requested_term(request.getParameter("requested_term"));

					request.setAttribute("ORDERPAYMENTDTO", orderPaymentDTO);
				}
				break;

			case "/orderform.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/orderform";

					ArrayList<OrderInformation> orderInformations = new ArrayList<OrderInformation>();

					if (request.getAttribute("orderInformation") != null)
					{
						orderInformations.add((OrderInformation) request.getAttribute("orderInformation"));
						orderInformations.get(0).setOrder_quantity(Integer.parseInt(request.getParameter("quantity")));
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
