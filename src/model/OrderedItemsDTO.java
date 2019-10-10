package model;

public class OrderedItemsDTO
{
	private String item_name;
	private String author_name;
	private String publisher_name;

	private int item_code;
	private String item_category;

	private int selling_price;

	public String getItem_name()
	{
		return item_name;
	}

	public String getAuthor_name()
	{
		return author_name;
	}

	public String getPublisher_name()
	{
		return publisher_name;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public String getItem_category()
	{
		return item_category;
	}

	public int getSelling_price()
	{
		return selling_price;
	}

	public void setItem_name(String item_name)
	{
		this.item_name = item_name;
	}

	public void setAuthor_name(String author_name)
	{
		this.author_name = author_name;
	}

	public void setPublisher_name(String publisher_name)
	{
		this.publisher_name = publisher_name;
	}

	public void setItem_code(int item_code)
	{
		this.item_code = item_code;
	}

	public void setItem_category(String item_category)
	{
		this.item_category = item_category;
	}

	public void setSelling_price(int selling_price)
	{
		this.selling_price = selling_price;
	}

	public OrderedItemsDTO(String item_name, String author_name, String publisher_name, int item_code,
			String item_category, int selling_price)
	{

		this.item_name = item_name;
		this.author_name = author_name;
		this.publisher_name = publisher_name;
		this.item_code = item_code;
		this.item_category = item_category;
		this.selling_price = selling_price;
	}
}