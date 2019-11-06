package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.sql.DataSource;

public class ReviewDAO
{
	DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public int getRecordSize(int icode, String ccode, String type)
	{
		String query = null;

		if (type.equals("SIMPLE"))
		{
			query = "SELECT count(*) FROM simplereview_table WHERE simpleReview_item_code = ? AND simpleReview_item_category_code = ?";
		} else
		{
			query = "SELECT count(*) FROM detailreview_table WHERE detailReview_item_code = ? AND detailReview_item_category_code = ?";
		}

		ResultSet set = null;
		int size = 0;
		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);

			set = prstmt.executeQuery();
			if (set.next())
			{
				size = set.getInt(1);
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
		return size;
	}

	public ArrayList<ReviewDTO> getSimpleReview(int icode, String ccode, int beginIndex, int endIndex)
	{
		String query = "SELECT * FROM simplereview_table WHERE simpleReview_item_code = ? AND simpleReview_item_category_code = ? ORDER BY simpleReview_post_date DESC LIMIT ?, ?";

		ResultSet set = null;
		ArrayList<ReviewDTO> reviews = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			prstmt.setInt(3, beginIndex);
			prstmt.setInt(4, endIndex);

			set = prstmt.executeQuery();
			reviews = new ArrayList<ReviewDTO>();

			while (set.next())
			{
				reviews.add(new ReviewDTO().setReview_code(set.getInt(1)).setItem_code(set.getInt(2))
						.setItem_category_code(set.getString(3)).setWriter_id(set.getString(4))
						.setContent(set.getString(5)).setRating(set.getString(6)).setPost_date(set.getString(7)));
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
		return reviews;
	}

	public ArrayList<ReviewDTO> getDetailReview(int icode, String ccode, int beginIndex, int endIndex)
	{
		String query = "SELECT * FROM detailreview_table WHERE detailReview_item_code = ? AND detailReview_item_category_code = ? ORDER BY detailReview_post_date DESC LIMIT ?, ?";

		ResultSet set = null;
		ArrayList<ReviewDTO> reviews = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			prstmt.setInt(3, beginIndex);
			prstmt.setInt(4, endIndex);

			set = prstmt.executeQuery();
			reviews = new ArrayList<ReviewDTO>();

			while (set.next())
			{
				reviews.add(new ReviewDTO().setReview_code(set.getInt(1)).setItem_code(set.getInt(2))
						.setItem_category_code(set.getString(3)).setWriter_id(set.getString(4))
						.setSubject(set.getString(5)).setContent(set.getString(6)).setRating(set.getString(7))
						.setNum_files(set.getInt(8)).setPost_date(set.getString(9)));
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
		return reviews;
	}

	public boolean applySimpleReview(HashMap<String, String> reviewData)
	{
		String query = "INSERT INTO simplereview_table " + "VALUES (null, ?, ?, ?, ?, ?, ?)";
		boolean flag = false;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, Integer.parseInt(reviewData.get("ICODE")));
			prstmt.setString(2, reviewData.get("CCODE"));
			prstmt.setString(3, reviewData.get("WRITER_ID"));
			prstmt.setString(4, reviewData.get("CONTENT"));
			prstmt.setString(5, reviewData.get("RATING"));
			prstmt.setString(6, reviewData.get("POST_DATE"));

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
	
	public boolean applyDetailReview(HashMap<String, String> reviewData)
	{
		return false;
	}
}