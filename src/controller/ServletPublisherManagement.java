package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.PublisherDAO;
import model.PublisherDTO;

public class ServletPublisherManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "GET_PUBLISHERS":
			getPublishers(request, response);
			break;
		}
	}

	protected void getPublishers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			PublisherDAO publisherDAO = (PublisherDAO) sc.getAttribute("PUBLISHER_DAO");

			String publisherName = request.getAttribute("PUBLISHER_NAME").toString();
			// 해당 이름인 저자 목록을 불러온다
			ArrayList<PublisherDTO> publishers = publisherDAO.getPublishers(publisherName);

			JSONObject rootObj = new JSONObject();
			JSONArray rootArr = new JSONArray();

			for (int index = 0; index < publishers.size(); ++index)
			{
				JSONObject publisherObj = new JSONObject();
				JSONObject publisherData = new JSONObject();

				publisherData.put("PUBLISHER_NAME", publishers.get(index).getPublisher_name());
				publisherData.put("PUBLISHER_CODE", publishers.get(index).getPublisher_code());
				publisherData.put("PUBLISHER_REGION", publishers.get(index).getPublisher_region());

				publisherObj.put("PUBLISHER", publisherData);
				rootArr.put(publisherObj);
			}
			rootObj.put("PUBLISHERS", rootArr);

			response.setContentType("application/json");
			response.getWriter().write(rootObj.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

}
