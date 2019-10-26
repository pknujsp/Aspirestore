package controller;

import java.io.IOException;
import java.lang.reflect.Array;
import java.net.HttpRetryException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.OrdersManagementDAO;
import model.OrderhistoryDTO;

public class ServletOrdersManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_LIST":
			getUnprocessedOrderList(request, response);
			break;
		case "PROCESS_SHIPMENT":
			processShipment(request, response);
			break;
		case "GET_RECORDS_SIZE":
			getUnprocessedOrderListSize(request, response);
			break;
		}
	}

	void getUnprocessedOrderList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			OrdersManagementDAO ordersManagementDAO = (OrdersManagementDAO) sc.getAttribute("MANAGEMENT_ORDERS_DAO");

			// 미 처리된 주문 목록을 가져옴(시간 오름차순)
			ArrayList<OrderhistoryDTO> orderDataList = ordersManagementDAO.getUnprocessedOrderList(
					Integer.parseInt(request.getAttribute("BEGIN_INDEX").toString()),
					Integer.parseInt(request.getAttribute("END_INDEX").toString()));

			// 주문 코드에 따른 주문한 도서 목록을 가져온다. (도서 명, 저자 , 출판사, 주문 수량, 판매가, 총 금액, 결제 수단, 배송 수단)
			ArrayList<ArrayList<Map<String, String>>> bookList = ordersManagementDAO.getBookList(orderDataList);

			JSONObject orderData = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int index = 0; index < orderDataList.size(); ++index)
			{
				JSONObject jsonObject = new JSONObject();
				// 주문자 정보, 수령자 정보, 도서 정보, 요청 사항, 배송지 정보는 추가로 감싼다.

				JSONArray bookArr = new JSONArray(); // 도서 정보 배열

				JSONObject ordererData = new JSONObject();
				ordererData.put("ORDERER_NAME", orderDataList.get(index).getOrderer_name());
				ordererData.put("ORDERER_EMAIL", orderDataList.get(index).getOrderer_email());
				ordererData.put("ORDERER_MOBILE1", orderDataList.get(index).getOrderer_mobile1());
				ordererData.put("ORDERER_MOBILE2", orderDataList.get(index).getOrderer_mobile2());
				ordererData.put("ORDERER_MOBILE3", orderDataList.get(index).getOrderer_mobile3());
				ordererData.put("ORDERER_GENERAL1", orderDataList.get(index).getOrderer_general1());
				ordererData.put("ORDERER_GENERAL2", orderDataList.get(index).getOrderer_general2());
				ordererData.put("ORDERER_GENERAL3", orderDataList.get(index).getOrderer_general3());

				JSONObject recepientData = new JSONObject();
				recepientData.put("RECEPIENT_NAME", orderDataList.get(index).getRecepient_name());
				recepientData.put("RECEPIENT_MOBILE1", orderDataList.get(index).getRecepient_mobile1());
				recepientData.put("RECEPIENT_MOBILE2", orderDataList.get(index).getRecepient_mobile2());
				recepientData.put("RECEPIENT_MOBILE3", orderDataList.get(index).getRecepient_mobile3());
				recepientData.put("RECEPIENT_GENERAL1", orderDataList.get(index).getRecepient_general1());
				recepientData.put("RECEPIENT_GENERAL2", orderDataList.get(index).getRecepient_general2());
				recepientData.put("RECEPIENT_GENERAL3", orderDataList.get(index).getRecepient_general3());

				// Map에서 데이터 가져온다.
				for (int j = 0; j < bookList.get(index).size(); ++j)
				{
					String bookName = bookList.get(index).get(j).get("book_name");
					String authorName = bookList.get(index).get(j).get("author_name");
					String publisherName = bookList.get(index).get(j).get("publisher_name");
					String saleQuantity = bookList.get(index).get(j).get("sale_quantity");
					String sellingPrice = bookList.get(index).get(j).get("selling_price");
					String totalPrice = bookList.get(index).get(j).get("total_price");

					JSONObject bookData = new JSONObject();
					bookData.put("BOOK_NAME", bookName);
					bookData.put("AUTHOR_NAME", authorName);
					bookData.put("PUBLISHER_NAME", publisherName);
					bookData.put("QUANTITY", saleQuantity);
					bookData.put("SELLING_PRICE", sellingPrice);
					bookData.put("TOTAL_PRICE", totalPrice);

					bookArr.put(bookData);
				}
				JSONObject requestedData = new JSONObject();
				requestedData.put("REQUESTED_TERM", orderDataList.get(index).getRequested_term());

				JSONObject addressData = new JSONObject();
				addressData.put("POSTAL_CODE", orderDataList.get(index).getPostal_code());
				addressData.put("ROAD", orderDataList.get(index).getRoad());
				addressData.put("NUMBER", orderDataList.get(index).getNumber());
				addressData.put("DETAIL", orderDataList.get(index).getDetail());

				jsonObject.put("ORDERER", ordererData);
				jsonObject.put("RECEPIENT", recepientData);
				jsonObject.put("KEY_DATA", bookArr);
				jsonObject.put("REQUESTED_TERM", requestedData);
				jsonObject.put("ADDRESS", addressData);

				jsonObject.put("ORDER_CODE", orderDataList.get(index).getOrder_code());
				jsonObject.put("ORDERER_ID", orderDataList.get(index).getUser_id());
				jsonObject.put("PAYMENT_METHOD", orderDataList.get(index).getPayment_method());
				jsonObject.put("DELIVERY_METHOD", orderDataList.get(index).getDelivery_method());
				jsonObject.put("FINAL_TOTAL_PRICE", orderDataList.get(index).getTotal_price());
				jsonObject.put("ORDER_DATE", orderDataList.get(index).getOrder_date());

				rootArr.put(jsonObject);
			}
			orderData.put("ORDER_DATA", rootArr);
			response.setContentType("application/json");
			response.getWriter().write(orderData.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	void processShipment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			String[] orderCodeList = (String[]) request.getAttribute("ORDER_CODE_LIST");
			String[] userIdList = (String[]) request.getAttribute("USER_ID_LIST");

			OrdersManagementDAO dao = (OrdersManagementDAO) sc.getAttribute("MANAGEMENT_ORDERS_DAO");
			dao.processShipment(userIdList, orderCodeList);

			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	void getUnprocessedOrderListSize(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			OrdersManagementDAO dao = (OrdersManagementDAO) sc.getAttribute("MANAGEMENT_ORDERS_DAO");
			int size = dao.getUnprocessedOrderListSize();

			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(String.valueOf(size));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}
