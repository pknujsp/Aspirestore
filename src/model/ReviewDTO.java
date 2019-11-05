package model;

public class ReviewDTO
{
	private int review_code;
	private String writer_id;
	private String subject;
	private String content;
	private String rating;
	private int num_files;
	private String post_date;
	private int item_code;
	private String item_category_code;

	public int getReview_code()
	{
		return review_code;
	}

	public String getWriter_id()
	{
		return writer_id;
	}

	public String getSubject()
	{
		return subject;
	}

	public String getContent()
	{
		return content;
	}

	public String getRating()
	{
		return rating;
	}

	public int getNum_files()
	{
		return num_files;
	}

	public String getPost_date()
	{
		return post_date;
	}

	public ReviewDTO setReview_code(int review_code)
	{
		this.review_code = review_code;
		return this;
	}

	public ReviewDTO setWriter_id(String writer_id)
	{
		this.writer_id = writer_id;
		return this;
	}

	public ReviewDTO setSubject(String subject)
	{
		this.subject = subject;
		return this;
	}

	public ReviewDTO setContent(String content)
	{
		this.content = content;
		return this;
	}

	public ReviewDTO setRating(String rating)
	{
		this.rating = rating;
		return this;
	}

	public ReviewDTO setNum_files(int num_files)
	{
		this.num_files = num_files;
		return this;
	}

	public ReviewDTO setPost_date(String post_date)
	{
		this.post_date = post_date;
		return this;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public String getItem_category_code()
	{
		return item_category_code;
	}

	public ReviewDTO setItem_code(int item_code)
	{
		this.item_code = item_code;
		return this;
	}

	public ReviewDTO setItem_category_code(String item_category_code)
	{
		this.item_category_code = item_category_code;
		return this;
	}

}
