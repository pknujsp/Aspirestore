package etc;

public class OrderInformation
{
	private int item_code;
	private String item_category;
	private int order_quantity;
	private int item_price;
	private int total_price;

	public int getItem_code()
	{
		return item_code;
	}

	public String getItem_category()
	{
		return item_category;
	}

	public int getOrder_quantity()
	{
		return order_quantity;
	}

	public void setItem_code(int item_code)
	{
		this.item_code = item_code;
	}

	public void setItem_category(String item_category)
	{
		this.item_category = item_category;
	}

	public void setOrder_quantity(int order_quantity)
	{
		this.order_quantity = order_quantity;
	}

	public int getItem_price()
	{
		return item_price;
	}

	public void setItem_price(int item_price)
	{
		this.item_price = item_price;
	}

	public int getTotal_price()
	{
		return total_price;
	}

	public void setTotal_price(int total_price)
	{
		this.total_price = total_price;
	}

	public OrderInformation()
	{
	}

	public OrderInformation(int item_code, String item_category, int order_quantity, int item_price)
	{
		this.item_code = item_code;
		this.item_category = item_category;
		this.order_quantity = order_quantity;
		this.item_price = item_price;
		this.total_price = order_quantity * item_price;
	}
}