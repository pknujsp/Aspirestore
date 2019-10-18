package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

public class BasketDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ArrayList<BasketDTO> getBasket(String userId)
	{
		String query = "SELECT basket_item_code, basket_item_category, basket_quantity FROM basket WHERE basket_user_id = ?";

		ResultSet set = null;
		ArrayList<BasketDTO> list = new ArrayList<BasketDTO>();
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			while (set.next())
			{
				list.add(new BasketDTO().setItem_code(set.getInt(1)).setCategory_code(set.getString(2))
						.setQuantity(set.getInt(3)));
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

	public boolean addBookToTheBasket(BasketDTO data)
	{
		String query = "INSERT INTO basket VALUES (?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_id());
			prstmt.setInt(2, data.getItem_code());
			prstmt.setString(3, data.getCategory_code());
			prstmt.setInt(4, data.getQuantity());

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

	public boolean deleteBooksFromBasket(ArrayList<BasketDTO> books)
	{
		String query = "DELETE FROM basket WHERE basket_user_id = ? AND basket_item_code = ? AND basket_item_category = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int i = 0; i < books.size(); ++i)
			{
				prstmt.setString(1, books.get(i).getUser_id());
				prstmt.setInt(2, books.get(i).getItem_code());
				prstmt.setString(3, books.get(i).getCategory_code());

				prstmt.addBatch();
			}

			if (prstmt.executeBatch().length == books.size())
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
