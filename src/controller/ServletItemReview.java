package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import etc.Util;
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
			
			for(int i=0;i<reviews.size();++i)
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

	}
}