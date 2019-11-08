package model;

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
		} else
		{
			query = "SELECT * FROM qnaimages_table WHERE qnaimages_question_post_code = ? AND qnaimages_uploader_id = ?";
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
				files.add(new FileDTO().setImage_code(set.getInt(1)).setQuestion_post_code(set.getInt(2))
						.setAnswer_post_code(set.getInt(3)).setUploader_id(set.getString(4))
						.setFile_uri(set.getString(5)).setFile_name(set.getString(6)).setFile_size(set.getInt(7))
						.setUploaded_date_time(set.getString(8)));
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
			if(prstmt.executeBatch().length == files.size())
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
