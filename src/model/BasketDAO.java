package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

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
				+ ", p.publisher_code, p.publisher_name, b.basket_quantity, b.basket_added_datetime, i.item_selling_price, au.author_code, au.author_name "
				+ "FROM basket AS b "
				+ "INNER JOIN items AS i ON i.item_category_code = b.basket_item_category AND i.item_code = b.basket_item_code "
				+ "INNER JOIN itemcategory AS c ON b.basket_item_category = c.category_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code "
				+ "INNER JOIN bookauthors_table AS aulist ON aulist.bookAuthors_item_code = b.basket_item_code AND aulist.bookAuthors_item_category_code = b.basket_item_category "
				+ "INNER JOIN authors AS au ON aulist.bookAuthors_author_code = au.author_code "
				+ "WHERE b.basket_user_id = ? ORDER BY b.basket_added_datetime DESC";

		ResultSet set = null;
		BasketDTO basket = null;
		HashSet<String> codeSet = new HashSet<String>();

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(selectQuery);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();

			basket = new BasketDTO();

			int index = 0;
			while (set.next())
			{
				if (index == 0)
				{
					basket.setUser_id(userId);
				}
				String code = String.valueOf(set.getInt(1)) + set.getString(3);

				if (checkExtraAuthor(codeSet, code))
				{
					basket.getBooks().get(index - 1).setAuthors(new AuthorDTO()
							.setAuthor_code(set.getInt("author_code")).setAuthor_name(set.getString("author_name")));
				} else
				{
					basket.setBooks(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_category_code(set.getString(3)).setItem_category_desc(set.getString(4))
							.setItem_publisher_code(set.getInt(5)).setItem_publisher_name(set.getString(6))
							.setOrder_quantity(set.getInt(7)).setBasket_added_datetime(set.getString(8))
							.setItem_selling_price(set.getInt(9))
							.setAuthors(new AuthorDTO().setAuthor_code(set.getInt("author_code"))
									.setAuthor_name(set.getString("author_name"))));

					codeSet.add(code);
					++index;
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

	public BasketDTO getBasket(String userId, HashMap<Integer, String> bookCodeMap)
	{
		String selectQuery = "SELECT b.basket_item_code, i.item_name, b.basket_item_category, c.category_name"
				+ ", p.publisher_code, p.publisher_name, b.basket_quantity, i.item_selling_price, au.author_code, au.author_name "
				+ "FROM basket AS b "
				+ "INNER JOIN items AS i ON i.item_category_code = b.basket_item_category AND i.item_code = b.basket_item_code "
				+ "INNER JOIN itemcategory AS c ON b.basket_item_category = c.category_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code "
				+ "INNER JOIN bookauthors_table AS aulist ON aulist.bookAuthors_item_code = b.basket_item_code AND aulist.bookAuthors_item_category_code = b.basket_item_category "
				+ "INNER JOIN authors AS au ON aulist.bookAuthors_author_code = au.author_code "
				+ "WHERE b.basket_user_id = ? AND b.basket_item_code = ? AND b.basket_item_category = ? ORDER BY b.basket_item_code ASC";

		ResultSet set = null;
		BasketDTO basket = null;
		HashSet<String> codeSet = new HashSet<String>();

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(selectQuery);)
		{
			Iterator<Integer> iterator = bookCodeMap.keySet().iterator();
			basket = new BasketDTO();

			while (iterator.hasNext())
			{
				set = null;
				int icode = iterator.next().intValue();
				String ccode = bookCodeMap.get(Integer.valueOf(icode));

				prstmt.setString(1, userId);
				prstmt.setInt(2, icode);
				prstmt.setString(3, ccode);

				set = prstmt.executeQuery();

				int index = 0;
				while (set.next())
				{
					if (index == 0)
					{
						basket.setUser_id(userId);
					}

					String code = String.valueOf(set.getInt(1)) + set.getString(3);

					if (checkExtraAuthor(codeSet, code))
					{
						basket.getBooks().get(index - 1)
								.setAuthors(new AuthorDTO().setAuthor_code(set.getInt("author_code"))
										.setAuthor_name(set.getString("author_name")));
					} else
					{
						basket.setBooks(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
								.setItem_category_code(set.getString(3)).setItem_category_desc(set.getString(4))
								.setItem_publisher_code(set.getInt(5)).setItem_publisher_name(set.getString(6))
								.setOrder_quantity(set.getInt(7)).setItem_selling_price(set.getInt(8)).setTotal_price()
								.setAuthors(new AuthorDTO().setAuthor_code(set.getInt("author_code"))
										.setAuthor_name(set.getString("author_name"))));

						codeSet.add(code);
						++index;
					}
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
		String query = "INSERT INTO basket " + "SELECT ?, ?, ?, ?, ? FROM DUAL WHERE NOT EXISTS "
				+ "(SELECT * FROM basket WHERE basket_item_code = ? AND basket_item_category = ? AND basket_user_id = ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			prstmt.setInt(2, book.getItem_code());
			prstmt.setString(3, book.getItem_category_code());
			prstmt.setInt(4, book.getOrder_quantity());
			prstmt.setString(5, currentTime);
			prstmt.setInt(6, book.getItem_code());
			prstmt.setString(7, book.getItem_category_code());
			prstmt.setString(8, userId);

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

	public boolean deleteBooksFromBasket(ArrayList<ItemsDTO> books, String userId)
	{
		String query = "DELETE FROM basket WHERE basket_user_id = ? AND basket_item_code = ? AND basket_item_category = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int index = 0; index < books.size(); ++index)
			{
				prstmt.setString(1, userId);
				prstmt.setInt(2, books.get(index).getItem_code());
				prstmt.setString(3, books.get(index).getItem_category_code());

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

	private boolean checkExtraAuthor(HashSet<String> codeSet, String code)
	{
		return codeSet.contains(code) ? true : false;
	}
}