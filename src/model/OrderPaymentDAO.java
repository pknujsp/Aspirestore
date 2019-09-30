package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
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

	public boolean orderPayment(OrderPaymentDTO orderData, ArrayList<OrderInformation> orderInformations, String userId)
	{
		boolean flag = false;
		String query = "INSERT INTO salehistory VALUES (null,?,?,?,?,?,?,?,?,?,null)";

		java.util.Date date = new java.util.Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		final String currentTime = format.format(date);

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{

			for (int i = 0; i < orderInformations.size(); ++i)
			{
				prstmt.setInt(1, orderInformations.get(i).getItem_code());
				prstmt.setString(2, orderInformations.get(i).getItem_category());
				prstmt.setString(3, userId);
				prstmt.setString(4, currentTime);
				prstmt.setInt(5, orderInformations.get(i).getOrder_quantity());
				prstmt.setInt(6, getTotalPrice(orderInformations.get(i)));
				prstmt.setString(7, orderData.getSalehistory_address());
				prstmt.setString(8, orderData.getSalehistory_payment_method());
				prstmt.setString(9, orderData.getSalehistory_requested_term());

				if (prstmt.executeUpdate() == 1)
				{
					flag = true;
				} else
				{
					flag = false;
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	private int getTotalPrice(OrderInformation info)
	{
		return info.getItem_price() * info.getOrder_quantity();
	}
}