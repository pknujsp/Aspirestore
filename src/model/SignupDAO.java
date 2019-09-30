package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import util.DBConnectionMgr;

public class SignupDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public boolean insertNewUser(SignupDTO dto)
	{
		Connection connection = null;
		PreparedStatement prstmt = null;
		boolean flag = false;

		try
		{
			connection = ds.getConnection();
			String query = "INSERT INTO tblmember";
			String fieldName = "(user_id,user_password,user_birth_date, user_name, user_nickname, user_phone_number, user_gender)";
			query = query + fieldName + " VALUES (?,password(password(?)),?,?,?,?,?)";

			prstmt = connection.prepareStatement(query);

			prstmt.setString(1, dto.getId());
			prstmt.setString(2, dto.getPassword());
			prstmt.setString(3, dto.getBirthdate());
			prstmt.setString(4, dto.getName());
			prstmt.setString(5, dto.getNickname());
			prstmt.setString(6, dto.getPhone());
			prstmt.setString(7, dto.getGender());

			if (1 == prstmt.executeUpdate())
			{
				flag = true;
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
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
