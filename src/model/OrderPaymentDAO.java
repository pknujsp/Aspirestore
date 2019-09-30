package model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

public class OrderPaymentDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public boolean orderPayment(OrderPaymentDTO orderData)
	{
		boolean flag = false;
		String query = "INSERT INTO salehistory VALUES (null,?,?,?,?,?,?,?,?,?,null)";

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, orderData.getSalehistory_item_code());
			prstmt.setString(2, orderData.getSalehistory_item_category());
			prstmt.setString(3, orderData.getSalehistory_user_id());
			prstmt.setString(4, orderData.getSalehistory_sale_date());
			prstmt.setInt(5, orderData.getSalehistory_sale_quantity());
			prstmt.setInt(6, orderData.getSalehistory_total_price());
			prstmt.setString(7, orderData.getSalehistory_address());
			prstmt.setString(8, orderData.getSalehistory_payment_method());
			prstmt.setString(9, orderData.getSalehistory_requested_term());

			if (prstmt.executeUpdate() == 1)
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
