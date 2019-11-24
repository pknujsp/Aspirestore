package model;

public class SalehistoryDTO
{
	private int sale_code;
	private int order_code;
	private String user_id;
	private int item_code;
	private String item_name;
	private String item_category_code;
	private String item_category_desc;
	private int publisher_code;
	private String publisher_name;
	private String sale_date;
	private int sale_quantity;
	private int item_price;
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

	public String getItem_name()
	{
		return item_name;
	}

	public String getItem_category_code()
	{
		return item_category_code;
	}

	public String getItem_category_desc()
	{
		return item_category_desc;
	}

	public int getItem_price()
	{
		return item_price;
	}

	public SalehistoryDTO setItem_name(String item_name)
	{
		this.item_name = item_name;
		return this;
	}

	public SalehistoryDTO setItem_category_code(String item_category_code)
	{
		this.item_category_code = item_category_code;
		return this;
	}

	public SalehistoryDTO setItem_category_desc(String item_category_desc)
	{
		this.item_category_desc = item_category_desc;
		return this;
	}

	public SalehistoryDTO setItem_price(int item_price)
	{
		this.item_price = item_price;
		return this;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public int getItem_code()
	{
		return item_code;
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

	public int getPublisher_code()
	{
		return publisher_code;
	}

	public String getPublisher_name()
	{
		return publisher_name;
	}

	public SalehistoryDTO setPublisher_code(int publisher_code)
	{
		this.publisher_code = publisher_code;
		return this;
	}

	public SalehistoryDTO setPublisher_name(String publisher_name)
	{
		this.publisher_name = publisher_name;
		return this;
	}



	public SalehistoryDTO()
	{
	}
}