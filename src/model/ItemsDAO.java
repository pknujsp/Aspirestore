package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.sql.DataSource;

public class ItemsDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ItemsDTO getItem(int ccode, int icode)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		ResultSet set = null;
		ItemsDTO item = null;

		try
		{
			String query = "SELECT * FROM items WHERE item_code=? AND item_category_code=?";
			connection = ds.getConnection();
			prstmt = connection.prepareStatement(query);

			prstmt.setInt(1, icode);
			prstmt.setInt(2, ccode);
			set = prstmt.executeQuery();

			if (set.next())
			{
				item = new ItemsDTO(set.getInt("item_code"), set.getString("item_name"), set.getInt("item_author_code"),
						set.getInt("item_publisher_code"), set.getString("item_publication_date"),
						set.getInt("item_fixed_price"), set.getInt("item_selling_price"),
						set.getInt("item_remaining_quantity"), set.getString("item_category_code"),
						set.getString("item_the_page_number"), set.getString("item_weight"), set.getString("item_size"),
						set.getString("item_isbn13"), set.getString("item_isbn10"),
						set.getString("item_book_introduction"), set.getString("item_contents_table"),
						set.getString("item_publisher_review"), set.getString("item_registration_datetime"));
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
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (prstmt != null)
			{
				try
				{
					prstmt.close();
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (connection != null)
			{
				try
				{
					connection.close();
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
		return item;
	}

	public OrderedItemsDTO[] getSimpleOrderedItemData(Map<Integer, String> codeMap)
	{
		OrderedItemsDTO[] items = new OrderedItemsDTO[codeMap.size()];
		String query = "SELECT a.author_name, p.publisher_name, i.item_name, i.item_code, i.item_category_code, "
				+ "i.item_selling_price " + "FROM items as i"
				+ "INNER JOIN publishers p ON i.item_publisher_code = p.publisher_code"
				+ "INNER JOIN authors a ON i.item_author_code = a.author_code"
				+ "WHERE i.item_code = ? AND i.item_category_code = ?";
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			Iterator<Integer> it = codeMap.keySet().iterator();
			int i = 0;

			while (it.hasNext())
			{
				int itemCode = it.next().intValue();
				String categoryCode = codeMap.get(itemCode);

				prstmt.setInt(1, itemCode);
				prstmt.setString(2, categoryCode);
				set = prstmt.executeQuery();

				while (set.next())
				{
					items[i] = new OrderedItemsDTO(set.getString("i.item_name"), set.getString("ia.author_name"),
							set.getString("p.publisher_name"), set.getInt("i.item_code"),
							set.getString("i.item_category_code"), set.getInt("i.item_selling_price"));
					++i;
				}
				prstmt.clearParameters();
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
		return items;
	}

	public ArrayList<ItemsDTO> getItemList(int ccode)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		ResultSet set = null;
		ArrayList<ItemsDTO> bookList = new ArrayList<ItemsDTO>();
		try
		{
			String query = "SELECT item_code, item_name, item_author_code, item_publisher_code, item_publication_date, item_selling_price, item_book_introduction FROM items WHERE item_category_code=?";
			connection = ds.getConnection();
			prstmt = connection.prepareStatement(query);

			prstmt.setInt(1, ccode);

			set = prstmt.executeQuery();

			while (set.next())
			{
				bookList.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
						.setItem_author_code(set.getInt(3)).setItem_publisher_code(set.getInt(4))
						.setItem_publication_date(set.getString(5)).setItem_selling_price(set.getInt(6))
						.setItem_book_introduction(cutString(set.getString(7))));
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
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (prstmt != null)
			{
				try
				{
					prstmt.close();
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (connection != null)
			{
				try
				{
					connection.close();
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
		return bookList;
	}

	private String cutString(String str)
	{
		if (str.length() >= 150)
		{
			return str.substring(0, 150) + "...";
		} else
		{
			return str;
		}
	}
}