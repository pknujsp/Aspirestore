package model;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import etc.Util;

public class OrderPaymentDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public boolean requestOrderProcessing(OrderhistoryDTO orderFormData, ArrayList<ItemsDTO> books)
	{
		String currentTime = Util.getCurrentDateTime();
		String orderQuery = "INSERT INTO orderhistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String saleQuery = "INSERT INTO salehistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt1 = connection.prepareStatement(orderQuery);
				PreparedStatement prstmt2 = connection.prepareStatement(saleQuery);)
		{
			prstmt1.setString(1, orderFormData.getUser_id());
			prstmt1.setString(2, orderFormData.getOrderer_name());
			prstmt1.setString(3, orderFormData.getOrderer_mobile1());
			prstmt1.setString(4, orderFormData.getOrderer_mobile2());
			prstmt1.setString(5, orderFormData.getOrderer_mobile3());
			prstmt1.setString(6, orderFormData.getOrderer_general1());
			prstmt1.setString(7, orderFormData.getOrderer_general2());
			prstmt1.setString(8, orderFormData.getOrderer_general3());
			prstmt1.setString(9, orderFormData.getOrderer_email());
			prstmt1.setString(10, orderFormData.getRecepient_name());
			prstmt1.setString(11, orderFormData.getRecepient_mobile1());
			prstmt1.setString(12, orderFormData.getRecepient_mobile2());
			prstmt1.setString(13, orderFormData.getRecepient_mobile3());
			prstmt1.setString(14, orderFormData.getRecepient_general1());
			prstmt1.setString(15, orderFormData.getRecepient_general2());
			prstmt1.setString(16, orderFormData.getRecepient_general3());
			prstmt1.setString(17, orderFormData.getPostal_code());
			prstmt1.setString(18, orderFormData.getRoad());
			prstmt1.setString(19, orderFormData.getNumber());
			prstmt1.setString(20, orderFormData.getDetail());
			prstmt1.setString(21, orderFormData.getRequested_term());
			prstmt1.setInt(22, orderFormData.getTotal_price());
			prstmt1.setString(23, orderFormData.getPayment_method_code());
			prstmt1.setString(24, orderFormData.getDelivery_method_code());
			prstmt1.setString(25, currentTime);
			prstmt1.setString(26, "n");

			if (prstmt1.executeUpdate() == 1)
			{
				int orderCode = getOrderCode(currentTime, orderFormData.getUser_id());

				for (int i = 0; i < books.size(); ++i)
				{
					prstmt2.setInt(1, orderCode);
					prstmt2.setString(2, orderFormData.getUser_id());
					prstmt2.setInt(3, books.get(i).getItem_code());
					prstmt2.setString(4, books.get(i).getItem_category_code());
					prstmt2.setString(5, currentTime);
					prstmt2.setInt(6, books.get(i).getOrder_quantity());
					prstmt2.setInt(7, books.get(i).getOrder_quantity() * books.get(i).getItem_selling_price());
					prstmt2.setString(8, "n");

					prstmt2.addBatch();
				}
				if (prstmt2.executeBatch().length == books.size())
				{
					connection.commit();
					flag = true;
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public int getOrderCode(String date, String userId)
	{
		String query = "SELECT orderhistory_order_code FROM orderhistory WHERE orderhistory_order_date = ? AND orderhistory_user_id = ?";

		ResultSet set = null;
		int code = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, date);
			prstmt.setString(2, userId);

			set = prstmt.executeQuery();
			if (set.next())
			{
				code = set.getInt(1);
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
		return code;
	}

	public OrderhistoryDTO getOrderHistory(int orderCode, String userId)
	{
		ResultSet set = null;
		String query = "SELECT * FROM orderhistory WHERE orderhistory_order_code = ? AND orderhistory_user_id = ?";
		OrderhistoryDTO dto = new OrderhistoryDTO();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, orderCode);
			prstmt.setString(2, userId);

			set = prstmt.executeQuery();

			while (set.next())
			{
				dto.setOrder_code(orderCode).setUser_id(userId).setOrderer_name(set.getString(3))
						.setOrderer_mobile1(set.getString(4)).setOrderer_mobile2(set.getString(5))
						.setOrderer_mobile3(set.getString(6)).setOrderer_general1(set.getString(7))
						.setOrderer_general2(set.getString(8)).setOrderer_general3(set.getString(9))
						.setOrderer_email(set.getString(10)).setRecepient_name(set.getString(11))
						.setRecepient_mobile1(set.getString(12)).setRecepient_mobile2(set.getString(13))
						.setRecepient_mobile3(set.getString(14)).setRecepient_general1(set.getString(15))
						.setRecepient_general2(set.getString(16)).setRecepient_general3(set.getString(17))
						.setPostal_code(set.getString(18)).setRoad(set.getString(19)).setNumber(set.getString(20))
						.setDetail(set.getString(21)).setRequested_term(set.getString(22))
						.setTotal_price(set.getInt(23)).setPayment_method_code(set.getString(24))
						.setDelivery_method_code(set.getString(25)).setOrder_date(set.getString(26));
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
		return dto;
	}

	public ArrayList<SalehistoryDTO> getSaleHistory(int orderCode, String userId)
	{
		String query = "SELECT * FROM salehistory AS s "
				+ "INNER JOIN items AS i ON i.item_code = s.salehistory_item_code AND i.item_category_code = s.salehistory_item_category "
				+ "INNER JOIN itemcategory AS c ON c.category_code = s.salehistory_item_category "
				+ "INNER JOIN publishers AS p ON p.publisher_code = i.item_publisher_code "
				+ "WHERE s.salehistory_order_code = ? AND s.salehistory_user_id = ? ORDER BY s.salehistory_item_code ASC";
		ArrayList<SalehistoryDTO> list = null;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, orderCode);
			prstmt.setString(2, userId);
			set = prstmt.executeQuery();

			list = new ArrayList<SalehistoryDTO>();

			while (set.next())
			{
				list.add(new SalehistoryDTO().setSale_code(set.getInt(1)).setOrder_code(set.getInt(2))
						.setUser_id(set.getString(3)).setItem_code(set.getInt(4))
						.setItem_category_code(set.getString(5)).setSale_date(set.getString(6))
						.setSale_quantity(set.getInt(7)).setTotal_price(set.getInt(8)).setStatus(set.getString(9))
						.setItem_name(set.getString(11)).setItem_category_desc(set.getString(27))
						.setPublisher_code(set.getInt(30)).setPublisher_name(set.getString(31)));
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

	public OrderhistoryDTO getLatestOrderInfo(String userId)
	{
		String query = "SELECT * FROM orderhistory AS o "
				+ "INNER JOIN deliverymethod AS d ON d.deliverymethod_code = o.orderhistory_delivery_method "
				+ "INNER JOIN paymentmethod AS p ON p.paymentmethod_code = o.orderhistory_payment_method "
				+ "WHERE o.orderhistory_user_id = ? ORDER BY o.orderhistory_order_date DESC LIMIT 1";
		ResultSet set = null;
		OrderhistoryDTO data = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			if (set.next())
			{
				data = new OrderhistoryDTO().setOrder_code(set.getInt(1)).setUser_id(set.getString(2))
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
						.setPayment_method_desc(set.getString(31)).setDelivery_method_desc(set.getString(29))
						.setOrder_date(set.getString(26));
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
		return data;
	}
}