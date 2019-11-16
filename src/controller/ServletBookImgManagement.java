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
import model.FileDAO;
import model.FileDTO;

public class ServletBookImgManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "UPDATE_INFO_IMG":
			updateBookImg(request, response, "INFO");
			break;
		case "UPDATE_MAIN_IMG":
			updateBookImg(request, response, "MAIN");
			break;
		}
	}

	protected void updateBookImg(HttpServletRequest request, HttpServletResponse response, String position)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			FileDAO fileDAO = (FileDAO) sc.getAttribute("FILE_DAO");

			MultipartRequest requestedData = (MultipartRequest) request.getAttribute("IMG_REQUEST");

			int icode = Integer.parseInt(requestedData.getParameter("icode"));
			String ccode = requestedData.getParameter("ccode");
			String currentTime = Util.getCurrentDateTime();
			String uploaderId = request.getSession().getAttribute("SESSIONKEY").toString();

			@SuppressWarnings("rawtypes")
			Enumeration files = requestedData.getFileNames();

			String file = files.nextElement().toString();
			String fileName = requestedData.getFilesystemName(file);

			FileDTO newImg = new FileDTO().setFile_name(fileName)
					.setFile_size((int) requestedData.getFile(file).length()).setItem_code(icode)
					.setItem_category_code(ccode).setFile_uri(MULTIPART_REQUEST.BOOKIMG_SAVE_FOLDER.getName())
					.setUploaded_date_time(currentTime).setUploader_id(uploaderId).setImage_position(position);

			boolean result = fileDAO.updateItemImage(newImg);

			response.setContentType("UTF-8");
			response.getWriter().write(String.valueOf(result));
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}