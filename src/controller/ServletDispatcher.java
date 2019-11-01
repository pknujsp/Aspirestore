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

import com.oreilly.servlet.MultipartRequest;

import etc.OrderInformation;
import model.AddressDTO;
import model.BasketDTO;
import model.ItemsDTO;
import model.OrderhistoryDTO;
import model.SalehistoryDTO;
import model.SignupDTO;
import model.UserDTO;

@SuppressWarnings("serial")
public class ServletDispatcher extends HttpServlet
{
	private HttpServletRequest request = null;

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
									request.getParameter("SetBirthdate"), request.getParameter("InputPhoneNumber1"),
									request.getParameter("InputPhoneNumber2"),
									request.getParameter("InputPhoneNumber3"), request.getParameter("InputGender")));
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
					String userId = request.getSession().getAttribute("SESSIONKEY").toString();

					request.setAttribute("USER_INFO_REQUEST",
							new UserDTO().setUser_id(userId).setMobile1(request.getParameter("orderer_mobile_1"))
									.setMobile2(request.getParameter("orderer_mobile_2"))
									.setMobile3(request.getParameter("orderer_mobile_3"))
									.setGeneral1(request.getParameter("orderer_general_1_select"))
									.setGeneral2(request.getParameter("orderer_general_2"))
									.setGeneral3(request.getParameter("orderer_general_3"))
									.setUser_name(request.getParameter("orderer_name")));

					request.setAttribute("ORDER_FORM_DATA",
							new OrderhistoryDTO().setOrderer_name(request.getParameter("orderer_name"))
									.setOrderer_mobile1(request.getParameter("orderer_mobile_1"))
									.setOrderer_mobile2(request.getParameter("orderer_mobile_2"))
									.setOrderer_mobile3(request.getParameter("orderer_mobile_3"))
									.setOrderer_general1(request.getParameter("orderer_general_1_select"))
									.setOrderer_general2(request.getParameter("orderer_general_2"))
									.setOrderer_general3(request.getParameter("orderer_general_3"))
									.setOrderer_email(request.getParameter("orderer_email"))
									.setRecepient_name(request.getParameter("recepient_name"))
									.setRecepient_mobile1(request.getParameter("recepient_mobile_1"))
									.setRecepient_mobile2(request.getParameter("recepient_mobile_2"))
									.setRecepient_mobile3(request.getParameter("recepient_mobile_3"))
									.setRecepient_general1(request.getParameter("recepient_general_1_select"))
									.setRecepient_general2(request.getParameter("recepient_general_2"))
									.setRecepient_general3(request.getParameter("recepient_general_3"))
									.setPostal_code(request.getParameter("postal_code"))
									.setRoad(request.getParameter("road_name_address"))
									.setNumber(request.getParameter("number_address"))
									.setDetail(request.getParameter("detail_address"))
									.setPayment_method(request.getParameter("payment_method"))
									.setDelivery_method(request.getParameter("delivery_method"))
									.setRequested_term(request.getParameter("requested_term")).setUser_id(userId)
									.setTotal_price(Integer.parseInt(request.getParameter("total_price"))));

					String[] itemCodes = request.getParameterValues("itemCode[]");
					String[] categoryCodes = request.getParameterValues("categoryCode[]");
					String[] quantity = request.getParameterValues("quantity[]");

					ArrayList<OrderInformation> books = new ArrayList<OrderInformation>(itemCodes.length);

					for (int idx = 0; idx < itemCodes.length; ++idx)
					{
						books.add(new OrderInformation().setItem_code(Integer.parseInt(itemCodes[idx]))
								.setItem_category(categoryCodes[idx])
								.setOrder_quantity(Integer.parseInt(quantity[idx])));
					}

					request.setAttribute("BOOKS", books);

					if (request.getParameter("address_code").equals("")) // 신규 입력
					{
						request.setAttribute("NEW_ADDRESS",
								new AddressDTO().setPostal_code(request.getParameter("postal_code"))
										.setRoad(request.getParameter("road_name_address"))
										.setNumber(request.getParameter("number_address"))
										.setDetail(request.getParameter("detail_address"))
										.setUser_id((String) request.getSession().getAttribute("SESSIONKEY")));
					} else
					{
						request.setAttribute("address_code", request.getParameter("address_code"));
					}
				}
				break;

			case "/orderform.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/orderform";
					String type = request.getParameter("type");
					request.setAttribute("TYPE", type);

					ArrayList<OrderInformation> orderInformations = new ArrayList<OrderInformation>();
					switch (type)
					{
					case "BASKET_ORDER":
						String[] itemCodes = request.getParameterValues("bookCodes[]");
						String[] categoryCodes = request.getParameterValues("bookCategoryCodes[]");

						request.setAttribute("BOOK_CODES", itemCodes);
						request.setAttribute("CATEGORY_CODES", categoryCodes);
						break;

					case "ONE_ORDER":
						int itemCode = Integer.parseInt(request.getParameter("itemCode"));
						String itemCategory = request.getParameter("itemCategory");
						int itemPrice = Integer.parseInt(request.getParameter("itemPrice"));
						int quantity = Integer.parseInt(request.getParameter("quantity"));

						orderInformations
								.add(new OrderInformation().setItem_code(itemCode).setItem_category(itemCategory)
										.setItem_price(itemPrice).setOrder_quantity(quantity).setTotal_price());

						orderInformations.trimToSize();
					}
					request.setAttribute("ORDER_INFORMATIONS", orderInformations);
				}
				break;

			case "/addressbook.aspire":
				if (checkNullParameters())
				{
					request.setAttribute("ID", request.getParameter("ID"));
					request.setAttribute("CODE", request.getParameter("CODE"));
					request.setAttribute("TYPE", request.getParameter("TYPE")); // 0 = 최근주소 1 = 주소 삭제
					pageControllerPath = "/addressbook";
				}
				break;

			case "/basket.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/basket";
					String userId = request.getSession().getAttribute("SESSIONKEY").toString();
					String type = request.getParameter("type");
					request.setAttribute("TYPE", type);

					switch (type)
					{
					case "ADD":
						request.setAttribute("BOOK_TO_ADD",
								new BasketDTO().setUser_id(request.getSession().getAttribute("SESSIONKEY").toString())
										.setItem_code(Integer.parseInt(request.getParameter("itemCode")))
										.setCategory_code(request.getParameter("itemCategory"))
										.setQuantity(Integer.parseInt(request.getParameter("quantity"))));
						break;

					case "DELETE":
						String[] checkedCodes = request.getParameterValues("itemCodes");
						String[] checkedCcodes = request.getParameterValues("categoryCodes");

						ArrayList<BasketDTO> list = new ArrayList<BasketDTO>();

						for (int i = 0; i < checkedCodes.length; ++i)
						{
							list.add(new BasketDTO().setUser_id(userId).setItem_code(Integer.parseInt(checkedCodes[i]))
									.setCategory_code(checkedCcodes[i]));
						}
						request.setAttribute("BOOKS_TO_BE_DELETED", list);
						break;

					case "GET_BASKET":
						break;
					}
				}
				break;
			case "/management/ordersmanagement.aspire":
				if (checkNullParameters())
				{
					pageControllerPath = "/management/ordersmanagement";

					String type = request.getParameter("type");
					request.setAttribute("TYPE", type);

					switch (type)
					{
					case "GET_LIST":
						request.setAttribute("BEGIN_INDEX", request.getParameter("begin_index"));
						request.setAttribute("END_INDEX", request.getParameter("end_index"));
						break;
					case "GET_RECORDS_SIZE":
						break;
					case "PROCESS_SHIPMENT":
						String[] userIdArr = request.getParameterValues("userId");
						String[] orderCodeArr = request.getParameterValues("orderCode");

						request.setAttribute("USER_ID_LIST", userIdArr);
						request.setAttribute("ORDER_CODE_LIST", orderCodeArr);
						break;
					}
				}
				break;

			case "/csservice/qna.aspire":
				if (checkNullParameters())
				{
					String type = request.getParameter("type").toString();

					request.setAttribute("TYPE", type);
					pageControllerPath = "/csservice/qna";
					String userId = request.getSession().getAttribute("SESSIONKEY").toString();

					// 글 작성후 이동할 페이지에서 받을 sessionData
					if (request.getSession().getAttribute("TYPE") != null)
					{
						HttpSession session = request.getSession();

						type = session.getAttribute("TYPE").toString();
						request.setAttribute("CURRENT_PAGE", (int) session.getAttribute("CURRENT_PAGE"));
						request.setAttribute("QUESTION_CODE", (int) session.getAttribute("QUESTION_CODE"));

						session.removeAttribute("CURRENT_PAGE");
						session.removeAttribute("QUESTION_CODE");
						session.removeAttribute("TYPE");
					}

					switch (type)
					{
					case "GET_QUESTION_LIST": // 문의글 목록 가져오기
						request.setAttribute("USER_ID", userId);
						request.setAttribute("CURRENT_PAGE", request.getParameter("current_page"));
						break;
					case "GET_QUESTION_POST":
						request.setAttribute("USER_ID", userId);

						if (request.getAttribute("CURRENT_PAGE") == null)
						{
							// 글 등록 후 이동하는 상황이 아닌 경우
							request.setAttribute("CURRENT_PAGE", request.getParameter("current_page"));
							request.setAttribute("QUESTION_CODE", request.getParameter("question_code"));
						}
						break;
					case "GET_ANSWER_LIST": // 답변글 목록 가져오기
						request.setAttribute("MANAGER_ID", userId);
						request.setAttribute("BEGIN_INDEX", request.getParameter("begin_index"));
						request.setAttribute("END_INDEX", request.getParameter("end_index"));
						break;
					case "GET_RECORDS_SIZE": // 목록 레코드의 크기 가져오기
						// answer, question를 class로 나눔
						request.setAttribute("TABLE_TYPE", request.getParameter("table_type"));
						break;
					case "GET_POST": // 글 읽기
						request.setAttribute("USER_ID", userId);
						request.setAttribute("QUESTION_CODE", request.getParameter("question_code"));
						request.setAttribute("CURRENT_PAGE", request.getParameter("current_page"));
						break;
					case "CREATE_ANSWER_FORM": // 답변 페이지 생성
						request.setAttribute("CUSTOMER_ID", request.getParameter("customer_id"));
						request.setAttribute("QUESTION_CODE", request.getParameter("question_code"));
					case "APPLY_ANSWER": // 답변 등록
						request.setAttribute("MANAGER_ID", userId); // 매니저의 ID
						// 요청 정보는 QnaServlet에서 직접 처리
					case "GET_ANSWER_POST":
						request.setAttribute("QUESTION_CODE", request.getParameter("question_code"));
						request.setAttribute("ANSWER_CODE", request.getParameter("answer_code"));
						request.setAttribute("QUESTIONER_ID", request.getParameter("questioner_id"));
						request.setAttribute("ANSWERER_ID", userId);
						break;
					case "APPLY_QUESTION":
						request.setAttribute("QUESTIONER_ID", userId);
						// 요청 정보는 QnaServlet에서 직접 처리
						break;
					}
				}
				break;
			case "/csservice/applyPost":
				// 질문, 답변 글 등록 서블릿
				break;
			}
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(pageControllerPath);
			requestDispatcher.include(request, response);
			String viewUrl = request.getAttribute("VIEWURL").toString();

			if (viewUrl.startsWith("redirect:"))
			{
				response.sendRedirect(viewUrl.substring(9));

			} else if (viewUrl.startsWith("forward:"))
			{
				requestDispatcher = request.getRequestDispatcher(viewUrl.substring(8));
				requestDispatcher.forward(request, response);
			} else if (viewUrl.startsWith("ajax:"))
			{

			} else
			{
				// include인 경우
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