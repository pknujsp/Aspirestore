package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.sql.DataSource;

import etc.Util;

public class UserDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public boolean insertUserInfo(UserDTO data)
	{
		String query = "INSERT INTO userinfo VALUES (?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_id());
			prstmt.setString(2, data.getUser_name());
			prstmt.setString(3, data.getMobile());
			prstmt.setString(4, data.getGeneral());
			prstmt.setString(5, Util.getCurrentDateTime());

			if (prstmt.executeUpdate() == 1)
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public boolean isExistingData(String userId) 
	{
		String query = "SELECT count(userinfo_id) FROM userinfo WHERE userinfo_id = ?";
		boolean flag = false;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			set = prstmt.executeQuery();
			if (set.next())
			{
				if (set.getInt(1) == 1)
				{
					flag = true;
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
		return flag;
	}

	public UserDTO getUserInfo(String userId)
	{
		String query = "SELECT userinfo_name, userinfo_mobile, userinfo_general FROM userinfo WHERE userinfo_id = ?";
		UserDTO data = null;
		ResultSet set = null;
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);

			set = prstmt.executeQuery();
			while (set.next())
			{
				data = new UserDTO();
				String[] separatedPhone = getSeparatedNumber(set.getString(2));
				String[] separatedGeneral = getSeparatedNumber(set.getString(3));

				data.setUser_name(set.getString(1)).setMobile1(separatedPhone[0]).setMobile2(separatedPhone[1])
						.setMobile3(separatedPhone[2]).setGeneral1(separatedGeneral[0]).setGeneral2(separatedGeneral[1])
						.setGeneral3(separatedGeneral[2]).setDate_time(Util.getCurrentDateTime());
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
		return data;
	}

	public boolean updateUserInfo(UserDTO data)
	{
		String query = "UPDATE userinfo SET userinfo_name = ?, userinfo_mobile = ?, userinfo_general = ?, userinfo_datetime = ? WHERE userinfo_id = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_name());
			prstmt.setString(2, data.getMobile());
			prstmt.setString(3, data.getGeneral());
			prstmt.setString(4, Util.getCurrentDateTime());
			prstmt.setString(5, data.getUser_id());

			if (prstmt.executeUpdate() == 1)
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	private String[] getSeparatedNumber(String str)
	{
		return new String[]
		{ str.substring(0, 3), str.substring(3, 7), str.substring(7, 11) };
	}
}
