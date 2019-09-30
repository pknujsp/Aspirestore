package model;

public class OrderPaymentDTO
{
	private int salehistory_sale_code;
	private int salehistory_item_code;
	private String salehistory_item_category;
	private String salehistory_user_id;
	private String salehistory_sale_date;
	private int salehistory_sale_quantity;
	private int salehistory_total_price;
	private String salehistory_address;
	private String salehistory_payment_method;
	private String salehistory_requested_term;
	private String salehistory_status;

	public int getSalehistory_sale_code()
	{
		return salehistory_sale_code;
	}

	public int getSalehistory_item_code()
	{
		return salehistory_item_code;
	}

	public String getSalehistory_item_category()
	{
		return salehistory_item_category;
	}

	public String getSalehistory_user_id()
	{
		return salehistory_user_id;
	}

	public String getSalehistory_sale_date()
	{
		return salehistory_sale_date;
	}

	public int getSalehistory_sale_quantity()
	{
		return salehistory_sale_quantity;
	}

	public int getSalehistory_total_price()
	{
		return salehistory_total_price;
	}

	public String getSalehistory_address()
	{
		return salehistory_address;
	}

	public String getSalehistory_payment_method()
	{
		return salehistory_payment_method;
	}

	public String getSalehistory_requested_term()
	{
		return salehistory_requested_term;
	}

	public String getSalehistory_status()
	{
		return salehistory_status;
	}

	public void setSalehistory_sale_code(int salehistory_sale_code)
	{
		this.salehistory_sale_code = salehistory_sale_code;
	}

	public void setSalehistory_item_code(int salehistory_item_code)
	{
		this.salehistory_item_code = salehistory_item_code;
	}

	public void setSalehistory_item_category(String salehistory_item_category)
	{
		this.salehistory_item_category = salehistory_item_category;
	}

	public void setSalehistory_user_id(String salehistory_user_id)
	{
		this.salehistory_user_id = salehistory_user_id;
	}

	public void setSalehistory_sale_date(String salehistory_sale_date)
	{
		this.salehistory_sale_date = salehistory_sale_date;
	}

	public void setSalehistory_sale_quantity(int salehistory_sale_quantity)
	{
		this.salehistory_sale_quantity = salehistory_sale_quantity;
	}

	public void setSalehistory_total_price(int salehistory_total_price)
	{
		this.salehistory_total_price = salehistory_total_price;
	}

	public void setSalehistory_address(String salehistory_address)
	{
		this.salehistory_address = salehistory_address;
	}

	public void setSalehistory_payment_method(String salehistory_payment_method)
	{
		this.salehistory_payment_method = salehistory_payment_method;
	}

	public void setSalehistory_requested_term(String salehistory_requested_term)
	{
		this.salehistory_requested_term = salehistory_requested_term;
	}

	public void setSalehistory_status(String salehistory_status)
	{
		this.salehistory_status = salehistory_status;
	}

	public OrderPaymentDTO()
	{
	}

	public OrderPaymentDTO(int salehistory_sale_code, int salehistory_item_code, String salehistory_item_category,
			String salehistory_user_id, String salehistory_sale_date, int salehistory_sale_quantity,
			int salehistory_total_price, String salehistory_address, String salehistory_payment_method,
			String salehistory_requested_term, String salehistory_status)
	{
		this.salehistory_sale_code = salehistory_sale_code;
		this.salehistory_item_code = salehistory_item_code;
		this.salehistory_item_category = salehistory_item_category;
		this.salehistory_user_id = salehistory_user_id;
		this.salehistory_sale_date = salehistory_sale_date;
		this.salehistory_sale_quantity = salehistory_sale_quantity;
		this.salehistory_total_price = salehistory_total_price;
		this.salehistory_address = salehistory_address;
		this.salehistory_payment_method = salehistory_payment_method;
		this.salehistory_requested_term = salehistory_requested_term;
		this.salehistory_status = salehistory_status;
	}
}