package model;

import java.sql.Statement;
import java.sql.Types;
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

	public ArrayList<QnaDTO> getAnswerList(String managerId, int beginIndex, int endIndex)
	{
		String query = "SELECT a.answerlist_code, a.answerlist_question_code, q.questionslist_id, a.answerlist_subject, qc.question_category_description, a.answerlist_post_date "
				+ "FROM answerlist_table AS a "
				+ "INNER JOIN questionlist_table AS q ON q.questionslist_code = a.answerlist_question_code "
				+ "INNER JOIN question_category_table AS qc ON qc.question_category_code = a.answerlist_category_code "
				+ "WHERE a.answerlist_id = ? ORDER BY a.answerlist_post_date DESC LIMIT ?, ?";
		ArrayList<QnaDTO> list = null;
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, managerId);
			prstmt.setInt(2, beginIndex);
			prstmt.setInt(3, endIndex);

			set = prstmt.executeQuery();
			list = new ArrayList<QnaDTO>();

			while (set.next())
			{
				list.add(new QnaDTO().setAnswer_code(set.getInt(1)).setQuestion_code(set.getInt(2))
						.setUser_id(set.getString(3)).setSubject(set.getString(4)).setCategory_desc(set.getString(5))
						.setPost_date(set.getString(6)));
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

	public int getListSize(String userId, String tableType)
	{
		String query = null;

		if (tableType.equals("QUESTION"))
		{
			query = "SELECT count(*) FROM questionlist_table WHERE questionslist_id = \'" + userId + "\'";
		} else
		{
			// ANSWER
			query = "SELECT count(*) FROM answerlist_table";
		}
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
				if (set.getString(8).equals("y"))
				{
					status = "답변 완료";
				} else
				{
					status = "미 답변";
				}
				postData = new QnaDTO().setQuestion_code(set.getInt(1)).setUser_id(set.getString(2))
						.setSubject(set.getString(3)).setCategory_code(set.getInt(4)).setContent(set.getString(5))
						.setPost_date(set.getString(6)).setIp(set.getString(7)).setNumFiles(set.getInt(9))
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

	public QnaDTO getAnswerPost(String managerId, int answerCode)
	{
		String query = "SELECT * FROM answerlist_table AS a " + " INNER JOIN question_category_table AS c "
				+ "ON c.question_category_code = a.answerlist_category_code "
				+ "WHERE a.answerlist_code = ? AND a.answerlist_id = ?";
		ResultSet set = null;
		QnaDTO postData = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, answerCode);
			prstmt.setString(2, managerId);
			set = prstmt.executeQuery();

			if (set.next())
			{
				postData = new QnaDTO().setAnswer_code(set.getInt(1)).setQuestion_code(set.getInt(2))
						.setUser_id(set.getString(3)).setSubject(set.getString(4)).setCategory_code(set.getInt(5))
						.setContent(set.getString(6)).setPost_date(set.getString(7)).setIp(set.getString(9))
						.setNumFiles(set.getInt(8)).setCategory_desc(set.getString(11));
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

	public QnaDTO getAnswerPost(int questionCode)
	{
		String query = "SELECT * FROM answerlist_table AS a " + " INNER JOIN question_category_table AS c "
				+ "ON c.question_category_code = a.answerlist_category_code " + "WHERE a.answerlist_question_code = ?";
		ResultSet set = null;
		QnaDTO postData = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, questionCode);
			set = prstmt.executeQuery();

			if (set.next())
			{
				postData = new QnaDTO().setAnswer_code(set.getInt(1)).setQuestion_code(set.getInt(2))
						.setUser_id(set.getString(3)).setSubject(set.getString(4)).setCategory_code(set.getInt(5))
						.setContent(set.getString(6)).setPost_date(set.getString(7)).setIp(set.getString(9))
						.setNumFiles(set.getInt(8)).setCategory_desc(set.getString(11));
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

	public int applyPost(QnaDTO postData, char tableType)
	{
		String insertQuery = null;
		String selectQuery = null;
		String changeStatusQuery = null;
		if (tableType == 'a')
		{
			// ANSWER
			insertQuery = "INSERT INTO answerlist_table VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
			selectQuery = "SELECT answerlist_code FROM answerlist_table WHERE answerlist_question_code = ? AND answerlist_id = ? ORDER BY answerlist_post_date DESC";
		} else
		{
			// QUESTION
			insertQuery = "INSERT INTO questionlist_table VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
			selectQuery = "SELECT questionslist_code FROM questionlist_table WHERE questionslist_id = ? ORDER BY questionslist_post_date DESC";
		}

		ResultSet set = null;
		int tableCode = 0;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(insertQuery);
				PreparedStatement prstmt2 = connection.prepareStatement(selectQuery);)
		{
			if (tableType == 'a')
			{
				prstmt.setInt(1, postData.getQuestion_code());
				prstmt.setString(2, postData.getUser_id());
				prstmt.setString(3, postData.getSubject());
				prstmt.setInt(4, postData.getCategory_code());
				prstmt.setString(5, postData.getContent());
				prstmt.setString(6, postData.getPost_date());
				prstmt.setInt(7, postData.getNumFiles());
				prstmt.setString(8, postData.getIp());

				prstmt2.setInt(1, postData.getQuestion_code());
				prstmt2.setString(2, postData.getUser_id());
			} else
			{
				prstmt.setString(1, postData.getUser_id());
				prstmt.setString(2, postData.getSubject());
				prstmt.setInt(3, postData.getCategory_code());
				prstmt.setString(4, postData.getContent());
				prstmt.setString(5, postData.getPost_date());
				prstmt.setString(6, postData.getIp());
				prstmt.setString(7, postData.getStatus());
				prstmt.setInt(8, postData.getNumFiles());

				prstmt2.setString(1, postData.getUser_id());
			}

			if (prstmt.executeUpdate() == 1)
			{
				set = prstmt2.executeQuery();

				if (set.next())
				{
					tableCode = set.getInt(1);
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return tableCode;
	}

	public boolean changeAnswerStatus(String questionerId, int questionCode)
	{
		String changeStatusQuery = "UPDATE questionlist_table SET questionslist_status = ? WHERE questionslist_user_id = ? AND questionslist_code = ?";
		boolean flag = false;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(changeStatusQuery);)
		{
			prstmt.setString(1, "y");
			prstmt.setString(2, questionerId);
			prstmt.setInt(3, questionCode);

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

	public boolean uploadFiles(ArrayList<fileDTO> fileList, int code)
	{
		String query = "INSERT INTO qnaimages_table VALUES (null, ?, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int index = 0; index < fileList.size(); ++index)
			{
				if (fileList.get(index).getAnswer_post_code() != 0)
				{
					// 답변 글의 첨부 파일인 경우
					prstmt.setInt(1, fileList.get(index).getQuestion_post_code());
					prstmt.setInt(2, code);
				} else
				{
					// 문의 글인 경우
					prstmt.setInt(1, code);
					prstmt.setNull(2, Types.INTEGER);
				}

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
