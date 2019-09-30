package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}