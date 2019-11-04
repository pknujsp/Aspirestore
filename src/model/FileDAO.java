package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

public class FileDAO
{
	DataSource dataSource = null;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	public ArrayList<fileDTO> getFiles(int postCode, String writerId, String type)
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
		ArrayList<fileDTO> files = null;

		try (Connection connection = dataSource.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, postCode);
			prstmt.setString(2, writerId);

			set = prstmt.executeQuery();
			files = new ArrayList<fileDTO>();
			while (set.next())
			{
				files.add(new fileDTO().setImage_code(set.getInt(1)).setQuestion_post_code(set.getInt(2))
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
}
