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

	public ReviewDTO getDetailReview(int reviewCode)
	{
		String query = "SELECT * FROM detailreview_table WHERE detailReview_code = ?";

		ResultSet set = null;
		ReviewDTO review = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, reviewCode);

			set = prstmt.executeQuery();

			if (set.next())
			{
				review = new ReviewDTO().setReview_code(set.getInt(1)).setItem_code(set.getInt(2))
						.setItem_category_code(set.getString(3)).setWriter_id(set.getString(4))
						.setSubject(set.getString(5)).setContent(set.getString(6)).setRating(set.getString(7))
						.setNum_files(set.getInt(8)).setPost_date(set.getString(9));
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
		return review;
	}

	public boolean applySimpleReview(HashMap<String, String> reviewData)
	{
		String query = "INSERT INTO simplereview_table " + "SELECT null, ?, ?, ?, ?, ?, ? FROM DUAL WHERE NOT EXISTS "
				+ "(SELECT * FROM simplereview_table WHERE simpleReview_item_code = ? AND simpleReview_item_category_code = ? AND simpleReview_user_id = ?)";
		String updateReviewCountQuery = "UPDATE itemreviewinfo_table SET rinfo_sreview_num = rinfo_sreview_num + 1, rinfo_total_rating = rinfo_total_rating + ? "
				+ "WHERE rinfo_item_code = ? AND rinfo_item_category_code = ?";

		boolean flag = false;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				PreparedStatement prstmt2 = connection.prepareStatement(updateReviewCountQuery);)
		{
			prstmt.setInt(1, Integer.parseInt(reviewData.get("ICODE")));
			prstmt.setString(2, reviewData.get("CCODE"));
			prstmt.setString(3, reviewData.get("WRITER_ID"));
			prstmt.setString(4, reviewData.get("CONTENT"));
			prstmt.setInt(5, Integer.parseInt(reviewData.get("RATING")));
			prstmt.setString(6, reviewData.get("POST_DATE"));

			prstmt.setInt(7, Integer.parseInt(reviewData.get("ICODE")));
			prstmt.setString(8, reviewData.get("CCODE"));
			prstmt.setString(9, reviewData.get("WRITER_ID"));

			prstmt2.setInt(1, Integer.parseInt(reviewData.get("RATING")));
			prstmt2.setInt(2, Integer.parseInt(reviewData.get("ICODE")));
			prstmt2.setString(3, reviewData.get("CCODE"));

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

	public int applyDetailReview(HashMap<String, String> reviewData)
	{
		String query = "INSERT INTO detailreview_table "
				+ "SELECT null, ?, ?, ?, ?, ?, ?, ?, ? FROM DUAL WHERE NOT EXISTS "
				+ "(SELECT * FROM detailreview_table WHERE detailReview_item_code = ? AND detailReview_item_category_code = ? AND detailReview_user_id = ?)";
		String updateReviewCountQuery = "UPDATE itemreviewinfo_table SET rinfo_dreview_num = rinfo_dreview_num + 1, rinfo_total_rating = rinfo_total_rating + ? "
				+ "WHERE rinfo_item_code = ? AND rinfo_item_category_code = ?";
		String selectQuery = "SELECT detailReview_code FROM detailreview_table WHERE detailReview_item_code = ? AND detailReview_item_category_code = ? AND detailReview_user_id = ?";
		ResultSet set = null;
		int reviewCode = -1;

		try (Connection connection = ds.getConnection();
				PreparedStatement prstmt = connection.prepareStatement(query);
				PreparedStatement prstmt2 = connection.prepareStatement(selectQuery);
				PreparedStatement prstmt3 = connection.prepareStatement(updateReviewCountQuery);)
		{
			prstmt.setInt(1, Integer.parseInt(reviewData.get("ICODE")));
			prstmt.setString(2, reviewData.get("CCODE"));
			prstmt.setString(3, reviewData.get("WRITER_ID"));
			prstmt.setString(4, reviewData.get("SUBJECT"));
			prstmt.setString(5, reviewData.get("CONTENT"));
			prstmt.setInt(6, Integer.parseInt(reviewData.get("RATING")));
			prstmt.setInt(7, Integer.parseInt(reviewData.get("NUM_FILES")));
			prstmt.setString(8, reviewData.get("POST_DATE"));

			prstmt.setInt(9, Integer.parseInt(reviewData.get("ICODE")));
			prstmt.setString(10, reviewData.get("CCODE"));
			prstmt.setString(11, reviewData.get("WRITER_ID"));

			prstmt3.setInt(1, Integer.parseInt(reviewData.get("RATING")));
			prstmt3.setInt(2, Integer.parseInt(reviewData.get("ICODE")));
			prstmt3.setString(3, reviewData.get("CCODE"));

			if (prstmt.executeUpdate() == 1 && prstmt3.executeUpdate() == 1)
			{
				prstmt2.setInt(1, Integer.parseInt(reviewData.get("ICODE")));
				prstmt2.setString(2, reviewData.get("CCODE"));
				prstmt2.setString(3, reviewData.get("WRITER_ID"));

				set = prstmt2.executeQuery();
				if (set.next())
				{
					reviewCode = set.getInt(1);
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
		return reviewCode;
	}

	public boolean deleteMyReview(int icode, String ccode, String writerId, String tableType)
	{
		String query = null;
		boolean flag = false;

		if (tableType.equals("SIMPLE"))
		{
			query = "DELETE FROM simplereview_table WHERE simpleReview_item_code = ? AND simpleReview_item_category_code = ? AND simpleReview_user_id = ?";
		} else
		{
			// DETAIL
			query = "DELETE FROM detailreview_table WHERE detailReview_item_code = ? AND detailReview_item_category_code = ? AND detailReview_user_id = ?";
		}

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			prstmt.setString(3, writerId);

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

	public boolean initializeBookReviewInfo(int icode, String ccode)
	{
		String query = "INSERT INTO itemreviewinfo_table VALUES (null, ?, ?, ?, ?, ?)";

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, icode);
			prstmt.setString(2, ccode);
			prstmt.setInt(3, 0);
			prstmt.setInt(4, 0);
			prstmt.setInt(5, 0);

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

	public boolean modifyMyReview(int icode, String ccode, String writerId, ReviewDTO modifiedReview, String tableType)
	{
		return false;
	}

}