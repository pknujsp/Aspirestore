package model;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

public class QnaDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ArrayList<QnaDTO> getQuestionList(String userId)
	{
		String query = "SELECT questionslist_code, questionslist_subject, questionslist_category_code, questionslist_post_date, questionslist_status "
				+ "FROM questionlist_table FROM questionslist_id = \'" + userId + "\'";
		ArrayList<QnaDTO> list = null;

		try (Connection connection = ds.getConnection();
				Statement stmt = connection.createStatement();
				ResultSet set = stmt.executeQuery(query);)
		{
			if (set.next())
			{
				list = new ArrayList<QnaDTO>();
			}
			while (set.next())
			{
				list.add(new QnaDTO().setQuestion_code(set.getInt(1)).setSubject(set.getString(2))
						.setCategory_code(set.getInt(3)).setPost_date(set.getString(4)));
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}

	public int getQuestionListSize(String userId)
	{
		String query = "SELECT count(*) " + "FROM questionlist_table WHERE questionslist_id = \'" + userId + "\'";
		int listSize = 0;

		try (Connection connection = ds.getConnection();
				Statement stmt = connection.createStatement();
				ResultSet set = stmt.executeQuery(query);)
		{
			if (set.next())
			{
				listSize = set.getInt(1);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return listSize;
	}

	public QnaDTO getQuestionPost(String userId, int questionCode)
	{
		String query = "SELECT * FROM questionlist_table WHERE questionslist_code = ? AND questionslist_id = ?";
		ResultSet set = null;
		QnaDTO postData = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, questionCode);
			prstmt.setString(2, userId);
			set = prstmt.executeQuery();

			if (set.next())
			{
				postData = new QnaDTO().setQuestion_code(set.getInt(1)).setUser_id(set.getString(2))
						.setSubject(set.getString(3)).setCategory_code(set.getInt(4)).setContent(set.getString(5))
						.setPost_date(set.getString(6)).setIp(set.getString(7)).setImages_code(set.getInt(8))
						.setStatus(set.getString(9));
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
		return postData;
	}
}
