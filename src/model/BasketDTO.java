package model;

public class BasketDTO
{
	private String user_id;
	private int item_code;
	private String category_code;
	private int quantity;

	public String getUser_id()
	{
		return user_id;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public String getCategory_code()
	{
		return category_code;
	}

	public int getQuantity()
	{
		return quantity;
	}

	public BasketDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public BasketDTO setItem_code(int item_code)
	{
		this.item_code = item_code;
		return this;
	}

	public BasketDTO setCategory_code(String category_code)
	{
		this.category_code = category_code;
		return this;
	}

	public BasketDTO setQuantity(int quantity)
	{
		this.quantity = quantity;
		return this;
	}
}