package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.sql.DataSource;

import etc.Util;

public class AddressDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ArrayList<AddressDTO> getAddressList(String user_id)
	{
		String query = "SELECT * FROM addressbook WHERE addressbook_user_id = ? ORDER BY address_book_code ASC";
		ArrayList<AddressDTO> list = new ArrayList<AddressDTO>();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, user_id);
			ResultSet set = prstmt.executeQuery();

			while (set.next())
			{
				list.add(new AddressDTO().setUser_id(set.getString(1)).setCode(set.getInt(2))
						.setPostal_code(set.getString(3)).setRoad(set.getString(4)).setNumber(set.getString(5))
						.setDetail(set.getString(6)));
			}

			set.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteAddress(String userId, int code)
	{
		String query = "DELETE FROM addressbook WHERE addressbook_user_id = ? AND addressbook_code = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			prstmt.setInt(2, code);
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

	public AddressDTO getLatestAddress(String user_id)
	{
		String query = "SELECT * FROM addressbook WHERE addressbook_user_id = ? ORDER BY addressbook_last_usage DESC LIMIT 1";
		ResultSet set = null;
		AddressDTO data = null;
		
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, user_id);
			set = prstmt.executeQuery();

			while (set.next())
			{
				data = new AddressDTO().setUser_id(set.getString(1)).setCode(set.getInt(2))
						.setPostal_code(set.getString(3)).setRoad(set.getString(4)).setNumber(set.getString(5))
						.setDetail(set.getString(6));
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

	public boolean insertAddressToBook(AddressDTO data)
	{
		String query = "INSERT INTO addressbook VALUES (?, null, ?, ?, ?, ?, ?)";

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, data.getUser_id());
			prstmt.setString(2, data.getPostal_code());
			prstmt.setString(3, data.getRoad());
			prstmt.setString(4, data.getNumber());
			prstmt.setString(5, data.getDetail());
			prstmt.setString(6, Util.getCurrentDateTime());

			if (prstmt.executeUpdate() == 1)
			{
				return true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateLastUsageDateTime(String user_id, int code)
	{
		String query = "UPDATE addressbook SET addressbook_last_usage = ? WHERE addressbook_user_id = ? AND addressbook_code = ?";

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, Util.getCurrentDateTime());
			prstmt.setString(2, user_id);
			prstmt.setInt(3, code);

			if (prstmt.executeUpdate() == 1)
			{
				return true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}
}
