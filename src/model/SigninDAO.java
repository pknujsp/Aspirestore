package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import util.DBConnectionMgr;

public class SigninDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public boolean signIn(String email, String password)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		ResultSet set = null;
		boolean flag = false;

		try
		{
			connection = ds.getConnection();
			String query = "SELECT COUNT(user_id) FROM users WHERE user_id=? AND user_password=password(password(?))";
			prstmt = connection.prepareStatement(query);

			prstmt.setString(1, email);
			prstmt.setString(2, password);

			set = prstmt.executeQuery();
			set.next();
			if (set.getInt(1) == 1)
			{
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

		return flag;
	}
}