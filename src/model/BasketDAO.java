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
		String query = "SELECT basket_item_code, basket_item_category, basket_quantity FROM basket WHERE basket_user_id = ? ORDER BY basket_item_code ASC";

		ResultSet set = null;
		ArrayList<BasketDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			list = new ArrayList<BasketDTO>();

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

	public ArrayList<BasketDTO> getBasket(String userId, String[] bookCodes, String[] categoryCodes)
	{
		String query = "SELECT basket_item_code, basket_item_category, basket_quantity FROM basket WHERE basket_user_id = ? AND basket_item_code = ? AND basket_item_category = ?";

		ResultSet set = null;
		ArrayList<BasketDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			list = new ArrayList<BasketDTO>();
			for (int index = 0; index < bookCodes.length; ++index)
			{
				set = null;

				prstmt.setString(1, userId);
				prstmt.setInt(2, Integer.parseInt(bookCodes[index]));
				prstmt.setString(3, categoryCodes[index]);
				set = prstmt.executeQuery();

				if (set.next())
				{
					list.add(new BasketDTO().setItem_code(set.getInt(1)).setCategory_code(set.getString(2))
							.setQuantity(set.getInt(3)));
				}
			}
		} catch (

		Exception e)
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

	public ArrayList<ItemsDTO> getBooksFromBasket(String userId)
	{
		String query = "SELECT i.item_code, i.item_name, i.item_selling_price, i.item_publisher_code, p.publisher_name"
				+ ", i.item_category_code, c.category_name, b.basket_quantity " + "FROM basket AS b "
				+ "INNER JOIN items AS i ON b.basket_user_id = ? AND b.basket_item_code = i.item_code AND b.basket_item_category = i.item_category_code "
				+ "INNER JOIN publishers AS p ON p.publisher_code = i.item_publisher_code "
				+ "INNER JOIN itemcategory AS c ON c.category_code = i.item_category_code "
				+ "WHERE b.basket_user_id = ? ORDER BY b.basket_added_datetime ASC";

		ArrayList<ItemsDTO> books = null;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			books = new ArrayList<ItemsDTO>();

			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			while (set.next())
			{
				books.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
						.setItem_selling_price(set.getInt(3)).setItem_publisher_code(set.getInt(4))
						.setItem_publisher_name(set.getString(5)).setItem_category_code(set.getString(6))
						.setItem_category_desc(set.getString(7)).setOrder_quantity(set.getInt(8)));
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
		return books;
	}

	public boolean checkDuplication(String userId, int itemCode)
	{
		String query = "SELECT count(basket_item_code) FROM basket WHERE basket_user_id = ? AND basket_item_code = ?";
		ResultSet set = null;
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			prstmt.setInt(2, itemCode);

			set = prstmt.executeQuery();
			if (set.next())
			{
				if (set.getInt(1) == 1)
				{
					flag = true;
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
		return flag;
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
				connection.commit();
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}
}