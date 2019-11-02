package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

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
			String query = "INSERT INTO users";
			String fieldName = "(user_id, user_password, user_birth_date, user_name, user_nickname, user_phone1, user_phone2, user_phone3, user_gender)";
			query = query + fieldName + " VALUES (? ,password(password(?)) ,? ,? ,? ,? ,? ,? ,?)";

			prstmt = connection.prepareStatement(query);

			prstmt.setString(1, dto.getId());
			prstmt.setString(2, dto.getPassword());
			prstmt.setString(3, dto.getBirthdate());
			prstmt.setString(4, dto.getName());
			prstmt.setString(5, dto.getNickname());
			prstmt.setString(6, dto.getPhone1());
			prstmt.setString(7, dto.getPhone2());
			prstmt.setString(8, dto.getPhone3());
			prstmt.setString(9, dto.getGender());

			if (prstmt.executeUpdate() == 1)
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
