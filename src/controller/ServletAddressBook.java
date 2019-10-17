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

import model.AddressDAO;
import model.AddressDTO;

public class ServletAddressBook extends HttpServlet
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			AddressDAO addressDAO = (AddressDAO) sc.getAttribute("ADDRESS_DAO");

			switch ((String) request.getAttribute("TYPE"))
			{
			case "0": // 최근 주소
				AddressDTO address = addressDAO.getLatestAddress((String) request.getAttribute("ID"));

				if (address != null)
				{
					JSONArray jsonArr = new JSONArray();
					JSONObject object1 = new JSONObject();

					object1.put("POSTAL_CODE", address.getPostal_code());
					object1.put("ROAD_NAME", address.getRoad());
					object1.put("NUMBER", address.getNumber());
					object1.put("DETAIL", address.getDetail());
					object1.put("ADDRESS_CODE", address.getCode());
					jsonArr.put(object1);

					response.setContentType("application/json");
					response.getWriter().write(jsonArr.toString());
				}
				request.setAttribute("VIEWURL", "ajax:/");
				break;

			case "1": // 주소 삭제
				addressDAO.deleteAddress(request.getAttribute("ID").toString(),
						Integer.parseInt(request.getAttribute("CODE").toString()));
				request.setAttribute("VIEWURL", "ajax:/");
				break;
			}
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}