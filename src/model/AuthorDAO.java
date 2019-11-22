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
		String query = "SELECT * FROM authors WHERE author_code=?";
		ResultSet set = null;
		AuthorDTO authorData = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
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
						.setAuthor_region(set.getString(3)).setAuthor_information(set.getString(4)));
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
			// items 테이블이 아닌 bookAuthors 테이블의 데이터를 수정
			query = "UPDATE authors SET author_name = ?, author_region = ?, author_information = ? WHERE author_code = ?";
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

	public boolean insertAuthors(ArrayList<AuthorDTO> authorList, int icode, String ccode)
	{
		String createAuthorQuery = "INSERT INTO authors VALUES (null, ?, ?, ?)";
		String selectAuthorQuery = "SELECT author_code FROM authors WHERE author_name = ? AND author_region = ? AND author_information = ?";
		String addBookAuthorQuery = "INSERT INTO bookauthors_table VALUES(null, ?, ?, ?)";
		boolean flag = false;
		ResultSet set = null;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt1 = connection.prepareStatement(createAuthorQuery);
				PreparedStatement prstmt2 = connection.prepareStatement(selectAuthorQuery);
				PreparedStatement prstmt3 = connection.prepareStatement(addBookAuthorQuery);)
		{
			ArrayList<Integer> newAuthors = new ArrayList<Integer>();

			for (int index = 0; index < authorList.size(); ++index)
			{
				if (authorList.get(index).getAuthor_code() == -1)
				{
					// 새 저자 정보를 DB에 추가
					prstmt1.setString(1, authorList.get(index).getAuthor_name());
					prstmt1.setString(2, authorList.get(index).getAuthor_region());
					prstmt1.setString(3, authorList.get(index).getAuthor_information());
					newAuthors.add(index);

					prstmt1.addBatch();
				}
			}

			if (prstmt1.executeBatch().length == newAuthors.size())
			{
				for (int index = 0; index < newAuthors.size(); ++index)
				{
					// 새 저자 정보를 DB에 추가
					set = null;
					int listIndex = newAuthors.get(index).intValue();

					prstmt2.setString(1, authorList.get(listIndex).getAuthor_name());
					prstmt2.setString(2, authorList.get(listIndex).getAuthor_region());
					prstmt2.setString(3, authorList.get(listIndex).getAuthor_information());

					set = prstmt2.executeQuery();

					if (set.next())
					{
						authorList.get(listIndex).setAuthor_code(set.getInt(1));
					}
				}
			}

			for (int index = 0; index < authorList.size(); ++index)
			{
				prstmt3.setInt(1, authorList.get(index).getAuthor_code());
				prstmt3.setInt(2, icode);
				prstmt3.setString(3, ccode);

				prstmt3.addBatch();
			}
			if (prstmt3.executeBatch().length == authorList.size())
			{
				flag = true;
			} else
			{
				flag = false;
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