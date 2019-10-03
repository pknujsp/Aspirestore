package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;

public class PublisherDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public String getPublisherName(int publisherCode)
	{
		String query = "SELECT publisher_name FROM publishers WHERE publisher_code = ?";
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, publisherCode);
			ResultSet set = prstmt.executeQuery();
			
			while(set.next())
			{
				return set.getString(1);
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
}
