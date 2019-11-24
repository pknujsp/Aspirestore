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

	public BasketDTO getBasket(String userId)
	{
		String selectQuery = "SELECT b.basket_item_code, i.item_name, b.basket_item_category, c.category_name"
				+ ", p.publisher_code, p.publisher_name, b.basket_quantity, b.basket_added_datetime, i.item_selling_price "
				+ "FROM basket AS b "
				+ "INNER JOIN items AS i ON i.item_category_code = b.basket_item_category AND i.item_code = b.basket_item_code "
				+ "INNER JOIN itemcategory AS c ON b.basket_item_category = c.category_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code "
				+ "WHERE b.basket_user_id = ? ORDER BY b.basket_item_code ASC";

		ResultSet set = null;
		BasketDTO basket = null;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(selectQuery);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			basket = new BasketDTO();

			for (int index = 0; set.next(); ++index)
			{
				if (index == 0)
				{
					basket.setUser_id(userId);
				} else
				{

					basket.setBooks(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_category_code(set.getString(3)).setItem_category_desc(set.getString(4))
							.setItem_publisher_code(set.getInt(5)).setItem_publisher_name(set.getString(6))
							.setOrder_quantity(set.getInt(7)).setBasket_added_datetime(set.getString(8))
							.setItem_selling_price(set.getInt(9)));
				}
			}
			basket.setTotal_price().setTotal_quantity();
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
		return basket;
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

	public boolean addBookToTheBasket(ItemsDTO book, String userId, String currentTime)
	{
		String query = "INSERT INTO basket VALUES (?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			prstmt.setInt(2, book.getItem_code());
			prstmt.setString(3, book.getItem_category_code());
			prstmt.setInt(4, book.getOrder_quantity());
			prstmt.setString(5, currentTime);

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

	public boolean deleteBooksFromBasket(BasketDTO basket)
	{
		String query = "DELETE FROM basket WHERE basket_user_id = ? AND basket_item_code = ? AND basket_item_category = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int index = 0; index < basket.getBooks().size(); ++index)
			{
				prstmt.setString(1, basket.getUser_id());
				prstmt.setInt(2, basket.getBooks().get(index).getItem_code());
				prstmt.setString(3, basket.getBooks().get(index).getItem_category_code());

				prstmt.addBatch();
			}
			if (prstmt.executeBatch().length == basket.getBooks().size())
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