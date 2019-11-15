package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.sql.DataSource;

public class AuthorDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public AuthorDTO getAuthorInformation(int acode)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		ResultSet set = null;
		AuthorDTO authorData = null;

		try
		{
			String query = "SELECT * FROM authors WHERE author_code=?";
			connection = ds.getConnection();
			prstmt = connection.prepareStatement(query);

			prstmt.setInt(1, acode);
			set = prstmt.executeQuery();

			while (set.next())
			{
				authorData = new AuthorDTO().setAuthor_code(acode).setAuthor_name(set.getString(2))
						.setAuthor_region(convertRegion(set.getString(3))).setAuthor_information(set.getString(4));
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
		return authorData;
	}

	public ArrayList<AuthorDTO> getAuthors(ArrayList<Integer> codes)
	{
		String query = "SELECT author_name FROM authors WHERE author_code = ?";
		ResultSet set = null;
		ArrayList<AuthorDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{

			list = new ArrayList<AuthorDTO>(codes.size());

			for (int i = 0; i < codes.size(); ++i)
			{
				set = null;
				prstmt.setInt(1, codes.get(i).intValue());
				set = prstmt.executeQuery();

				if (set.next())
				{
					list.add(new AuthorDTO().setAuthor_name(set.getString(1)));
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

	public ArrayList<AuthorDTO> getAuthors(String authorName)
	{
		String query = "SELECT * FROM authors WHERE author_name LIKE ?";
		ResultSet set = null;
		ArrayList<AuthorDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, "%" + authorName + "%");
			set = prstmt.executeQuery();

			list = new ArrayList<AuthorDTO>();
			while (set.next())
			{
				list.add(new AuthorDTO().setAuthor_code(set.getInt(1)).setAuthor_name(set.getString(2))
						.setAuthor_region(convertRegion(set.getString(3))).setAuthor_information(set.getString(4)));
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

	public boolean updateAuthorData(AuthorDTO modifiedData, HashMap<String, String> processingDataMap, String status)
	{
		boolean flag = false;
		String query = null;
		String itemQuery = null;

		if (status.equals("MODIFIED_AUTHOR_INFO"))
		{
			query = "UPDATE authors SET author_name = ?, author_region = ?, author_information = ? WHERE author_code = ?";
		} else
		{
			// REPLACED_AUTHOR
			query = "UPDATE authors SET author_name = ?, author_region = ?, author_information = ? WHERE author_code = ?";
			itemQuery = "UPDATE items SET item_author_code = ? WHERE item_code = ? AND item_category_code = ?";
		}

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				PreparedStatement itemPrstmt = checkQueryNull(itemQuery, connection);)
		{
			prstmt.setString(1, modifiedData.getAuthor_name());
			prstmt.setString(2, modifiedData.getAuthor_region());
			prstmt.setString(3, modifiedData.getAuthor_information());
			prstmt.setInt(4, modifiedData.getAuthor_code());

			if (status.equals("REPLACED_AUTHOR"))
			{
				itemPrstmt.setInt(1, modifiedData.getAuthor_code());
				itemPrstmt.setInt(2, Integer.parseInt(processingDataMap.get("icode")));
				itemPrstmt.setString(3, processingDataMap.get("ccode"));
				flag = true;
			} else
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
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

	private PreparedStatement checkQueryNull(String itemQuery, Connection connection) throws SQLException
	{
		if (itemQuery == null)
		{
			return null;
		} else
		{
			return connection.prepareStatement(itemQuery);
		}
	}
}