package model;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.sql.DataSource;

public class QnaDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public ArrayList<QnaDTO> getQuestionList(String userId, HashMap<String, Integer> pageData)
	{
		String query = "SELECT questionslist_code, questionslist_subject, questionslist_category_code, questionslist_post_date, questionslist_status "
				+ "FROM questionlist_table WHERE questionslist_id = ? ORDER BY questionslist_post_date DESC LIMIT ?, ?";
		ArrayList<QnaDTO> list = null;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, userId);
			prstmt.setInt(2, pageData.get("begin_index").intValue());
			prstmt.setInt(3, pageData.get("end_index").intValue());

			set = prstmt.executeQuery();
			list = new ArrayList<QnaDTO>();

			while (set.next())
			{
				String status = null;
				if (set.getString(5).equals("y"))
				{
					status = "답변 완료";
				} else
				{
					status = "미 답변";
				}
				list.add(new QnaDTO().setQuestion_code(set.getInt(1)).setSubject(set.getString(2))
						.setCategory_code(set.getInt(3)).setPost_date(set.getString(4)).setStatus(status));
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
		String query = "SELECT * FROM questionlist_table AS q " + " INNER JOIN question_category_table AS c "
				+ "ON c.question_category_code = q.questionslist_category_code "
				+ "WHERE q.questionslist_code = ? AND q.questionslist_id = ?";
		ResultSet set = null;
		QnaDTO postData = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, questionCode);
			prstmt.setString(2, userId);
			set = prstmt.executeQuery();

			if (set.next())
			{
				String status = null;
				if (set.getString(9).equals("y"))
				{
					status = "답변 완료";
				} else
				{
					status = "미 답변";
				}
				postData = new QnaDTO().setQuestion_code(set.getInt(1)).setUser_id(set.getString(2))
						.setSubject(set.getString(3)).setCategory_code(set.getInt(4)).setContent(set.getString(5))
						.setPost_date(set.getString(6)).setIp(set.getString(7)).setImages_code(set.getInt(8))
						.setStatus(status).setCategory_desc(set.getString(11));
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

	public Integer getAnswerCode(int questionCode, String userId)
	{
		String query = "SELECT answerlist_table.answerlist_code FROM answerlist_table "
				+ "WHERE answerlist_table.answerlist_question_code = ? AND answerlist_table.answerlist_id = ? ";
		ResultSet set = null;
		Integer answerCode = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, questionCode);
			prstmt.setString(2, userId);
			set = prstmt.executeQuery();

			if (set.next())
			{
				answerCode = new Integer(set.getInt(1));
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
		return answerCode;
	}

	public boolean applyAnswer(QnaDTO answerData)
	{
		String query = "INSERT INTO answerlist_table VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, answerData.getQuestion_code());
			prstmt.setString(2, answerData.getUser_id());
			prstmt.setString(3, answerData.getSubject());
			prstmt.setInt(4, answerData.getCategory_code());
			prstmt.setString(5, answerData.getContent());
			prstmt.setString(6, answerData.getPost_date());
			prstmt.setString(7, answerData.getModified_date());
			prstmt.setString(8, answerData.getIp());

			set = prstmt.executeQuery();

			if (set.next())
			{
				flag = true;
				connection.commit();
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

	public boolean uploadFiles(ArrayList<ImageDTO> fileList)
	{
		String query = "INSERT INTO qnaimages_table VALUES (null, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int index = 0; index < fileList.size(); ++index)
			{
				prstmt.setInt(1, fileList.get(index).getQuestion_post_code());
				prstmt.setInt(2, fileList.get(index).getAnswer_post_code());
				prstmt.setString(3, fileList.get(index).getUploader_id());
				prstmt.setString(4, fileList.get(index).getFile_uri());
				prstmt.setString(5, fileList.get(index).getFile_name());
				prstmt.setInt(6, fileList.get(index).getFile_size());
				prstmt.setString(7, fileList.get(index).getUploaded_date_time());

				prstmt.addBatch();
			}
			if (prstmt.executeBatch().length == fileList.size())
			{
				flag = true;
				connection.commit();
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}

}
