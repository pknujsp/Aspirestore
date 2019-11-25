package model;

import java.util.ArrayList;

public class BasketDTO
{
	private String user_id;
	private int total_price;
	private int total_quantity;
	private ArrayList<ItemsDTO> books = new ArrayList<ItemsDTO>();

	public String getUser_id()
	{
		return user_id;
	}

	public ArrayList<ItemsDTO> getBooks()
	{
		return books;
	}

	public BasketDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public int getTotal_price()
	{
		return total_price;
	}

	public BasketDTO setTotal_price()
	{
		for (int index = 0; index < books.size(); ++index)
		{
			this.total_price += (books.get(index).getItem_selling_price() * books.get(index).getOrder_quantity());
		}
		return this;
	}

	public int getTotal_quantity()
	{
		return this.total_quantity;
	}

	public BasketDTO setTotal_quantity()
	{
		for (int index = 0; index < books.size(); ++index)
		{
			this.total_quantity += books.get(index).getOrder_quantity();
		}
		return this;
	}

	public BasketDTO setBooks(ItemsDTO book)
	{
		books.add(book);
		return this;
	}
}