package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.AuthorDAO;
import model.AuthorDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.PublisherDAO;
import model.PublisherDTO;

public class ServletBookManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_TOTAL_RECORDS":
			getTotalRecords(request, response);
			break;
		case "GET_RECORDS":
			getRecords(request, response);
			break;
		case "VIEW_MORE_DATA":
			viewMoreData(request, response);
			break;
		case "MODIFY_DATA":
			modifyData(request, response);
			break;
		case "UPDATE_DATA":
			updateData(request, response);
			break;
		}
	}

	protected void getTotalRecords(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			JSONArray jsonArr = (JSONArray) request.getAttribute("JSON_ARR");

			ArrayList<ArrayList<String>> categoryList = new ArrayList<ArrayList<String>>();

			for (int index = 0; index < jsonArr.length() - 1; ++index)
			{
				String parentCategoryCode = String.valueOf(index * 100 + 100);

				JSONObject dataObj = jsonArr.getJSONObject(index);
				JSONArray dataArr = dataObj.getJSONArray(parentCategoryCode);

				ArrayList<String> list = null;

				if (dataArr.length() > 0)
				{
					list = new ArrayList<String>();
					// 부모 카테고리 코드를 맨 앞에 삽입
					list.add(parentCategoryCode);
				}
				for (int j = 0; j < dataArr.length(); ++j)
				{
					// 두 번째 인덱스 부터 카테고리 코드 삽입
					list.add(dataArr.getString(j));
				}
				categoryList.add(list);
			}

			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			int totalRecords = itemsDAO.getTotalRecords(categoryList);

			response.setContentType("text/plain");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(String.valueOf(totalRecords));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getRecords(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			JSONArray jsonArr = (JSONArray) request.getAttribute("JSON_ARR");

			ArrayList<ArrayList<String>> categoryList = new ArrayList<ArrayList<String>>();

			for (int index = 0; index < jsonArr.length() - 1; ++index)
			{
				String parentCategoryCode = String.valueOf(index * 100 + 100);

				JSONObject dataObj = jsonArr.getJSONObject(index);
				JSONArray dataArr = dataObj.getJSONArray(parentCategoryCode);

				ArrayList<String> list = null;

				if (dataArr.length() > 0)
				{
					list = new ArrayList<String>();
					// 부모 카테고리 코드를 맨 앞에 삽입
					list.add(parentCategoryCode);
				}
				for (int j = 0; j < dataArr.length(); ++j)
				{
					// 두 번째 인덱스 부터 카테고리 코드 삽입
					list.add(dataArr.getString(j));
				}
				categoryList.add(list);
			}

			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			ArrayList<ItemsDTO> books = itemsDAO.getRecords(categoryList);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int i = 0; i < books.size(); ++i)
			{
				JSONObject book = new JSONObject();

				book.put("ITEM_CODE", books.get(i).getItem_code());
				book.put("ITEM_NAME", books.get(i).getItem_name());
				book.put("CATEGORY_CODE", books.get(i).getItem_category_code());
				book.put("CATEGORY_DESC", books.get(i).getItem_category_desc());
				book.put("AUTHOR_CODE", books.get(i).getItem_author_code());
				book.put("AUTHOR_NAME", books.get(i).getItem_author_name());
				book.put("PUBLISHER_CODE", books.get(i).getItem_publisher_code());
				book.put("PUBLISHER_NAME", books.get(i).getItem_publisher_name());
				book.put("SELLING_PRICE", books.get(i).getItem_selling_price());
				book.put("STOCK", books.get(i).getItem_remaining_quantity());
				book.put("PUB_DATE", books.get(i).getItem_registration_datetime());

				JSONObject bookObj = new JSONObject();
				bookObj.put("BOOK", book);
				rootArr.put(bookObj);
			}
			rootObj.put("BOOKS", rootArr);

			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void viewMoreData(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");

			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			Map<String, Object> bookData = itemsDAO.getBookData(icode, ccode);

			request.setAttribute("BOOK", bookData.get("BOOK"));
			request.setAttribute("AUTHOR", bookData.get("AUTHOR"));
			request.setAttribute("PUBLISHER", bookData.get("PUBLISHER"));
			request.setAttribute("VIEWURL", "forward:/management/bookmanagement/bookInfo.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void modifyData(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");

			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			Map<String, Object> bookData = itemsDAO.getBookData(icode, ccode);

			request.setAttribute("BOOK", bookData.get("BOOK"));
			request.setAttribute("AUTHOR", bookData.get("AUTHOR"));
			request.setAttribute("PUBLISHER", bookData.get("PUBLISHER"));
			request.setAttribute("VIEWURL", "forward:/management/bookmanagement/bookModification.jsp");
		} catch (Exception e)
		{
			new ServletException(e);
		}
	}

	protected void updateData(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) sc.getAttribute("PUBLISHER_DAO");

			JSONArray jsonData = (JSONArray) request.getAttribute("JSON_ARR");
			ArrayList<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();

			HashMap<String, String> processingDataMap = new HashMap<String, String>();
			processingDataMap.put("icode", jsonData.getJSONObject(0).getString("item_code"));
			processingDataMap.put("ccode", jsonData.getJSONObject(0).getString("item_category_code"));

			dataList.add(processingDataMap);

			for (int index = 1; index < jsonData.length(); ++index)
			{
				HashMap<String, String> dataMap = new HashMap<String, String>();
				dataMap.put("data_name", jsonData.getJSONObject(index).getString("data_name"));
				dataMap.put("data_value", jsonData.getJSONObject(index).getString("data_value"));

				dataList.add(dataMap);
			}
			// 도서 데이터 수정 처리
			ItemsDTO bookData = null;
			// 저자 데이터 수정 처리
			AuthorDTO authorData = null;
			// 출판사 데이터 수정 처리
			PublisherDTO publisherData = null;
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}