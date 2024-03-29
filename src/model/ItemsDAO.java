package model;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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

	public ItemsDTO getItem(String ccode, int icode)
	{
		String query = "SELECT * FROM items AS i "
				+ "INNER JOIN itemcategory AS c ON i.item_category_code = c.category_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code "
				+ "INNER JOIN bookauthors_table AS aulist ON aulist.bookAuthors_item_code = i.item_code AND aulist.bookAuthors_item_category_code = i.item_category_code "
				+ "INNER JOIN authors AS au ON aulist.bookAuthors_author_code = au.author_code "
				+ "WHERE item_code= ? AND item_category_code= ?";
		ResultSet set = null;
		ItemsDTO item = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			// 저자 정보를 가져오는 코드 작성 필요

			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			set = prstmt.executeQuery();

			for (int index = 0; set.next(); ++index)
			{
				if (index == 0)
				{
					item = new ItemsDTO().setItem_code(set.getInt("item_code")).setItem_name(set.getString("item_name"))
							.setItem_publisher_code(set.getInt("item_publisher_code"))
							.setItem_publication_date(set.getString("item_publication_date"))
							.setItem_fixed_price(set.getInt("item_fixed_price"))
							.setItem_selling_price(set.getInt("item_selling_price"))
							.setItem_remaining_quantity(set.getInt("item_remaining_quantity"))
							.setItem_category_code(set.getString("item_category_code"))
							.setItem_page_number(set.getString("item_the_page_number"))
							.setItem_weight(set.getString("item_weight")).setItem_size(set.getString("item_size"))
							.setItem_isbn13(set.getString("item_isbn13")).setItem_isbn10(set.getString("item_isbn10"))
							.setItem_book_introduction(set.getString("item_book_introduction"))
							.setItem_contents_table(set.getString("item_contents_table"))
							.setItem_publisher_review(set.getString("item_publisher_review"))
							.setItem_registration_datetime(set.getString("item_registration_datetime"))
							.setItem_category_desc(set.getString("category_name"))
							.setItem_publisher_name(set.getString("publisher_name"));

					item.setPublisher(new PublisherDTO().setPublisher_code(set.getInt("publisher_code"))
							.setPublisher_name(set.getString("publisher_name"))
							.setPublisher_region(set.getString("publisher_region")));
				}
				item.setAuthors(new AuthorDTO().setAuthor_code(set.getInt("author_code"))
						.setAuthor_name(set.getString("author_name"))
						.setAuthor_information(set.getString("author_information"))
						.setAuthor_region(set.getString("author_region")));
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
		return item;
	}

	public ArrayList<ItemsDTO> getItemList(String ccode, String sortType, int startIdx, int endIdx)
	{
		ResultSet set = null;
		ArrayList<ItemsDTO> bookList = null;
		HashSet<String> codeSet = new HashSet<String>();

		String query = "SELECT i.item_code, i.item_name, i.item_publisher_code, i.item_publication_date, i.item_selling_price"
				+ ", i.item_book_introduction, i.item_category_code, p.publisher_name, r.rinfo_sreview_num, r.rinfo_dreview_num, r.rinfo_total_rating "
				+ ", au.author_code, au.author_name " + "FROM items AS i "
				+ "INNER JOIN publishers AS p ON p.publisher_code = i.item_publisher_code "
				+ "INNER JOIN itemreviewinfo_table AS r ON r.rinfo_item_code = i.item_code AND r.rinfo_item_category_code = i.item_category_code "
				+ "INNER JOIN bookauthors_table AS aulist ON aulist.bookAuthors_item_code = i.item_code AND aulist.bookAuthors_item_category_code = i.item_category_code "
				+ "INNER JOIN authors AS au ON aulist.bookAuthors_author_code = au.author_code "
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
			bookList = new ArrayList<ItemsDTO>();

			prstmt.setString(1, ccode);
			prstmt.setInt(2, startIdx);
			prstmt.setInt(3, endIdx);

			set = prstmt.executeQuery();

			int index = 0;
			while (set.next())
			{
				double rating = 0.0;
				String ratingStr = null;
				String code = String.valueOf(set.getInt(1)) + set.getString(7);

				if (set.getInt(11) != 0)
				{
					rating = ((double) set.getInt(11) / (double) (set.getInt(9) + set.getInt(10)));
					ratingStr = new DecimalFormat("#.#").format(rating) + "/5";
				} else
				{
					ratingStr = "리뷰 없음";
				}

				if (checkExtraAuthor(codeSet, code))
				{
					bookList.get(index - 1).setAuthors(
							new AuthorDTO().setAuthor_code(set.getInt(12)).setAuthor_name(set.getString(13)));
				} else
				{
					bookList.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_publisher_code(set.getInt(3)).setItem_publication_date(set.getString(4))
							.setItem_selling_price(set.getInt(5)).setItem_book_introduction(cutString(set.getString(6)))
							.setItem_category_code(set.getString(7)).setItem_publisher_name(set.getString(8))
							.setItem_rating(ratingStr).setAuthors(
									new AuthorDTO().setAuthor_code(set.getInt(12)).setAuthor_name(set.getString(13))));

					codeSet.add(code);
					++index;
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
				} catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
		return bookList;
	}

	public ArrayList<ItemsDTO> getitemsForBasket(HashMap<Integer, String> codeMap)
	{
		String query = "SELECT * FROM items AS i "
				+ "INNER JOIN itemcategory AS c ON i.item_category_code = c.category_code "
				+ "INNER JOIN publishers AS p ON i.item_publisher_code = p.publisher_code "
				+ "WHERE item_code= ? AND item_category_code= ?";
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
					list.add(new ItemsDTO().setItem_code(set.getInt("item_code"))
							.setItem_name(set.getString("item_name"))
							.setItem_publisher_code(set.getInt("item_publisher_code"))
							.setItem_selling_price(set.getInt("item_selling_price"))
							.setItem_category_code(set.getString("item_category_code"))
							.setItem_category_desc(set.getString("category_name"))
							.setItem_publisher_name(set.getString("publisher_name")));
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

	public boolean getBookForOrderForm(BasketDTO book)
	{
		String query = "SELECT i.item_name, i.item_selling_price, i.item_publisher_code, p.publisher_name"
				+ ", c.category_name " + "FROM items AS i "
				+ "INNER JOIN publishers AS p ON p.publisher_code = i.item_publisher_code "
				+ "INNER JOIN itemcategory AS c ON c.category_code = i.item_category_code "
				+ "WHERE i.item_code = ? AND i.item_category_code = ?";

		ResultSet set = null;
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, book.getBooks().get(0).getItem_code());
			prstmt.setString(2, book.getBooks().get(0).getItem_category_code());

			set = prstmt.executeQuery();

			if (set.next())
			{
				book.getBooks().get(0).setItem_name((set.getString(1)));
				book.getBooks().get(0).setItem_selling_price(set.getInt(2));
				book.getBooks().get(0).setItem_publisher_code(set.getInt(3));
				book.getBooks().get(0).setItem_publisher_name(set.getString(4));
				book.getBooks().get(0).setItem_category_desc(set.getString(5));

				flag = true;
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

	public ArrayList<Integer> getBookSellingPrice(ArrayList<ItemsDTO> books)
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
				prstmt.setString(2, books.get(i).getItem_category_code());
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
		String query = "SELECT i.item_code, i.item_name, i.item_category_code, c.category_name, i.item_publisher_code, "
				+ "p.publisher_name, i.item_selling_price, i.item_remaining_quantity, i.item_registration_datetime "
				+ "FROM items AS i " + "INNER JOIN itemcategory AS c ON i.item_category_code = c.category_code "
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
						.setItem_publisher_code(set.getInt(5)).setItem_publisher_name(set.getString(6))
						.setItem_selling_price(set.getInt(7)).setItem_remaining_quantity(set.getInt(8))
						.setItem_registration_datetime(set.getString(9)));
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

	public int insertNewBook(ItemsDTO bookData, String currentTime)
	{
		String query = "INSERT INTO items VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String codeQuery = "SELECT item_code FROM items WHERE item_name = ? AND item_category_code = ?";
		int itemCode = -1;
		ResultSet set = null;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				PreparedStatement prstmt2 = connection.prepareStatement(codeQuery);)
		{
			prstmt.setString(1, bookData.getItem_name());
			prstmt.setNull(2, Types.INTEGER);
			prstmt.setString(3, bookData.getItem_publication_date());
			prstmt.setInt(4, bookData.getItem_fixed_price());
			prstmt.setInt(5, bookData.getItem_selling_price());
			prstmt.setInt(6, bookData.getItem_remaining_quantity());
			prstmt.setString(7, bookData.getItem_category_code());
			prstmt.setString(8, bookData.getItem_page_number());
			prstmt.setString(9, bookData.getItem_weight());
			prstmt.setString(10, bookData.getItem_size());
			prstmt.setString(11, bookData.getItem_isbn13());
			prstmt.setString(12, bookData.getItem_isbn10());
			prstmt.setString(13, bookData.getItem_book_introduction());
			prstmt.setString(14, bookData.getItem_contents_table());
			prstmt.setString(15, bookData.getItem_publisher_review());
			prstmt.setString(16, currentTime);

			if (prstmt.executeUpdate() == 1)
			{
				prstmt2.setString(1, bookData.getItem_name());
				prstmt2.setString(2, bookData.getItem_category_code());

				set = prstmt2.executeQuery();
				if (set.next())
				{
					itemCode = set.getInt(1);
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
		return itemCode;
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

	public int calculateTotalPrice(ArrayList<ItemsDTO> books)
	{
		String query = "SELECT item_selling_price FROM items WHERE item_code = ? AND item_category_code = ?";
		ResultSet set = null;

		int totalPriceDB = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int index = 0; index < books.size(); ++index)
			{
				set = null;
				prstmt.setInt(1, books.get(index).getItem_code());
				prstmt.setString(2, books.get(index).getItem_category_code());

				set = prstmt.executeQuery();
				if (set.next())
				{
					totalPriceDB += set.getInt(1) * books.get(index).getOrder_quantity();
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
		return totalPriceDB;
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

	private boolean checkExtraAuthor(HashSet<String> codeSet, String code)
	{
		return codeSet.contains(code) ? true : false;
	}
}