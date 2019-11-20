package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import etc.MULTIPART_REQUEST;
import etc.Util;
import model.AuthorDAO;
import model.AuthorDTO;
import model.FileDAO;
import model.FileDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.PublisherDAO;
import model.PublisherDTO;

public class ServletBookRegistration extends HttpServlet
{
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) sc.getAttribute("PUBLISHER_DAO");

			ItemsDTO bookData = new ItemsDTO();
			ArrayList<AuthorDTO> authorList = new ArrayList<AuthorDTO>();
			PublisherDTO publisherData = new PublisherDTO();
			ArrayList<FileDTO> imgList = new ArrayList<FileDTO>();
			String currentTime = Util.getCurrentDateTime();
			String uploaderId = null;

			MultipartRequest bookRequest = (MultipartRequest) request.getAttribute("BOOK_REQUEST");

			bookData.setItem_name(bookRequest.getParameter("it_item_name"))
					.setItem_fixed_price(Integer.parseInt(bookRequest.getParameter("it_fixed_price")))
					.setItem_selling_price(Integer.parseInt(bookRequest.getParameter("it_selling_price")))
					.setItem_publication_date(bookRequest.getParameter("it_pub_date"))
					.setItem_page_number(bookRequest.getParameter("it_page_number"))
					.setItem_weight(bookRequest.getParameter("it_weight"))
					.setItem_size(bookRequest.getParameter("it_size"))
					.setItem_isbn13(bookRequest.getParameter("it_isbn13"))
					.setItem_isbn10(bookRequest.getParameter("it_isbn10"))
					.setItem_category_code(bookRequest.getParameter("it_item_category_code"))
					.setItem_book_introduction(bookRequest.getParameter("it_book_introduction"))
					.setItem_contents_table(bookRequest.getParameter("it_item_contents_table"))
					.setItem_publisher_review(bookRequest.getParameter("it_item_publisher_review"));
			
			

			String[] authorCodeList = bookRequest.getParameterValues("au_author_code[]");
			String[] authorNameList = bookRequest.getParameterValues("au_author_name[]");
			String[] authorRegionList = bookRequest.getParameterValues("au_author_region[]");
			String[] authorDescList = bookRequest.getParameterValues("au_author_desc[]");
			int authorNum = authorNameList.length;

			for (int index = 0; index < authorNum; ++index)
			{
				int authorCode = 0;

				if (authorCodeList[index].equals(""))
				{
					// 신규
					authorCode = -1;
				} else
				{
					authorCode = Integer.parseInt(authorCodeList[index]);
				}
				authorList.add(new AuthorDTO().setAuthor_code(authorCode).setAuthor_name(authorNameList[index])
						.setAuthor_region(authorRegionList[index]).setAuthor_information(authorDescList[index]));
			}

			publisherData.setPublisher_code(Integer.parseInt(bookRequest.getParameter("pu_publisher_code")))
					.setPublisher_name(bookRequest.getParameter("pu_publisher_name"))
					.setPublisher_region(bookRequest.getParameter("pu_publisher_region"));
			
			int itemCode = itemsDAO.insertNewBook(bookData, currentTime);
			String itemCategoryCode = 
			@SuppressWarnings("rawtypes")
			Enumeration imgs = bookRequest.getFileNames();
		
			
			String[] imgPosition =
			{ "MAIN", "INFO" };
			int index = 0;

			if (imgs.hasMoreElements())
			{
				String file = imgs.nextElement().toString();
				String fileName = bookRequest.getFilesystemName(file);

				imgList.add(new FileDTO().setFile_name(fileName).setFile_size((int) bookRequest.getFile(file).length())
						.setItem_code(itemCode).setItem_category_code(itemCategoryCode)
						.setFile_uri(MULTIPART_REQUEST.BOOKIMG_SAVE_FOLDER.getName()).setUploaded_date_time(currentTime)
						.setUploader_id(uploaderId).setImage_position(imgPosition[index++]));
			}
			boolean fileUploadResult = fileDAO.insertItemImagesToDB(imgList);
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}
