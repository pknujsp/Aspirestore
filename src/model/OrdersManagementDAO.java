package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

public class OrdersManagementDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ArrayList<OrderhistoryDTO> getUnprocessedOrderList(int startIndex, int endIndex)
	{
		String query = "SELECT * " + "FROM orderhistory as o "
				+ "INNER JOIN paymentmethod p ON p.paymentmethod_code = o.orderhistory_payment_method "
				+ "INNER JOIN deliverymethod d ON d.deliverymethod_code = o.orderhistory_delivery_method "
				+ "WHERE o.orderhistory_status = \'n\' ORDER BY o.orderhistory_order_date ASC LIMIT ?, ?";
		;
		ResultSet set = null;
		ArrayList<OrderhistoryDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, startIndex);
			prstmt.setInt(2, endIndex);
			set = prstmt.executeQuery();

			list = new ArrayList<OrderhistoryDTO>();
			while (set.next())
			{
				list.add(new OrderhistoryDTO().setOrder_code(set.getInt(1)).setUser_id(set.getString(2))
						.setOrderer_name(set.getString(3)).setOrderer_mobile1(set.getString(4))
						.setOrderer_mobile2(set.getString(5)).setOrderer_mobile3(set.getString(6))
						.setOrderer_general1(set.getString(7)).setOrderer_general2(set.getString(8))
						.setOrderer_general3(set.getString(9)).setOrderer_email(set.getString(10))
						.setRecepient_name(set.getString(11)).setRecepient_mobile1(set.getString(12))
						.setRecepient_mobile2(set.getString(13)).setRecepient_mobile3(set.getString(14))
						.setRecepient_general1(set.getString(15)).setRecepient_general2(set.getString(16))
						.setRecepient_general3(set.getString(17)).setPostal_code(set.getString(18))
						.setRoad(set.getString(19)).setNumber(set.getString(20)).setDetail(set.getString(21))
						.setRequested_term(set.getString(22)).setTotal_price(set.getInt(23))
						.setOrder_date(set.getString(26)).setPayment_method(set.getString(29))
						.setDelivery_method(set.getString(31)));
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
			{
				try
				{
					set.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}

		}
		return list;
	}

	public ArrayList<ArrayList<Map<String, String>>> getBookList(ArrayList<OrderhistoryDTO> orderList)
	{
		// 도서 명, 저자 , 출판사, 주문 수량, 판매가, 총 금액, 결제 수단, 배송 수단 데이터 저장
		ArrayList<ArrayList<Map<String, String>>> list = null;

		String query = "SELECT item.item_name, author.author_name, publisher.publisher_name, sale.salehistory_sale_quantity, item.item_selling_price, sale.salehistory_total_price "
				+ "FROM salehistory as sale "
				+ "INNER JOIN items item ON item.item_code = sale.salehistory_item_code AND item.item_category_code = sale.salehistory_item_category "
				+ "INNER JOIN orderhistory orders ON orders.orderhistory_order_code = sale.salehistory_order_code "
				+ "INNER JOIN authors author ON author.author_code = item.item_author_code "
				+ "INNER JOIN publishers publisher ON publisher.publisher_code = item.item_publisher_code "
				+ "INNER JOIN paymentmethod payment ON payment.paymentmethod_code = orders.orderhistory_payment_method "
				+ "INNER JOIN deliverymethod delivery ON delivery.deliverymethod_code = orders.orderhistory_delivery_method "
				+ "WHERE orders.orderhistory_user_id = ? AND orders.orderhistory_order_code = ? AND payment.paymentmethod_code = orders.orderhistory_payment_method AND orders.orderhistory_delivery_method =  delivery.deliverymethod_code";

		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			list = new ArrayList<ArrayList<Map<String, String>>>(orderList.size());

			for (int i = 0; i < orderList.size(); ++i)
			{
				set = null;
				prstmt.setString(1, orderList.get(i).getUser_id());
				prstmt.setInt(2, orderList.get(i).getOrder_code());
				set = prstmt.executeQuery();

				ArrayList<Map<String, String>> node = new ArrayList<Map<String, String>>();
				while (set.next())
				{
					Map<String, String> map = new HashMap<String, String>();

					// map에 데이터 삽입 필요
					map.put("book_name", set.getString(1));
					map.put("author_name", set.getString(2));
					map.put("publisher_name", set.getString(3));
					map.put("sale_quantity", String.valueOf(set.getInt(4)));
					map.put("selling_price", String.valueOf(set.getInt(5)));
					map.put("total_price", String.valueOf(set.getInt(6)));

					node.add(map);
				}
				list.add(node);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
			{
				try
				{
					set.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		return list;
	}
}