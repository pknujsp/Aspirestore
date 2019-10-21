package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.AuthorDAO;
import model.AuthorDTO;
import model.BasketDAO;
import model.BasketDTO;
import model.ItemsDAO;
import model.ItemsDTO;
import model.PublisherDAO;
import model.PublisherDTO;

public class ServletBasket extends HttpServlet
{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "ADD":
			addBookToTheBasket(request, response);
			break;

		case "DELETE":
			deleteBooksFromBasket(request, response);
			break;

		case "GET_BASKET":
			getBasket(request, response);
			break;
		}
	}

	protected void addBookToTheBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");
			BasketDTO data = (BasketDTO) request.getAttribute("BOOK_TO_ADD");

			JSONArray jsonArr = new JSONArray();
			JSONObject result = new JSONObject();

			if (!basketDAO.checkDuplication(data.getUser_id(), data.getItem_code())) // 중복X
			{
				basketDAO.addBookToTheBasket(data);
				result.put("MESSAGE", "장바구니에 추가되었습니다.");
				result.put("RESULT", "true");
			} else
			{
				result.put("MESSAGE", "이 도서는 이미 장바구니에 존재합니다.");
				result.put("RESULT", "false");
			}

			jsonArr.put(result);
			response.setContentType("application/json");
			response.getWriter().write(jsonArr.toString());
			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void deleteBooksFromBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");

			@SuppressWarnings("unchecked")
			ArrayList<BasketDTO> list = (ArrayList<BasketDTO>) request.getAttribute("BOOKS_TO_BE_DELETED");
			basketDAO.deleteBooksFromBasket(list);

			request.setAttribute("VIEWURL", "ajax:/");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void getBasket(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();

			BasketDAO basketDAO = (BasketDAO) sc.getAttribute("BASKET_DAO");
			ItemsDAO itemsDAO = (ItemsDAO) sc.getAttribute("itemsDAO");
			AuthorDAO authorDAO = (AuthorDAO) sc.getAttribute("authorDAO");
			PublisherDAO publisherDAO = (PublisherDAO) sc.getAttribute("PUBLISHER_DAO");

			ArrayList<BasketDTO> basket = basketDAO
					.getBasket(request.getSession().getAttribute("SESSIONKEY").toString()); // 장바구니

			Map<Integer, String> codeMap = new HashMap<Integer, String>(basket.size()); // itemCode, categoryCode

			for (int i = 0; i < basket.size(); ++i)
			{
				codeMap.put(basket.get(i).getItem_code(), basket.get(i).getCategory_code()); // Map에 키 : 도서코드, 값 : 카테고리
			}

			ArrayList<ItemsDTO> items = itemsDAO.getitemsForBasket(codeMap); // 아이템 정보
			ArrayList<Integer> authorCodes = new ArrayList<Integer>(basket.size()); // 저자 코드 리스트
			ArrayList<Integer> publisherCodes = new ArrayList<Integer>(basket.size()); // 출판사 코드 리스트

			for (int i = 0; i < basket.size(); ++i)
			{
				authorCodes.add(items.get(i).getItem_author_code());
				publisherCodes.add(items.get(i).getItem_publisher_code());
			}
			ArrayList<AuthorDTO> authors = authorDAO.getAuthors(authorCodes); // 저자 정보
			ArrayList<PublisherDTO> publishers = publisherDAO.getPublishers(publisherCodes); // 출판사 정보

			request.setAttribute("ITEMS", items);
			request.setAttribute("AUTHORS", authors);
			request.setAttribute("PUBLISHERS", publishers);
			request.setAttribute("BASKET", basket);
			request.setAttribute("VIEWURL", "forward:/basket.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}