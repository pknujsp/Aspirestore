package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FileDAO;
import model.FileDTO;
import model.ItemsDAO;

import model.ItemsDTO;
import model.QnaDAO;
import model.QnaDTO;

public class ServletShowItems extends HttpServlet
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			ItemsDAO itemsDAO = (ItemsDAO) servletContext.getAttribute("itemsDAO");
			FileDAO fileDAO = (FileDAO) servletContext.getAttribute("FILE_DAO");

			final String ccode = request.getAttribute("CCODE").toString();
			final String cpcode = request.getAttribute("CPCODE").toString();
			final String sortType = request.getAttribute("SORT_TYPE").toString();
			final int currentPage = Integer.parseInt(request.getAttribute("CURRENT_PAGE").toString());

			// 전체 레코드의 개수를 가져온다.
			final int listSize = itemsDAO.getListSize(ccode);
			HashMap<String, Integer> pageData = new HashMap<String, Integer>();

			pageData.put("total_page", 0);
			pageData.put("total_block", 0);
			pageData.put("num_per_page", 10);
			pageData.put("page_per_block", 5);
			pageData.put("list_size", 0);
			pageData.put("total_record", 0);
			pageData.put("current_page", currentPage);
			pageData.put("current_block", 1);
			pageData.put("begin_index", 0);
			pageData.put("end_index", 10);

			// 문의글 목록을 불러오기 전 페이지 데이터를 처리한다.
			calculatePageData(pageData, listSize);

			ArrayList<ItemsDTO> bookList = itemsDAO.getItemList(ccode, sortType, pageData.get("begin_index").intValue(),
					pageData.get("end_index").intValue());
			ArrayList<FileDTO> thumbnails = fileDAO.getItemImages(ccode, sortType,
					pageData.get("begin_index").intValue(), pageData.get("end_index").intValue());

			// 조건하에 가져온 문의글 목록의 레코드 개수를 저장한다.
			pageData.put("list_size", bookList.size());

			request.setAttribute("PAGE_DATA", pageData);
			request.setAttribute("BOOKLIST", bookList);
			request.setAttribute("THUMBNAILS", thumbnails);
			request.setAttribute("CCODE", ccode);
			request.setAttribute("CPCODE", cpcode);
			request.setAttribute("SORT_TYPE", sortType);

			request.setAttribute("VIEWURL", "forward:/items/itemlist.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}

	}

	private void calculatePageData(HashMap<String, Integer> pageData, int total_records)
	{
		pageData.put("total_record", total_records);

		int numPerPage = pageData.get("num_per_page");
		int totalRecord = pageData.get("total_record");
		int currentPage = pageData.get("current_page");
		int pagePerBlock = pageData.get("page_per_block");

		pageData.put("begin_index", (currentPage * numPerPage) - numPerPage);
		pageData.put("end_index", numPerPage);
		pageData.put("total_page", (int) (Math.ceil((double) (totalRecord) / numPerPage)));
		pageData.put("current_block", (int) (Math.ceil((double) (currentPage) / pagePerBlock)));

		int totalPage = pageData.get("total_page");

		pageData.put("total_block", (int) (Math.ceil((double) (totalPage) / pagePerBlock)));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

	}

}
