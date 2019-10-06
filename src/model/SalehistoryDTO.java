package model;

public class SalehistoryDTO
{
	private int sale_code;
	private int order_code;
	private String user_id;
	private int item_code;
	private String item_category;
	private String sale_date;
	private int sale_quantity;
	private int total_price;
	private String status;

	public int getSale_code()
	{
		return sale_code;
	}

	public int getOrder_code()
	{
		return order_code;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public String getItem_category()
	{
		return item_category;
	}

	public String getSale_date()
	{
		return sale_date;
	}

	public int getSale_quantity()
	{
		return sale_quantity;
	}

	public int getTotal_price()
	{
		return total_price;
	}

	public String getStatus()
	{
		return status;
	}

	public SalehistoryDTO setSale_code(int sale_code)
	{
		this.sale_code = sale_code;
		return this;
	}

	public SalehistoryDTO setOrder_code(int order_code)
	{
		this.order_code = order_code;
		return this;
	}

	public SalehistoryDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public SalehistoryDTO setItem_code(int item_code)
	{
		this.item_code = item_code;
		return this;
	}

	public SalehistoryDTO setItem_category(String item_category)
	{
		this.item_category = item_category;
		return this;
	}

	public SalehistoryDTO setSale_date(String sale_date)
	{
		this.sale_date = sale_date;
		return this;
	}

	public SalehistoryDTO setSale_quantity(int sale_quantity)
	{
		this.sale_quantity = sale_quantity;
		return this;
	}

	public SalehistoryDTO setTotal_price(int total_price)
	{
		this.total_price = total_price;
		return this;
	}

	public SalehistoryDTO setStatus(String status)
	{
		this.status = status;
		return this;
	}

	public SalehistoryDTO()
	{
	}
}