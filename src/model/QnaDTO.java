package model;

public class QnaDTO
{
	private int question_code;
	private String user_id;
	private String subject;
	private int category_code;
	private String content;
	private String post_date;
	private String ip;
	private int images_code;
	private String status;

	public int getQuestion_code()
	{
		return question_code;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public String getSubject()
	{
		return subject;
	}

	public int getCategory_code()
	{
		return category_code;
	}

	public String getContent()
	{
		return content;
	}

	public String getPost_date()
	{
		return post_date;
	}

	public String getIp()
	{
		return ip;
	}

	public int getImages_code()
	{
		return images_code;
	}

	public String getStatus()
	{
		return status;
	}

	public QnaDTO setQuestion_code(int question_code)
	{
		this.question_code = question_code;
		return this;
	}

	public QnaDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public QnaDTO setSubject(String subject)
	{
		this.subject = subject;
		return this;
	}

	public QnaDTO setCategory_code(int category_code)
	{
		this.category_code = category_code;
		return this;
	}

	public QnaDTO setContent(String content)
	{
		this.content = content;
		return this;
	}

	public QnaDTO setPost_date(String post_date)
	{
		this.post_date = post_date;
		return this;
	}

	public QnaDTO setIp(String ip)
	{
		this.ip = ip;
		return this;
	}

	public QnaDTO setImages_code(int images_code)
	{
		this.images_code = images_code;
		return this;
	}

	public QnaDTO setStatus(String status)
	{
		this.status = status;
		return this;
	}
}