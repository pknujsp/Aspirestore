package model;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.sql.DataSource;

import etc.OrderInformation;

public class ItemsDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ItemsDTO getItem(String ccode, int icode)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		ResultSet set = null;
		ItemsDTO item = null;

		try
		{
			String query = "SELECT * FROM items WHERE item_code= ? AND item_category_code= ?";
			connection = ds.getConnection();
			prstmt = connection.prepareStatement(query);

			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
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

	public Map<String, Object> getBookData(int icode, String ccode)
	{
		String query = "SELECT * FROM items as i "
				+ "INNER JOIN publishers p ON i.item_publisher_code = p.publisher_code "
				+ "INNER JOIN authors a ON i.item_author_code = a.author_code "
				+ "INNER JOIN itemcategory AS c ON i.item_category_code = c.category_code "
				+ "WHERE i.item_code = ? AND i.item_category_code = ?";

		ItemsDTO book = null;
		AuthorDTO author = null;
		PublisherDTO publisher = null;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			set = prstmt.executeQuery();

			if (set.next())
			{
				book = new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
						.setItem_publisher_code(set.getInt(4)).setItem_publication_date(set.getString(5))
						.setItem_fixed_price(set.getInt(6)).setItem_selling_price(set.getInt(7))
						.setItem_remaining_quantity(set.getInt(8)).setItem_category_code(set.getString(9))
						.setItem_page_number(set.getString(10)).setItem_weight(set.getString(11))
						.setItem_size(set.getString(12)).setItem_isbn13(set.getString(13))
						.setItem_isbn10(set.getString(14)).setItem_book_introduction(set.getString(15))
						.setItem_contents_table(set.getString(16)).setItem_publisher_review(set.getString(17))
						.setItem_registration_datetime(set.getString(18)).setItem_category_desc(set.getString(26));

				author = new AuthorDTO().setAuthor_code(set.getInt(22)).setAuthor_name(set.getString(23))
						.setAuthor_region(set.getString(24)).setAuthor_information(set.getString(25));

				publisher = new PublisherDTO().setPublisher_code(set.getInt(19)).setPublisher_name(set.getString(20))
						.setPublisher_region(set.getString(21));
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
		Map<String, Object> bookData = new HashMap<String, Object>();

		bookData.put("BOOK", book);
		bookData.put("AUTHOR", author);
		bookData.put("PUBLISHER", publisher);
		return bookData;
	}

	public ArrayList<OrderedItemsDTO> getItemAuthorPublisher(ArrayList<SalehistoryDTO> saleHistory)
	{
		ArrayList<OrderedItemsDTO> list = null;
		String query = "SELECT a.author_name, p.publisher_name, i.item_name, i.item_code, i.item_category_code, "
				+ "i.item_selling_price " + "FROM items as i "
				+ "INNER JOIN publishers p ON i.item_publisher_code = p.publisher_code "
				+ "INNER JOIN authors a ON i.item_author_code = a.author_code "
				+ "WHERE i.item_code = ? AND i.item_category_code = ? ORDER BY i.item_code ASC";
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			list = new ArrayList<OrderedItemsDTO>(saleHistory.size());
			for (int i = 0; i < saleHistory.size(); ++i)
			{
				set = null;
				int itemCode = saleHistory.get(i).getItem_code();
				String categoryCode = saleHistory.get(i).getItem_category();

				prstmt.setInt(1, itemCode);
				prstmt.setString(2, categoryCode);
				set = prstmt.executeQuery();

				if (set.next())
				{
					list.add(new OrderedItemsDTO(set.getString(3), set.getString(1), set.getString(2), set.getInt(4),
							set.getString(5), set.getInt(6)));
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

	public ArrayList<ItemsDTO> getItemList(String ccode, String sortType, int startIdx, int endIdx)
	{

		ResultSet set = null;
		ArrayList<ItemsDTO> bookList = new ArrayList<ItemsDTO>();

		String query = "SELECT i.item_code, i.item_name, i.item_author_code, i.item_publisher_code, i.item_publication_date, i.item_selling_price"
				+ ", i.item_book_introduction, i.item_category_code, a.author_name, p.publisher_name, r.rinfo_sreview_num, r.rinfo_dreview_num, r.rinfo_total_rating "
				+ "FROM items AS i " + "INNER JOIN authors AS a ON a.author_code = i.item_author_code "
				+ "INNER JOIN publishers AS p ON p.publisher_code = i.item_publisher_code "
				+ "INNER JOIN itemreviewinfo_table AS r ON r.rinfo_item_code = i.item_code AND r.rinfo_item_category_code = i.item_category_code "
				+ "WHERE i.item_category_code = ? ";

		switch (sortType)
		{
		case "PUB_DATE_DESC":
			query += "ORDER BY i.item_publication_date DESC ";
			break;
		case "BEST":
			query += "ORDER BY i.item_publication_date ASC ";
			break;
		case "PRICE_DESC":
			query += "ORDER BY i.item_selling_price DESC ";
			break;
		case "PRICE_ASC":
			query += "ORDER BY i.item_selling_price ASC ";
			break;
		}
		query += "LIMIT ?, ?";

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, ccode);
			prstmt.setInt(2, startIdx);
			prstmt.setInt(3, endIdx);

			set = prstmt.executeQuery();

			while (set.next())
			{
				double rating = ((double) set.getInt(13) / (double) (set.getInt(11) + set.getInt(12)));

				bookList.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
						.setItem_author_code(set.getInt(3)).setItem_publisher_code(set.getInt(4))
						.setItem_publication_date(set.getString(5)).setItem_selling_price(set.getInt(6))
						.setItem_book_introduction(cutString(set.getString(7))).setItem_category_code(set.getString(8))
						.setItem_author_name(set.getString(9)).setItem_publisher_name(set.getString(10))
						.setItem_rating(new DecimalFormat("#.#").format(rating)));
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
		}
		return bookList;
	}

	public ArrayList<ItemsDTO> getitemsForBasket(Map<Integer, String> codeMap)
	{
		String query = "SELECT item_name, item_code, item_category_code, item_author_code, item_publisher_code, item_selling_price FROM items WHERE item_code = ? AND item_category_code = ? ORDER BY item_code ASC";
		ResultSet set = null;
		ArrayList<ItemsDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			Iterator<Integer> it = codeMap.keySet().iterator();

			list = new ArrayList<ItemsDTO>(codeMap.size());
			while (it.hasNext())
			{
				set = null;
				int itemCode = it.next().intValue();
				String categoryCode = codeMap.get(itemCode);

				prstmt.setInt(1, itemCode);
				prstmt.setString(2, categoryCode);

				set = prstmt.executeQuery();
				if (set.next())
				{
					list.add(new ItemsDTO().setItem_name(set.getString(1)).setItem_code(set.getInt(2))
							.setItem_category_code(set.getString(3)).setItem_author_code(set.getInt(4))
							.setItem_publisher_code(set.getInt(5)).setItem_selling_price(set.getInt(6)));
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

	public ArrayList<Integer> getBookSellingPrice(ArrayList<OrderInformation> books)
	{
		String query = "SELECT item_selling_price FROM items WHERE item_code = ? AND item_category_code = ? ORDER BY item_code ASC";
		ResultSet set = null;
		ArrayList<Integer> prices = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prices = new ArrayList<Integer>(books.size());

			for (int i = 0; i < books.size(); ++i)
			{
				set = null;

				prstmt.setInt(1, books.get(i).getItem_code());
				prstmt.setString(2, books.get(i).getItem_category());
				set = prstmt.executeQuery();
				if (set.next())
				{
					prices.add(set.getInt(1));
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
		return prices;
	}

	public int getTotalRecords(ArrayList<ArrayList<String>> categoryList)
	{
		String query = "SELECT count(*) FROM items WHERE ";
		boolean firstValue = true;

		for (int i = 0; i < categoryList.size(); ++i)
		{
			if (categoryList.get(i) != null)
			{
				String whereCondition = null;
				if (firstValue)
				{
					whereCondition = "(";
					firstValue = false;
				} else
				{
					whereCondition = " OR (";
				}
				for (int j = 1; j < categoryList.get(i).size(); ++j)
				{
					if (j == categoryList.get(i).size() - 1)
					{
						whereCondition += "item_category_code = ?)";
					} else
					{

						whereCondition += "item_category_code = ? OR ";
					}
				}
				query += whereCondition;
			}
		}

		ResultSet set = null;
		int size = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			int sqlIndex = 1;
			for (int i = 0; i < categoryList.size(); ++i)
			{
				if (categoryList.get(i) != null)
				{
					for (int j = 1; j < categoryList.get(i).size(); ++j)
					{
						prstmt.setString(sqlIndex++, categoryList.get(i).get(j));
					}
				}
			}
			set = prstmt.executeQuery();

			if (set.next())
			{
				size = set.getInt(1);
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
		return size;
	}

	public ArrayList<ItemsDTO> getRecords(ArrayList<ArrayList<String>> categoryList)
	{
		// JOIN 작성 필요
		String query = "SELECT i.item_code, i.item_name, i.item_category_code, c.category_name ,i.item_author_code, a.author_name, i.item_publisher_code, "
				+ "p.publisher_name, i.item_selling_price, i.item_remaining_quantity, i.item_registration_datetime "
				+ "FROM items AS i " + "INNER JOIN itemcategory AS c ON i.item_category_code = c.category_code "
				+ "INNER JOIN authors AS a ON i.item_author_code = a.author_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code WHERE ";

		boolean firstValue = true;

		for (int i = 0; i < categoryList.size(); ++i)
		{
			if (categoryList.get(i) != null)
			{
				String whereCondition = null;
				if (firstValue)
				{
					whereCondition = "(";
					firstValue = false;
				} else
				{
					whereCondition = " OR (";
				}
				for (int j = 1; j < categoryList.get(i).size(); ++j)
				{
					if (j == categoryList.get(i).size() - 1)
					{
						whereCondition += "i.item_category_code = ?)";
					} else
					{

						whereCondition += "i.item_category_code = ? OR ";
					}
				}
				query += whereCondition;
			}
		}

		ResultSet set = null;
		ArrayList<ItemsDTO> books = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			int sqlIndex = 1;
			for (int i = 0; i < categoryList.size(); ++i)
			{
				if (categoryList.get(i) != null)
				{
					for (int j = 1; j < categoryList.get(i).size(); ++j)
					{
						prstmt.setString(sqlIndex++, categoryList.get(i).get(j));
					}
				}
			}
			set = prstmt.executeQuery();
			books = new ArrayList<ItemsDTO>();

			while (set.next())
			{
				books.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
						.setItem_category_code(set.getString(3)).setItem_category_desc(set.getString(4))
						.setItem_author_code(set.getInt(5)).setItem_author_name(set.getString(6))
						.setItem_publisher_code(set.getInt(7)).setItem_publisher_name(set.getString(8))
						.setItem_selling_price(set.getInt(9)).setItem_remaining_quantity(set.getInt(10))
						.setItem_registration_datetime(set.getString(11)));
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

	public int getListSize(String ccode)
	{
		String query = "SELECT count(*) FROM items WHERE item_category_code = ?";
		ResultSet set = null;
		int size = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, ccode);

			set = prstmt.executeQuery();

			if (set.next())
			{
				size = set.getInt(1);
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
		return size;
	}

	public boolean updateBookData(ItemsDTO modifiedData, HashMap<String, String> processingData)
	{
		final int icode = Integer.parseInt(processingData.get("icode"));
		final String ccode = processingData.get("ccode");
		boolean flag = false;

		String query = "UPDATE items SET";
		ArrayList<Method> methods = new ArrayList<Method>();
		ArrayList<String> varNames = new ArrayList<String>();

		try
		{
			Class<?> itemsDtoClass = modifiedData.getClass();

			if (modifiedData.getItem_publication_date() != null)
			{
				varNames.add(" item_publication_date = ?");
				methods.add(itemsDtoClass.getMethod("getItem_publication_date"));
			}
			if (modifiedData.getItem_fixed_price() != 0)
			{
				varNames.add(" item_fixed_price = ?");
				methods.add(itemsDtoClass.getMethod("getItem_fixed_price"));
			}
			if (modifiedData.getItem_selling_price() != 0)
			{
				varNames.add(" item_selling_price = ?");
				methods.add(itemsDtoClass.getMethod("getItem_selling_price"));
			}
			if (modifiedData.getItem_remaining_quantity() != 0)
			{
				varNames.add(" item_remaining_quantity = ?");
				methods.add(itemsDtoClass.getMethod("getItem_remaining_quantity"));
			}
			if (modifiedData.getItem_page_number() != null)
			{
				varNames.add(" item_the_page_number = ?");
				methods.add(itemsDtoClass.getMethod("getItem_page_number"));
			}
			if (modifiedData.getItem_weight() != null)
			{
				varNames.add(" item_weight = ?");
				methods.add(itemsDtoClass.getMethod("getItem_weight"));
			}
			if (modifiedData.getItem_size() != null)
			{
				varNames.add(" item_size = ?");
				methods.add(itemsDtoClass.getMethod("getItem_size"));
			}
			if (modifiedData.getItem_isbn13() != null)
			{
				varNames.add(" item_isbn13 = ?");
				methods.add(itemsDtoClass.getMethod("getItem_isbn13"));
			}
			if (modifiedData.getItem_isbn10() != null)
			{
				varNames.add(" item_isbn10 = ?");
				methods.add(itemsDtoClass.getMethod("getItem_isbn10"));
			}
			if (modifiedData.getItem_book_introduction() != null)
			{
				varNames.add(" item_book_introduction = ?");
				methods.add(itemsDtoClass.getMethod("getItem_book_introduction"));
			}
			if (modifiedData.getItem_contents_table() != null)
			{
				varNames.add(" item_contents_table = ?");
				methods.add(itemsDtoClass.getMethod("getItem_contents_table"));
			}
			if (modifiedData.getItem_publisher_review() != null)
			{
				varNames.add(" item_publisher_review = ?");
				methods.add(itemsDtoClass.getMethod("getItem_publisher_review"));
			}

			for (int index = 0; index < varNames.size(); ++index)
			{
				if (index == varNames.size() - 1)
				{
					query += varNames.get(index) + " WHERE item_code = ? AND item_category_code = ?";
				} else
				{
					query += varNames.get(index) + ",";
				}
			}
		} catch (Exception e)
		{
			return flag;
		}

		ResultSet set = null;
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			int index = 1;
			for (Method method : methods)
			{
				if (method.getReturnType().getName().equals("java.lang.String"))
				{
					prstmt.setString(index++, (String) method.invoke(modifiedData));
				} else if (method.getReturnType().getName().equals("int"))
				{
					prstmt.setInt(index++, (int) method.invoke(modifiedData));
				}
			}
			prstmt.setInt(index++, icode);
			prstmt.setString(index, ccode);

			set = null;
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
				try
				{
					set.close();
				} catch (Exception e2)
				{
					e2.printStackTrace();
				}
		}
		return flag;
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

	private String convertRegion(String region)
	{
		if (region.equals("d"))
		{
			return "국내";
		} else
		{
			return "해외";
		}
	}
}