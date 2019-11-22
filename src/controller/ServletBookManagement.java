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
import model.FileDAO;
import model.FileDTO;
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

			for (int index = 1; index < jsonArr.length(); ++index)
			{
				String parentCategoryCode = String.valueOf(index * 100);

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

			for (int index = 1; index < jsonArr.length(); ++index)
			{
				String parentCategoryCode = String.valueOf(index * 100);

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
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
			
			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();
			Map<String, Object> bookData = itemsDAO.getBookData(icode, ccode);
			ArrayList<FileDTO> images = fileDAO.getItemImages(icode, ccode);

			for (int index = 0; index < images.size(); ++index)
			{
				if (images.get(index).getImage_position().equals("MAIN"))
				{
					bookData.put("MAIN_IMAGE", images.get(index));
				} else if (images.get(index).getImage_position().equals("INFO"))
				{
					bookData.put("INFO_IMAGE", images.get(index));
				}
			}

			request.setAttribute("MAIN_IMAGE", bookData.get("MAIN_IMAGE"));
			request.setAttribute("INFO_IMAGE", bookData.get("INFO_IMAGE"));

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
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");

			int icode = Integer.parseInt(request.getAttribute("ICODE").toString());
			String ccode = request.getAttribute("CCODE").toString();

			Map<String, Object> bookData = itemsDAO.getBookData(icode, ccode);
			ArrayList<FileDTO> images = fileDAO.getItemImages(icode, ccode);

			for (int index = 0; index < images.size(); ++index)
			{
				if (images.get(index).getImage_position().equals("MAIN"))
				{
					bookData.put("MAIN_IMAGE", images.get(index));
				} else if (images.get(index).getImage_position().equals("INFO"))
				{
					bookData.put("INFO_IMAGE", images.get(index));
				}
			}

			request.setAttribute("BOOK", bookData.get("BOOK"));
			request.setAttribute("AUTHOR", bookData.get("AUTHOR"));
			request.setAttribute("PUBLISHER", bookData.get("PUBLISHER"));
			request.setAttribute("MAIN_IMAGE", bookData.get("MAIN_IMAGE"));
			request.setAttribute("INFO_IMAGE", bookData.get("INFO_IMAGE"));

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
				dataMap.put("data_type", classifyType(jsonData.getJSONObject(index).getString("data_name")));
				dataMap.put("data_name", separateName(jsonData.getJSONObject(index).getString("data_name")));
				dataMap.put("data_value", jsonData.getJSONObject(index).getString("data_value"));
				dataMap.put("status", jsonData.getJSONObject(index).getString("status"));

				dataList.add(dataMap);
			}

			ItemsDTO bookData = null;
			AuthorDTO authorData = null;
			PublisherDTO publisherData = null;

			String authorStatus = null;
			String publisherStatus = null;

			for (int index = 1; index < jsonData.length(); ++index)
			{
				switch (dataList.get(index).get("data_type"))
				{
				case "item":
					if (bookData == null)
					{
						bookData = new ItemsDTO();
					}
					checkBookModification(bookData, dataList.get(index));
					break;
				case "author":
					if (authorData == null)
					{
						authorData = new AuthorDTO();
					}
					checkAuthorModification(authorData, dataList.get(index));
					if (authorStatus == null)
					{
						authorStatus = dataList.get(index).get("status");
					}
					break;
				case "publisher":
					if (publisherData == null)
					{
						publisherData = new PublisherDTO();
					}
					checkPublisherModification(publisherData, dataList.get(index));
					if (publisherStatus == null)
					{
						publisherStatus = dataList.get(index).get("status");
					}
					break;
				}
			}

			boolean result = false;

			if (bookData != null)
			{
				if (itemsDAO.updateBookData(bookData, processingDataMap))
				{
					result = true;
				} else
				{
					result = false;
				}
			}

			if (authorData != null)
			{
				if (authorDAO.updateAuthorData(authorData, processingDataMap, authorStatus))
				{
					result = true;
				} else
				{
					result = false;
				}
			}

			if (publisherData != null)
			{
				if (publisherDAO.updatePublisherData(publisherData, processingDataMap, publisherStatus))
				{
					result = true;
				} else
				{
					result = false;
				}
			}

			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/plain");
			response.getWriter().write(String.valueOf(result));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	private String classifyType(String dataName)
	{
		String separatedStr = dataName.substring(0, 2);
		String dataType = null;

		switch (separatedStr)
		{
		case "it":
			dataType = "item";
			break;
		case "au":
			dataType = "author";
			break;
		case "pu":
			dataType = "publisher";
			break;
		}
		return dataType;
	}

	private String separateName(String dataName)
	{
		return dataName.substring(3);
	}

	private void checkBookModification(ItemsDTO book, HashMap<String, String> data)
	{
		String dataName = data.get("data_name");
		String dataValue = data.get("data_value");

		if (dataName.equals("item_name"))
		{
			book.setItem_name(dataValue);
		} else if (dataName.equals("pub_date"))
		{
			book.setItem_publication_date(dataValue);
		} else if (dataName.equals("fixed_price"))
		{
			book.setItem_fixed_price(Integer.parseInt(dataValue));
		} else if (dataName.equals("selling_price"))
		{
			book.setItem_selling_price(Integer.parseInt(dataValue));
		} else if (dataName.equals("page_number"))
		{
			book.setItem_page_number(dataValue);
		} else if (dataName.equals("weight"))
		{
			book.setItem_weight(dataValue);
		} else if (dataName.equals("size"))
		{
			book.setItem_size(dataValue);
		} else if (dataName.equals("isbn13"))
		{
			book.setItem_isbn13(dataValue);
		} else if (dataName.equals("isbn10"))
		{
			book.setItem_isbn10(dataValue);
		} else if (dataName.equals("book_introduction"))
		{
			book.setItem_book_introduction(dataValue);
		} else if (dataName.equals("item_contents_table"))
		{
			book.setItem_contents_table(dataValue);
		} else if (dataName.equals("item_publisher_review"))
		{
			book.setItem_publisher_review(dataValue);
		}
	}

	private void checkAuthorModification(AuthorDTO author, HashMap<String, String> data)
	{
		String dataName = data.get("data_name");
		String dataValue = data.get("data_value");

		if (dataName.equals("author_code"))
		{
			author.setAuthor_code(Integer.parseInt(dataValue));
		} else if (dataName.equals("author_name"))
		{
			author.setAuthor_name(dataValue);
		} else if (dataName.equals("author_region"))
		{
			author.setAuthor_region(dataValue);
		} else if (dataName.equals("author_desc"))
		{
			author.setAuthor_information(dataValue);
		}
	}

	private void checkPublisherModification(PublisherDTO publisher, HashMap<String, String> data)
	{
		String dataName = data.get("data_name");
		String dataValue = data.get("data_value");

		if (dataName.equals("publisher_code"))
		{
			publisher.setPublisher_code(Integer.parseInt(dataValue));
		} else if (dataName.equals("publisher_name"))
		{
			publisher.setPublisher_name(dataValue);
		} else if (dataName.equals("publisher_region"))
		{
			publisher.setPublisher_region(dataValue);
		}
	}
}