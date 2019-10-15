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
		String query = "INSERT INTO userinfo VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_id());
			prstmt.setString(2, data.getUser_name());
			prstmt.setString(3, data.getMobile1());
			prstmt.setString(4, data.getMobile2());
			prstmt.setString(5, data.getMobile3());
			prstmt.setString(6, data.getGeneral1());
			prstmt.setString(7, data.getGeneral2());
			prstmt.setString(8, data.getGeneral3());
			prstmt.setString(9, Util.getCurrentDateTime());

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
		String query = "SELECT userinfo_name, userinfo_mobile1, userinfo_mobile2, userinfo_mobile3, userinfo_general1, userinfo_general2, userinfo_general3 FROM userinfo WHERE userinfo_id = ?";
		UserDTO data = null;
		ResultSet set = null;
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);

			set = prstmt.executeQuery();
			while (set.next())
			{
				data = new UserDTO();
				data.setUser_name(set.getString(1)).setMobile1(set.getString(2)).setMobile2(set.getString(3))
						.setMobile3(set.getString(4)).setGeneral1(set.getString(5)).setGeneral2(set.getString(6))
						.setGeneral3(set.getString(7)).setDate_time(Util.getCurrentDateTime());
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
		String query = "UPDATE userinfo SET userinfo_name = ?, userinfo_mobile1 = ?, userinfo_mobile2 = ?, userinfo_mobile3 = ?, userinfo_general1 = ?, userinfo_general2 = ?, userinfo_general3 = ?, userinfo_datetime = ? WHERE userinfo_id = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_name());
			prstmt.setString(2, data.getMobile1());
			prstmt.setString(3, data.getMobile2());
			prstmt.setString(4, data.getMobile3());
			prstmt.setString(5, data.getGeneral1());
			prstmt.setString(6, data.getGeneral2());
			prstmt.setString(7, data.getGeneral3());
			prstmt.setString(8, Util.getCurrentDateTime());
			prstmt.setString(9, data.getUser_id());

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
}
