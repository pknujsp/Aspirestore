package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import etc.OrderInformation;

public class OrderPaymentDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public int[] requestOrderProcessing(OrderhistoryDTO orderFormData, ArrayList<OrderInformation> ordered_items,
			String userId)
	{
		String query = "INSERT INTO orderhistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int[] codes = new int[ordered_items.size() + 1];

		java.util.Date date = new java.util.Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		final String currentTime = format.format(date);

		try (Connection connection = ds.getConnection();)
		{

			PreparedStatement prstmt = connection.prepareStatement(query);

			prstmt.setString(1, orderFormData.getUser_id());
			prstmt.setString(2, orderFormData.getOrderer_name());
			prstmt.setString(3, orderFormData.getOrderer_mobile());
			prstmt.setString(4, orderFormData.getOrderer_general());
			prstmt.setString(5, orderFormData.getOrderer_email());
			prstmt.setString(6, orderFormData.getRecipient_name());
			prstmt.setString(7, orderFormData.getRecipient_mobile());
			prstmt.setString(8, orderFormData.getRecipient_general());
			prstmt.setString(9, orderFormData.getPostal_code());
			prstmt.setString(10, orderFormData.getRoad());
			prstmt.setString(11, orderFormData.getNumber());
			prstmt.setString(12, orderFormData.getDetail());
			prstmt.setString(13, orderFormData.getRequested_term());
			prstmt.setInt(14, orderFormData.getTotal_price());
			prstmt.setString(15, orderFormData.getPayment_method());
			prstmt.setString(16, orderFormData.getDelivery_method());
			prstmt.setString(17, currentTime);

			codes[0] = getOrderOrSaleCode(currentTime, orderFormData.getUser_id(), true); // ordercode

			if (prstmt.executeUpdate() == 1)
			{
				prstmt.clearBatch();
				query = "INSERT INTO salehistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
				prstmt = connection.prepareStatement(query);

				for (int i = 0; i < ordered_items.size(); ++i)
				{

					prstmt.setInt(1, getOrderOrSaleCode(currentTime, orderFormData.getUser_id(), true));
					prstmt.setString(2, orderFormData.getUser_id());
					prstmt.setInt(3, ordered_items.get(i).getItem_code());
					prstmt.setString(4, ordered_items.get(i).getItem_category());
					prstmt.setString(5, currentTime);
					prstmt.setInt(6, ordered_items.get(i).getOrder_quantity());
					prstmt.setInt(7, ordered_items.get(i).getOrder_quantity() * ordered_items.get(i).getItem_price());
					prstmt.setString(8, "n");

					prstmt.addBatch();
					prstmt.clearParameters();
					codes[i + 1] = getOrderOrSaleCode(currentTime, orderFormData.getUser_id(), false); // salecode
				}

				if (prstmt.executeBatch().length == ordered_items.size())
				{
					connection.commit();
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return codes;
	}

	public ArrayList<ItemsDTO> getItemsInfo(ArrayList<OrderInformation> informations)
	{
		String query = "SELECT item_code, item_name, item_author_code, item_publisher_code, item_selling_price, item_category_code FROM items WHERE item_code = ? AND item_category_code = ?";
		ArrayList<ItemsDTO> items = new ArrayList<ItemsDTO>();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			ResultSet set = null;

			for (int i = 0; i < informations.size(); ++i)
			{
				prstmt.setInt(1, informations.get(i).getItem_code());
				prstmt.setString(2, informations.get(i).getItem_category());
				set = prstmt.executeQuery();

				while (set.next())
				{
					items.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_author_code(set.getInt(3)).setItem_publisher_code(set.getInt(4))
							.setItem_selling_price(set.getInt(5)).setItem_category_code(set.getString(6)));
				}
			}

			set.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return items;
	}

	public int getOrderOrSaleCode(String date, String userId, boolean flag)
	{
		String query = null;

		if (flag) // true 이면 ordercode
		{
			query = "SELECT orderhistory_order_code FROM orderhistory WHERE orderhistory_order_date = ? AND orderhistory_user_id = ?";
		} else
		{
			query = "SELECT salehistory_sale_code FROM salehistory WHERE salehistory_order_date = ? AND salehistory_user_id = ?";
		}
		ResultSet set = null;
		int code = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, date);
			prstmt.setString(2, userId);

			set = prstmt.executeQuery();
			while (set.next())
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

}