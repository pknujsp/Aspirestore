package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
						.setAuthor_region(set.getNString(3)).setAuthor_information(set.getString(4));

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
}