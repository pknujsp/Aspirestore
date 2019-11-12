package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.AuthorDAO;
import model.AuthorDTO;

public class ServletAuthorManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_AUTHORS":
			getAuthors(request, response);
			break;
		}
	}

	protected void getAuthors(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");

			String authorName = request.getAttribute("AUTHOR_NAME").toString();
			// 해당 이름인 저자 목록을 불러온다
			ArrayList<AuthorDTO> authors = authorDAO.getAuthors(authorName);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int index = 0; index < authors.size(); ++index)
			{
				JSONObject authorObj = new JSONObject();
				JSONObject authorData = new JSONObject();

				authorData.put("AUTHOR_NAME", authors.get(index).getAuthor_name());
				authorData.put("AUTHOR_CODE", authors.get(index).getAuthor_code());
				authorData.put("AUTHOR_REGION", authors.get(index).getAuthor_region());
				authorData.put("AUTHOR_DESC", authors.get(index).getAuthor_information());

				authorObj.put("AUTHOR", authorData);
				rootArr.put(authorObj);
			}
			rootObj.put("AUTHORS", rootArr);

			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	
}
