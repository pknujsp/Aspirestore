package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;

import etc.MULTIPART_REQUEST;
import etc.Util;
import model.FileDAO;
import model.FileDTO;
import model.ReviewDAO;
import model.ReviewDTO;

public class ServletItemReview extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_S_REVIEW_SIZE":
			getRecordSize(request, response);
			break;
		case "GET_D_REVIEW_SIZE":
			getRecordSize(request, response);
			break;
		case "GET_S_REVIEW_JSON":
			getSimpleReview(request, response);
			break;
		case "GET_D_REVIEW_JSON":
			getDetailReview(request, response);
			break;
		case "APPLY_S_REVIEW":
			applySimpleReview(request, response);
			break;
		case "APPLY_D_REVIEW":
			applyDetailReview(request, response);
			break;
		case "READ_D_REVIEW":
			readDetailReview(request, response);
			break;
		case "MODIFY":
			modifyMyReview(request, response);
			break;
		case "DELETE":
			deleteMyReview(request, response);
			break;
		}
	}

	protected void getRecordSize(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");

			String type = request.getAttribute("TYPE").toString();
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			int size = 0;

			if (type.equals("GET_S_REVIEW_SIZE"))
			{
				// simple
				size = reviewDAO.getRecordSize(icode, ccode, "SIMPLE");
			} else
			{
				// detail
				size = reviewDAO.getRecordSize(icode, ccode, "DETAIL");
			}

			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(String.valueOf(size));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getSimpleReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			int beginIndex = Integer.parseInt(request.getAttribute("BEGIN_INDEX").toString());
			int endIndex = Integer.parseInt(request.getAttribute("END_INDEX").toString());

			ArrayList<ReviewDTO> reviews = reviewDAO.getSimpleReview(icode, ccode, beginIndex, endIndex);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int i = 0; i < reviews.size(); ++i)
			{
				JSONObject review = new JSONObject();
				JSONObject parentObj = new JSONObject();

				review.put("REVIEW_CODE", reviews.get(i).getReview_code());
				review.put("ITEM_CODE", reviews.get(i).getItem_code());
				review.put("ITEM_CATEGORY_CODE", reviews.get(i).getItem_category_code());
				review.put("WRITER_ID", reviews.get(i).getWriter_id());
				review.put("CONTENT", reviews.get(i).getContent());
				review.put("RATING", reviews.get(i).getRating());
				review.put("POST_DATE", reviews.get(i).getPost_date());

				parentObj.put("REVIEW", review);
				rootArr.put(parentObj);

			}

			if (request.getSession().getAttribute("SESSIONKEY") != null)
			{
				// 로그인을 한 경우
				String userId = request.getSession().getAttribute("SESSIONKEY").toString();

				for (int i = 0; i < reviews.size(); ++i)
				{
					if (reviews.get(i).getWriter_id().equals(userId))
					{
						JSONObject myReview = new JSONObject();

						myReview.put("REVIEW_CODE", reviews.get(i).getReview_code());
						myReview.put("ITEM_CODE", reviews.get(i).getItem_code());
						myReview.put("ITEM_CATEGORY_CODE", reviews.get(i).getItem_category_code());
						myReview.put("WRITER_ID", reviews.get(i).getWriter_id());
						myReview.put("CONTENT", reviews.get(i).getContent());
						myReview.put("RATING", reviews.get(i).getRating());
						myReview.put("POST_DATE", reviews.get(i).getPost_date());

						rootObj.put("MY_S_REVIEW", myReview);
					}
				}
			}
			rootObj.put("REVIEWS", rootArr);

			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getDetailReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			int beginIndex = Integer.parseInt(request.getAttribute("BEGIN_INDEX").toString());
			int endIndex = Integer.parseInt(request.getAttribute("END_INDEX").toString());

			ArrayList<ReviewDTO> reviews = reviewDAO.getDetailReview(icode, ccode, beginIndex, endIndex);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int i = 0; i < reviews.size(); ++i)
			{
				JSONObject review = new JSONObject();
				JSONObject parentObj = new JSONObject();

				review.put("REVIEW_CODE", reviews.get(i).getReview_code());
				review.put("ITEM_CODE", reviews.get(i).getItem_code());
				review.put("ITEM_CATEGORY_CODE", reviews.get(i).getItem_category_code());
				review.put("WRITER_ID", reviews.get(i).getWriter_id());
				review.put("SUBJECT", reviews.get(i).getSubject());
				review.put("CONTENT", reviews.get(i).getContent());
				review.put("RATING", reviews.get(i).getRating());
				review.put("NUM_FILES", reviews.get(i).getNum_files());
				review.put("POST_DATE", reviews.get(i).getPost_date());

				parentObj.put("DETAIL_REVIEW", review);
				rootArr.put(parentObj);
			}

			if (request.getSession().getAttribute("SESSIONKEY") != null)
			{
				// 로그인을 한 경우
				String userId = request.getSession().getAttribute("SESSIONKEY").toString();

				for (int i = 0; i < reviews.size(); ++i)
				{
					if (reviews.get(i).getWriter_id().equals(userId))
					{
						JSONObject myReview = new JSONObject();

						myReview.put("REVIEW_CODE", reviews.get(i).getReview_code());
						myReview.put("ITEM_CODE", reviews.get(i).getItem_code());
						myReview.put("ITEM_CATEGORY_CODE", reviews.get(i).getItem_category_code());
						myReview.put("WRITER_ID", reviews.get(i).getWriter_id());
						myReview.put("SUBJECT", reviews.get(i).getSubject());
						myReview.put("CONTENT", reviews.get(i).getContent());
						myReview.put("RATING", reviews.get(i).getRating());
						myReview.put("POST_DATE", reviews.get(i).getPost_date());

						rootObj.put("MY_D_REVIEW", myReview);
					}
				}
			}

			rootObj.put("DETAIL_REVIEWS", rootArr);

			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void applySimpleReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");

			String writerId = request.getAttribute("WRITER_ID").toString();
			String rating = request.getAttribute("RATING").toString();
			String content = request.getAttribute("CONTENT").toString();
			String itemCode = request.getAttribute("ICODE").toString();
			String itemCategoryCode = request.getAttribute("CCODE").toString();

			HashMap<String, String> reviewData = new HashMap<String, String>();

			reviewData.put("WRITER_ID", writerId);
			reviewData.put("RATING", rating);
			reviewData.put("CONTENT", content);
			reviewData.put("ICODE", itemCode);
			reviewData.put("CCODE", itemCategoryCode);
			reviewData.put("POST_DATE", Util.getCurrentDateTime());

			reviewDAO.applySimpleReview(reviewData);

			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void applyDetailReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
			HashMap<String, String> reviewData = new HashMap<String, String>();

			MultipartRequest multipartRequest = (MultipartRequest) request.getAttribute("MULTI_REQUEST");

			String writerId = request.getAttribute("WRITER_ID").toString();
			String subject = request.getAttribute("SUBJECT").toString();
			String rating = request.getAttribute("RATING").toString();
			String content = request.getAttribute("CONTENT").toString();
			String iCode = request.getAttribute("ICODE").toString();
			String cCode = request.getAttribute("CCODE").toString();
			String currentTime = Util.getCurrentDateTime();

			@SuppressWarnings("rawtypes")
			Enumeration files = multipartRequest.getFileNames();
			ArrayList<FileDTO> fileList = new ArrayList<FileDTO>();

			while (files.hasMoreElements())
			{
				String file = (String) files.nextElement();
				String fileName = multipartRequest.getFilesystemName(file);

				if (fileName == null)
				{
					// 파일 미 첨부 인 경우
					break;
				} else
				{
					fileList.add(new FileDTO().setFile_name(fileName)
							.setFile_size((int) multipartRequest.getFile(file).length())
							.setFile_uri(MULTIPART_REQUEST.SAVE_FOLDER.getName()).setUploaded_date_time(currentTime)
							.setUploader_id(writerId));
				}
			}
			reviewData.put("WRITER_ID", writerId);
			reviewData.put("SUBJECT", subject);
			reviewData.put("RATING", rating);
			reviewData.put("CONTENT", content);
			reviewData.put("ICODE", iCode);
			reviewData.put("CCODE", cCode);
			reviewData.put("NUM_FILES", String.valueOf(fileList.size()));
			reviewData.put("POST_DATE", currentTime);

			int reviewCode = reviewDAO.applyDetailReview(reviewData);

			if (!fileList.isEmpty())
			{
				fileDAO.insertFileToDB(fileList, reviewCode);
			}

			request.setAttribute("ICODE", iCode);
			request.setAttribute("CCODE", cCode);
			request.setAttribute("VIEWURL", "forward:/items/item.aspire");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void readDetailReview(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
			int reviewCode = Integer.parseInt(request.getAttribute("RCODE").toString());

			ReviewDTO review = reviewDAO.getDetailReview(reviewCode);
			ArrayList<FileDTO> files = null;

			if (review.getNum_files() != 0)
			{
				files = fileDAO.getFiles(review.getReview_code(), review.getWriter_id(), "DETAIL_REVIEW");
			}

			request.setAttribute("ATTACHED_FILES", files);
			request.setAttribute("ICODE", review.getItem_code());
			request.setAttribute("CCODE", review.getItem_category_code());
			request.setAttribute("REVIEW", review);
			request.setAttribute("VIEWURL", "forward:/items/detailReview.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void deleteMyReview(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");

			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("ICODE").toString();
			String writerId = request.getAttribute("WRITER_ID").toString();
			String tableType = request.getAttribute("TABLE_TYPE").toString();
			int reviewCode = Integer.parseInt(request.getAttribute("REVIEW_CODE").toString());

			reviewDAO.deleteMyReview(icode, ccode, writerId, tableType);

			if (tableType.equals("DETAIL"))
			{
				FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
				ArrayList<FileDTO> files = fileDAO.getFiles(reviewCode, writerId, "DETAIL_REVIEW");

				if (files.size() > 0)
				{
					fileDAO.deleteReviewFilesDB(reviewCode, writerId);
					fileDAO.deleteRealFiles(files);
				}
			}

			request.setAttribute("ICODE", icode);
			request.setAttribute("CCODE", ccode);
			request.setAttribute("VIEWURL", "forward:/items/item.aspire");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void modifyMyReview(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			ReviewDAO reviewDAO = (ReviewDAO) sc.getAttribute("REVIEW_DAO");

			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("ICODE").toString();
			String writerId = request.getAttribute("WRITER_ID").toString();
			String tableType = request.getAttribute("TABLE_TYPE").toString();
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}