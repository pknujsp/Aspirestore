package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import javax.security.sasl.SaslException;
import javax.servlet.ServletException;
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
		String query = "SELECT * FROM orderhistory AS o "
				+ "INNER JOIN paymentmethod AS p ON p.paymentmethod_code = o.orderhistory_payment_method "
				+ "INNER JOIN deliverymethod AS d ON d.deliverymethod_code = o.orderhistory_delivery_method "
				+ "WHERE o.orderhistory_status = ? ORDER BY o.orderhistory_order_date ASC LIMIT ?, ?";
		;
		ResultSet set = null;
		ArrayList<OrderhistoryDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, "n");
			prstmt.setInt(2, startIndex);
			prstmt.setInt(3, endIndex);
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
						.setOrder_date(set.getString(26)).setPayment_method_desc(set.getString(29))
						.setDelivery_method_desc(set.getString(31)));
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

	public HashMap<String, ArrayList<ItemsDTO>> getBookList(ArrayList<OrderhistoryDTO> orderList)
	{
		// 도서 명, 저자 , 출판사, 주문 수량, 판매가, 총 금액, 결제 수단, 배송 수단 데이터 저장
		HashMap<String, ArrayList<ItemsDTO>> list = null;

		String query = "SELECT orders.orderhistory_user_id, item.item_name, publisher.publisher_name"
				+ ", sale.salehistory_sale_quantity, item.item_selling_price, sale.salehistory_total_price, au.author_name "
				+ "FROM salehistory as sale "
				+ "INNER JOIN items item ON item.item_code = sale.salehistory_item_code AND item.item_category_code = sale.salehistory_item_category "
				+ "INNER JOIN orderhistory orders ON orders.orderhistory_order_code = sale.salehistory_order_code "
				+ "INNER JOIN publishers publisher ON publisher.publisher_code = item.item_publisher_code "
				+ "INNER JOIN paymentmethod payment ON payment.paymentmethod_code = orders.orderhistory_payment_method "
				+ "INNER JOIN deliverymethod delivery ON delivery.deliverymethod_code = orders.orderhistory_delivery_method "
				+ "INNER JOIN bookauthors_table AS aulist ON aulist.bookAuthors_item_code = item.item_code AND aulist.bookAuthors_item_category_code = item.item_category_code "
				+ "INNER JOIN authors AS au ON aulist.bookAuthors_author_code = au.author_code "
				+ "WHERE orders.orderhistory_user_id = ? AND orders.orderhistory_order_code = ? AND payment.paymentmethod_code = orders.orderhistory_payment_method AND orders.orderhistory_delivery_method =  delivery.deliverymethod_code "
				+ "ORDER BY sale.salehistory_item_code ASC";

		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			list = new HashMap<String, ArrayList<ItemsDTO>>();

			for (int i = 0; i < orderList.size(); ++i)
			{
				set = null;

				prstmt.setString(1, orderList.get(i).getUser_id());
				prstmt.setInt(2, orderList.get(i).getOrder_code());
				set = prstmt.executeQuery();

				String userId = null;
				int index = 0;
				HashSet<String> nameSet = new HashSet<String>();

				while (set.next())
				{
					if (userId == null)
					{
						userId = set.getString(1);
						list.put(userId, new ArrayList<ItemsDTO>());
					}
					if (!nameSet.contains(set.getString(2)))
					{
						list.get(userId)
								.add(new ItemsDTO().setItem_name(set.getString(2))
										.setItem_publisher_name(set.getString(3)).setOrder_quantity(set.getInt(4))
										.setItem_selling_price(set.getInt(5)).setTotal_price(set.getInt(6))
										.setAuthors(new AuthorDTO().setAuthor_name(set.getString("author_name"))));
						nameSet.add(set.getString(2));
						++index;
					} else
					{
						list.get(userId).get(index - 1)
								.setAuthors(new AuthorDTO().setAuthor_name(set.getString("author_name")));
					}
				}
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

	public int getUnprocessedOrderListSize()
	{
		String query = "SELECT count(orderhistory_order_code) FROM orderhistory WHERE orderhistory_status = \'n\'";
		int size = 0;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				ResultSet set = prstmt.executeQuery();)
		{
			if (set.next())
			{
				size = set.getInt(1);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return size;
	}

	public boolean processShipment(String[] userIdList, String[] orderCodeList)
	{
		String query = "UPDATE orderhistory o " + "INNER JOIN salehistory s "
				+ "ON s.salehistory_user_id = o.orderhistory_user_id AND o.orderhistory_order_code = s.salehistory_order_code "
				+ "SET o.orderhistory_status = \'y\' , s.salehistory_status = \'y\' "
				+ "WHERE o.orderhistory_user_id = ? AND o.orderhistory_order_code = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int i = 0; i < userIdList.length; ++i)
			{
				prstmt.setString(1, userIdList[i]);
				prstmt.setInt(2, Integer.parseInt(orderCodeList[i]));
				prstmt.addBatch();
			}
			if (prstmt.executeBatch().length == userIdList.length)
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}
}
