package model;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.sql.DataSource;

public class FileDAO
{
	DataSource dataSource = null;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	public ArrayList<FileDTO> getFiles(int postCode, String writerId, String type)
	{
		String query = null;

		if (type.equals("ANSWER"))
		{
			query = "SELECT * FROM qnaimages_table WHERE qnaimages_answer_post_code = ? AND qnaimages_uploader_id = ?";
		} else if (type.equals("QUESTION"))
		{
			query = "SELECT * FROM qnaimages_table WHERE qnaimages_question_post_code = ? AND qnaimages_uploader_id = ?";
		} else if (type.equals("DETAIL_REVIEW"))
		{
			query = "SELECT * FROM reviewimages_table WHERE reviewimages_post_code = ? AND reviewimages_uploader_id = ?";
		} else if (type.equals("BOOKS"))
		{
			query = "SELECT * FROM itemimages_table WHERE itemimages_item_code = ? AND itemimages_item_category_code = ? AND itemimages_uploader_id = ?";
		}

		ResultSet set = null;
		ArrayList<FileDTO> files = null;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, postCode);
			prstmt.setString(2, writerId);

			set = prstmt.executeQuery();
			files = new ArrayList<FileDTO>();
			while (set.next())
			{
				if (type.equals("BOOKS"))
				{
					files.add(new FileDTO().setImage_code(set.getInt(1)).setItem_code(set.getInt(2))
							.setItem_category_code(set.getString(3)).setFile_uri(set.getString(4))
							.setFile_name(set.getString(5)).setFile_size(set.getInt(6))
							.setUploaded_date_time(set.getString(7)).setUploader_id(set.getString(8))
							.setImage_position(set.getString(9)));
				} else if (!type.equals("DETAIL_REVIEW"))
				{
					files.add(new FileDTO().setImage_code(set.getInt(1)).setQuestion_post_code(set.getInt(2))
							.setAnswer_post_code(set.getInt(3)).setUploader_id(set.getString(4))
							.setFile_uri(set.getString(5)).setFile_name(set.getString(6)).setFile_size(set.getInt(7))
							.setUploaded_date_time(set.getString(8)));
				} else
				{
					files.add(new FileDTO().setImage_code(set.getInt(1)).setReview_code(set.getInt(2))
							.setUploader_id(set.getString(3)).setFile_uri(set.getString(4))
							.setFile_name(set.getString(5)).setFile_size(set.getInt(6))
							.setUploaded_date_time(set.getString(7)));
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
		return files;
	}

	public ArrayList<FileDTO> getItemImages(int icode, String ccode)
	{
		String query = "SELECT * FROM itemimages_table WHERE itemimages_item_code = ? AND itemimages_item_category_code = ?";

		ResultSet set = null;
		ArrayList<FileDTO> images = null;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);

			set = prstmt.executeQuery();
			images = new ArrayList<FileDTO>();

			while (set.next())
			{
				images.add(new FileDTO().setImage_code(set.getInt(1)).setItem_code(set.getInt(2))
						.setItem_category_code(set.getString(3)).setFile_uri(set.getString(4))
						.setFile_name(set.getString(5)).setFile_size(set.getInt(6))
						.setUploaded_date_time(set.getString(7)).setUploader_id(set.getString(8))
						.setImage_position(set.getString(9)));
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
		return images;
	}

	public boolean insertFileToDB(ArrayList<FileDTO> files, int reviewCode)
	{
		String query = "INSERT INTO reviewimages_table VALUES " + "(null, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int i = 0; i < files.size(); ++i)
			{
				prstmt.setInt(1, reviewCode);
				prstmt.setString(2, files.get(i).getUploader_id());
				prstmt.setString(3, files.get(i).getFile_uri());
				prstmt.setString(4, files.get(i).getFile_name());
				prstmt.setInt(5, files.get(i).getFile_size());
				prstmt.setString(6, files.get(i).getUploaded_date_time());

				prstmt.addBatch();
			}
			if (prstmt.executeBatch().length == files.size())
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public void deleteReviewFilesDB(int reviewCode, String uploaderId)
	{
		String deletionQuery = "DELETE FROM reviewimages_table WHERE reviewimages_post_code = ? AND reviewimages_uploader_id = ?";

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(deletionQuery);)
		{
			prstmt.setInt(1, reviewCode);
			prstmt.setString(2, uploaderId);

			prstmt.executeUpdate();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public boolean insertItemImagesToDB(ArrayList<FileDTO> files)
	{
		String query = "INSERT INTO itemimages_table VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int i = 0; i < files.size(); ++i)
			{
				prstmt.setInt(1, files.get(i).getItem_code());
				prstmt.setString(2, files.get(i).getItem_category_code());
				prstmt.setString(3, files.get(i).getFile_uri());
				prstmt.setString(4, files.get(i).getFile_name());
				prstmt.setInt(5, files.get(i).getFile_size());
				prstmt.setString(6, files.get(i).getUploaded_date_time());
				prstmt.setString(7, files.get(i).getUploader_id());
				prstmt.setString(8, files.get(i).getImage_position());

				prstmt.addBatch();
			}
			if (prstmt.executeBatch().length == files.size())
			{
				flag = true;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public boolean updateItemImage(FileDTO newImage)
	{
		String query = "UPDATE itemimages_table SET itemimages_image_uri = ?, itemimages_image_name = ?, itemimages_image_size = ?, itemimages_post_date = ?, itemimages_uploader_id = ? WHERE itemimages_item_code = ? AND itemimages_item_category_code = ? AND itemimages_position = ?";
		boolean flag = false;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{

			prstmt.setString(1, newImage.getFile_uri());
			prstmt.setString(2, newImage.getFile_name());
			prstmt.setInt(3, newImage.getFile_size());
			prstmt.setString(4, newImage.getUploaded_date_time());
			prstmt.setString(5, newImage.getUploader_id());
			prstmt.setInt(6, newImage.getItem_code());
			prstmt.setString(7, newImage.getItem_category_code());
			prstmt.setString(8, newImage.getImage_position());

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

	public boolean deleteRealFiles(ArrayList<FileDTO> files)
	{
		int numFile = 0;

		for (int index = 0; index < files.size(); ++index)
		{
			File file = new File(files.get(index).getFile_uri(), files.get(index).getFile_name());

			if (file.isFile())
			{
				++numFile;
				file.delete();
			}
		}
		if (numFile == files.size())
		{
			return true;
		} else
		{
			return false;
		}
	}
}
