package controller;

import java.io.BufferedReader;
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

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import etc.ImageFileRenamePolicy;
import etc.MULTIPART_REQUEST;
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

					if (request.getAttribute("ICODE") == null)
					{
						// 상세 리뷰 작성 이후 X
						request.setAttribute("CCODE", request.getParameter("ccode"));
						request.setAttribute("ICODE", request.getParameter("icode"));
					}
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
					String type = null;

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
					} else
					{
						// 글 작성이 아닌 경우
						type = request.getParameter("type").toString();
					}

					request.setAttribute("TYPE", type);

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
					case "GET_QUESTION_LIST_MANAGEMENT": // 답변글 목록 가져오기
						request.setAttribute("BEGIN_INDEX", request.getParameter("begin_index"));
						request.setAttribute("END_INDEX", request.getParameter("end_index"));
						request.setAttribute("VIEW_CONDITION", request.getParameter("view_condition"));
						break;
					case "GET_RECORDS_SIZE": // 목록 레코드의 크기 가져오기
						// answer, question를 class로 나눔
						request.setAttribute("TABLE_TYPE", request.getParameter("table_type"));
						request.setAttribute("STATUS", request.getParameter("question_status"));
						break;
					case "GET_POST": // 글 읽기
						request.setAttribute("USER_ID", userId);
						request.setAttribute("QUESTION_CODE", request.getParameter("question_code"));
						request.setAttribute("CURRENT_PAGE", request.getParameter("current_page"));
						break;
					case "CREATE_ANSWER_FORM": // 답변 페이지 생성
						request.setAttribute("CUSTOMER_ID", request.getParameter("questioner_id"));
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
			case "/csservice/applyPost.aspire":
				// 질문, 답변 글 등록 서블릿
				pageControllerPath = "/csservice/applyPost";

				final String SAVEFOLDER = "C:/programming/eclipseprojects/AspireStore/WebContent/qnaImages";
				final String ENCTYPE = "UTF-8";
				final int MAXSIZE = 10 * 1024 * 1024;

				MultipartRequest multipartRequest = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE,
						new ImageFileRenamePolicy());

				String type = multipartRequest.getParameter("type");
				request.setAttribute("TYPE", type);
				request.setAttribute("MULTI_REQUEST", multipartRequest);

				switch (type)
				{
				case "QUESTION":
					request.setAttribute("QUESTIONER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
					request.setAttribute("SUBJECT", multipartRequest.getParameter("inputSubject"));
					request.setAttribute("CONTENT", multipartRequest.getParameter("textareaContent"));
					request.setAttribute("CATEGORY", Integer.parseInt(multipartRequest.getParameter("selectCategory")));

					break;
				case "ANSWER":
					request.setAttribute("ANSWERER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
					request.setAttribute("QUESTIONER_ID", multipartRequest.getParameter("questionerId"));
					request.setAttribute("QUESTION_CODE",
							Integer.parseInt(multipartRequest.getParameter("question_code")));
					request.setAttribute("SUBJECT", multipartRequest.getParameter("inputSubject"));
					request.setAttribute("CATEGORY", Integer.parseInt(multipartRequest.getParameter("inputCategory")));
					request.setAttribute("CONTENT", multipartRequest.getParameter("textareaContent"));
					break;
				}
				break;

			case "/files/fileManagement.aspire":
				if (checkNullParameters())
				{
					// 파일 다운로드
					pageControllerPath = "/files/fileManagement";
					request.setAttribute("FILE_URI", request.getParameter("file_uri"));
				}
				break;

			case "/items/review.aspire":
				if (checkNullParameters())
				{
					String rtype = null;

					if (request.getParameter("type") == null)
					{
						rtype = "APPLY_D_REVIEW";
					} else
					{
						rtype = request.getParameter("type");
					}
					request.setAttribute("TYPE", rtype);

					pageControllerPath = "/items/review";

					switch (rtype)
					{
					case "GET_S_REVIEW_SIZE":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						break;
					case "GET_D_REVIEW_SIZE":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						break;
					case "READ_D_REVIEW":
						request.setAttribute("RCODE", request.getParameter("rcode"));
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						break;
					case "GET_S_REVIEW_JSON":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						request.setAttribute("BEGIN_INDEX", request.getParameter("begin_index"));
						request.setAttribute("END_INDEX", request.getParameter("end_index"));
						break;
					case "GET_D_REVIEW_JSON":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						request.setAttribute("BEGIN_INDEX", request.getParameter("begin_index"));
						request.setAttribute("END_INDEX", request.getParameter("end_index"));
						break;
					case "APPLY_S_REVIEW":
						request.setAttribute("WRITER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
						request.setAttribute("RATING", request.getParameter("rating"));
						request.setAttribute("CONTENT", request.getParameter("content"));
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						break;
					case "APPLY_D_REVIEW":
						MultipartRequest multipartRequest_R = new MultipartRequest(request,
								MULTIPART_REQUEST.SAVE_FOLDER.getName(),
								Integer.parseInt(MULTIPART_REQUEST.MAX_SIZE.getName()),
								MULTIPART_REQUEST.ENC_TYPE.getName(), new ImageFileRenamePolicy());

						request.setAttribute("TYPE", multipartRequest_R.getParameter("type"));
						request.setAttribute("MULTI_REQUEST", multipartRequest_R);
						request.setAttribute("WRITER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
						request.setAttribute("SUBJECT", multipartRequest_R.getParameter("subject"));
						request.setAttribute("RATING", multipartRequest_R.getParameter("rating"));
						request.setAttribute("CONTENT", multipartRequest_R.getParameter("content"));
						request.setAttribute("ICODE", multipartRequest_R.getParameter("icode"));
						request.setAttribute("CCODE", multipartRequest_R.getParameter("ccode"));
						break;
					case "DELETE":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						request.setAttribute("REVIEW_CODE", request.getParameter("review_code"));
						request.setAttribute("TABLE_TYPE", request.getParameter("table_type"));
						request.setAttribute("WRITER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
						break;
					case "MODIFY":
						request.setAttribute("ICODE", request.getParameter("icode"));
						request.setAttribute("CCODE", request.getParameter("ccode"));
						request.setAttribute("REVIEW_CODE", request.getParameter("review_code"));
						request.setAttribute("TABLE_TYPE", request.getParameter("table_type"));
						request.setAttribute("WRITER_ID", request.getSession().getAttribute("SESSIONKEY").toString());
						break;
					}
				}
				break;

			case "/management/bookManagement.aspire":
				if (checkNullParameters())
				{
					// bookList에서 받은 카테고리 JSON Data 처리
					String requestedType = null;
					String contentType = request.getContentType();

					if (contentType == null)
					{
						// GET
						requestedType = request.getParameter("type");
						request.setAttribute("TYPE", requestedType);
					} else if (contentType.equals("application/x-www-form-urlencoded"))
					{
						// POST
						requestedType = request.getParameter("type");
						request.setAttribute("TYPE", requestedType);
					} else if (contentType.equals("application/json"))
					{
						BufferedReader reader = request.getReader();
						JSONTokener tokener = new JSONTokener(reader);
						JSONArray jsonArr = new JSONArray(tokener);
						JSONObject parameterObj = jsonArr.getJSONObject(0);

						requestedType = parameterObj.getString("type");
						request.setAttribute("TYPE", requestedType);
						request.setAttribute("JSON_ARR", jsonArr);
					}
					pageControllerPath = "/management/bookManagement";

					switch (requestedType)
					{
					case "GET_TOTAL_RECORDS":
						break;

					case "GET_RECORDS":
						break;

					case "VIEW_MORE_DATA":
						request.setAttribute("ICODE", request.getParameter("book_code"));
						request.setAttribute("CCODE", request.getParameter("book_category_code"));
						break;

					case "MODIFY_DATA":
						request.setAttribute("ICODE", request.getParameter("book_code"));
						request.setAttribute("CCODE", request.getParameter("book_category_code"));
						break;

					case "UPDATE_DATA":
						break;
					}
				}
				break;

			case "/management/authorManagement.aspire":
				if (checkNullParameters())
				{
					String requestedType = request.getParameter("type");
					request.setAttribute("TYPE", requestedType);
					pageControllerPath = "/management/authorManagement";

					switch (requestedType)
					{
					case "GET_AUTHORS":
						request.setAttribute("AUTHOR_NAME", request.getParameter("author_name"));
						break;
					}
				}
				break;

			case "/management/publisherManagement.aspire":
				if (checkNullParameters())
				{
					String requestedType = request.getParameter("type");
					request.setAttribute("TYPE", requestedType);
					pageControllerPath = "/management/publisherManagement";

					switch (requestedType)
					{
					case "GET_PUBLISHERS":
						request.setAttribute("PUBLISHER_NAME", request.getParameter("publisher_name"));
						break;
					}
				}
				break;

			case "/management/bookImgManagement.aspire":
				MultipartRequest imgRequest = new MultipartRequest(request, MULTIPART_REQUEST.BOOKIMG_SAVE_FOLDER.getName(),
						Integer.parseInt(MULTIPART_REQUEST.MAX_SIZE.getName()), MULTIPART_REQUEST.ENC_TYPE.getName(),
						new ImageFileRenamePolicy());

				String imgType = imgRequest.getParameter("type");
				request.setAttribute("TYPE", imgType);
				request.setAttribute("IMG_REQUEST", imgRequest);

				pageControllerPath = "/management/bookImgManagement";

				switch (imgType)
				{
				case "UPDATE_INFO_IMG":
					break;
				case "UPDATE_MAIN_IMG":
					break;
				}
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