package model;

import java.util.Set;

public class ItemsDTO
{
	private int item_code;
	private String item_name;
	private int item_author_code;
	private String item_author_name;
	private int item_publisher_code;
	private String item_publisher_name;
	private String item_publication_date;
	private int item_fixed_price;
	private int item_selling_price;
	private int item_remaining_quantity;
	private String item_category_code;
	private String item_category_desc;
	private String item_page_number;
	private String item_weight;
	private String item_size;
	private String item_isbn13;
	private String item_isbn10;
	private String item_book_introduction;
	private String item_contents_table;
	private String item_publisher_review;
	private String item_registration_datetime;
	private String item_rating;

	public String getItem_rating()
	{
		return item_rating;
	}

	public String getItem_author_name()
	{
		return item_author_name;
	}

	public String getItem_category_desc()
	{
		return item_category_desc;
	}

	public String getItem_publisher_name()
	{
		return item_publisher_name;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public ItemsDTO setItem_code(int item_code)
	{
		this.item_code = item_code;
		return this;
	}

	public String getItem_name()
	{
		return item_name;
	}

	public ItemsDTO setItem_name(String item_name)
	{
		this.item_name = item_name;
		return this;
	}

	public int getItem_author_code()
	{
		return item_author_code;
	}

	public ItemsDTO setItem_author_code(int item_author_code)
	{
		this.item_author_code = item_author_code;
		return this;
	}

	public int getItem_publisher_code()
	{
		return item_publisher_code;
	}

	public ItemsDTO setItem_publisher_code(int item_publisher_code)
	{
		this.item_publisher_code = item_publisher_code;
		return this;
	}

	public String getItem_publication_date()
	{
		return item_publication_date;
	}

	public ItemsDTO setItem_publication_date(String item_publication_date)
	{
		this.item_publication_date = item_publication_date;
		return this;
	}

	public int getItem_fixed_price()
	{
		return item_fixed_price;
	}

	public ItemsDTO setItem_fixed_price(int item_fixed_price)
	{
		this.item_fixed_price = item_fixed_price;
		return this;
	}

	public int getItem_selling_price()
	{
		return item_selling_price;
	}

	public ItemsDTO setItem_selling_price(int item_selling_price)
	{
		this.item_selling_price = item_selling_price;
		return this;
	}

	public int getItem_remaining_quantity()
	{
		return item_remaining_quantity;
	}

	public ItemsDTO setItem_remaining_quantity(int item_remaining_quantity)
	{
		this.item_remaining_quantity = item_remaining_quantity;
		return this;
	}

	public String getItem_category_code()
	{
		return item_category_code;
	}

	public ItemsDTO setItem_category_code(String item_category_code)
	{
		this.item_category_code = item_category_code;
		return this;
	}

	public String getItem_page_number()
	{
		return item_page_number;
	}

	public ItemsDTO setItem_page_number(String item_page_number)
	{
		this.item_page_number = item_page_number;
		return this;
	}

	public String getItem_weight()
	{
		return item_weight;
	}

	public ItemsDTO setItem_weight(String item_weight)
	{
		this.item_weight = item_weight;
		return this;
	}

	public String getItem_size()
	{
		return item_size;
	}

	public ItemsDTO setItem_size(String item_size)
	{
		this.item_size = item_size;
		return this;
	}

	public String getItem_isbn13()
	{
		return item_isbn13;
	}

	public ItemsDTO setItem_isbn13(String item_isbn13)
	{
		this.item_isbn13 = item_isbn13;
		return this;
	}

	public String getItem_isbn10()
	{
		return item_isbn10;
	}

	public ItemsDTO setItem_isbn10(String item_isbn10)
	{
		this.item_isbn10 = item_isbn10;
		return this;
	}

	public String getItem_book_introduction()
	{
		return item_book_introduction;
	}

	public ItemsDTO setItem_book_introduction(String item_book_introduction)
	{
		this.item_book_introduction = item_book_introduction;
		return this;
	}

	public String getItem_contents_table()
	{
		return item_contents_table;
	}

	public ItemsDTO setItem_contents_table(String item_contents_table)
	{
		this.item_contents_table = item_contents_table;
		return this;
	}

	public String getItem_publisher_review()
	{
		return item_publisher_review;
	}

	public ItemsDTO setItem_publisher_review(String item_publisher_review)
	{
		this.item_publisher_review = item_publisher_review;
		return this;
	}

	public String getItem_registration_datetime()
	{
		return item_registration_datetime;
	}

	public ItemsDTO setItem_registration_datetime(String item_registration_datetime)
	{
		this.item_registration_datetime = item_registration_datetime;
		return this;
	}

	public ItemsDTO setItem_author_name(String item_author_name)
	{
		this.item_author_name = item_author_name;
		return this;
	}

	public ItemsDTO setItem_category_desc(String item_category_desc)
	{
		this.item_category_desc = item_category_desc;
		return this;
	}

	public ItemsDTO setItem_publisher_name(String item_publisher_name)
	{
		this.item_publisher_name = item_publisher_name;
		return this;
	}

	public ItemsDTO setItem_rating(String item_rating)
	{
		this.item_rating = item_rating;
		return this;
	}

	public ItemsDTO()
	{
	}

	public ItemsDTO(int item_code, String item_name, int item_author_code, int item_publisher_code,
			String item_publication_date, int item_fixed_price, int item_selling_price, int item_remaining_quantity,
			String item_category_code, String item_page_number, String item_weight, String item_size,
			String item_isbn13, String item_isbn10, String item_book_introduction, String item_contents_table,
			String item_publisher_review, String item_registration_datetime)
	{
		this.item_code = item_code;
		this.item_name = item_name;
		this.item_author_code = item_author_code;
		this.item_publisher_code = item_publisher_code;
		this.item_publication_date = item_publication_date;
		this.item_fixed_price = item_fixed_price;
		this.item_selling_price = item_selling_price;
		this.item_remaining_quantity = item_remaining_quantity;
		this.item_category_code = item_category_code;
		this.item_page_number = item_page_number;
		this.item_weight = item_weight;
		this.item_size = item_size;
		this.item_isbn13 = item_isbn13;
		this.item_isbn10 = item_isbn10;
		this.item_book_introduction = item_book_introduction;
		this.item_contents_table = item_contents_table;
		this.item_publisher_review = item_publisher_review;
		this.item_registration_datetime = item_registration_datetime;
	}
}