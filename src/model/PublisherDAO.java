package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

			while (set.next())
			{
				return set.getString(1);
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public ArrayList<PublisherDTO> getPublishers(ArrayList<Integer> codes)
	{
		String query = "SELECT publisher_name FROM publishers WHERE publisher_code = ?";
		ResultSet set = null;
		ArrayList<PublisherDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			list = new ArrayList<PublisherDTO>(codes.size());
			for (int i = 0; i < codes.size(); ++i)
			{
				set = null;
				prstmt.setInt(1, codes.get(i).intValue());
				set = prstmt.executeQuery();

				if (set.next())
				{
					list.add(new PublisherDTO().setPublisher_name(set.getString(1)));
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

	public ArrayList<PublisherDTO> getPublishers(String publisherName)
	{
		String query = "SELECT * FROM publishers WHERE publisher_name LIKE ?";
		ResultSet set = null;
		ArrayList<PublisherDTO> list = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, "%" + publisherName + "%");
			set = prstmt.executeQuery();

			list = new ArrayList<PublisherDTO>();
			while (set.next())
			{
				list.add(new PublisherDTO().setPublisher_code(set.getInt(1)).setPublisher_name(set.getString(2))
						.setPublisher_region(convertRegion(set.getString(3))));
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

	private String convertRegion(String region)
	{
		if (region.equals("d"))
		{
			return "국내";
		} else
		{
			return "해외";
		}
	}
}
