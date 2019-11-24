package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.sql.DataSource;

public class CategoryDAO
{
	DataSource ds = null;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public HashMap<String, HashMap<String, String>> getAllCategory()
	{
		String query = "SELECT * FROM itemcategory ORDER BY category_parent_code ASC";
		HashMap<String, HashMap<String, String>> categoryMap = new HashMap<String, HashMap<String,String>>();

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				ResultSet set = prstmt.executeQuery();)
		{
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return categoryMap;
	}
}
