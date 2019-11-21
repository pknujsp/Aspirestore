package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

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
						.setPublisher_region(set.getString(3)));
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

	public boolean updatePublisherData(PublisherDTO modifiedData, HashMap<String, String> processingDataMap,
			String status)
	{
		boolean flag = false;
		String query = null;
		String itemQuery = null;

		if (status.equals("MODIFIED_PUBLISHER_INFO"))
		{
			query = "UPDATE publishers SET publisher_name = ?, publisher_region = ? WHERE publisher_code = ?";
		} else
		{
			// REPLACED_PUBLISHER
			query = "UPDATE publishers SET publisher_name = ?, publisher_region = ? WHERE publisher_code = ?";
			itemQuery = "UPDATE items SET item_publisher_code = ? WHERE item_code = ? AND item_category_code = ?";
		}

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				PreparedStatement itemPrstmt = checkQueryNull(itemQuery, connection);)
		{
			prstmt.setString(1, modifiedData.getPublisher_name());
			prstmt.setString(2, modifiedData.getPublisher_region());
			prstmt.setInt(3, modifiedData.getPublisher_code());

			if (status.equals("REPLACED_PUBLISHER"))
			{
				itemPrstmt.setInt(1, modifiedData.getPublisher_code());
				itemPrstmt.setInt(2, Integer.parseInt(processingDataMap.get("icode")));
				itemPrstmt.setString(3, processingDataMap.get("ccode"));
				flag = true;
			} else
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public boolean insertPublisher(PublisherDTO publisherData, int icode, String ccode)
	{
		String insertNewPubQuery = null;
		String selectNewPubCodeQuery = null;
		String insertExistingPubQuery = "UPDATE items SET item_publisher_code = ? WHERE item_code = ? AND item_category_code = ?";
		ResultSet set = null;
		boolean flag = false;

		if (publisherData.getPublisher_code() == -1)
		{
			// 새로운 출판사
			insertNewPubQuery = "INSERT INTO publishers VALUES (null, ?, ?)";
			selectNewPubCodeQuery = "SELECT publisher_code FROM publishers WHERE publisher_name = ? AND publisher_region = ?";
		}

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt1 = checkQueryNull(insertNewPubQuery, connection);
				PreparedStatement prstmt2 = checkQueryNull(selectNewPubCodeQuery, connection);
				PreparedStatement prstmt3 = connection.prepareStatement(insertExistingPubQuery);)
		{
			if (insertNewPubQuery != null)
			{
				prstmt1.setString(1, publisherData.getPublisher_name());
				prstmt1.setString(2, publisherData.getPublisher_region());

				if (prstmt1.executeUpdate() == 1)
				{
					prstmt2.setString(1, publisherData.getPublisher_name());
					prstmt2.setString(2, publisherData.getPublisher_region());

					set = prstmt2.executeQuery();
					if (set.next())
					{
						publisherData.setPublisher_code(set.getInt(1));
					}
				}
			}
			prstmt3.setInt(1, publisherData.getPublisher_code());
			prstmt3.setInt(2, icode);
			prstmt3.setString(3, ccode);

			if (prstmt3.executeUpdate() == 1)
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
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		return flag;
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

	private PreparedStatement checkQueryNull(String itemQuery, Connection connection) throws SQLException
	{
		if (itemQuery == null)
		{
			return null;
		} else
		{
			return connection.prepareStatement(itemQuery);
		}
	}
}
