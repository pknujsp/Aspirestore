package model;

public class FileDTO
{
	private int image_code;
	private int question_post_code;
	private int answer_post_code;
	private int review_code;
	private int item_code;
	private String item_category_code;
	private String uploader_id;
	private String file_uri;
	private String file_name;
	private int file_size;
	private String uploaded_date_time;
	private String image_position;

	public int getImage_code()
	{
		return image_code;
	}

	public String getImage_position()
	{
		return image_position;
	}

	public int getQuestion_post_code()
	{
		return question_post_code;
	}

	public int getAnswer_post_code()
	{
		return answer_post_code;
	}

	public String getItem_category_code()
	{
		return item_category_code;
	}

	public int getItem_code()
	{
		return item_code;
	}

	public int getReview_code()
	{
		return review_code;
	}

	public String getUploader_id()
	{
		return uploader_id;
	}

	public String getFile_uri()
	{
		return file_uri;
	}

	public String getFile_name()
	{
		return file_name;
	}

	public int getFile_size()
	{
		return file_size;
	}

	public String getUploaded_date_time()
	{
		return uploaded_date_time;
	}

	public FileDTO setImage_code(int image_code)
	{
		this.image_code = image_code;
		return this;
	}

	public FileDTO setQuestion_post_code(int question_post_code)
	{
		this.question_post_code = question_post_code;
		return this;
	}

	public FileDTO setAnswer_post_code(int answer_post_code)
	{
		this.answer_post_code = answer_post_code;
		return this;
	}

	public FileDTO setUploader_id(String uploader_id)
	{
		this.uploader_id = uploader_id;
		return this;
	}

	public FileDTO setFile_uri(String file_uri)
	{
		this.file_uri = file_uri;
		return this;
	}

	public FileDTO setFile_name(String file_name)
	{
		this.file_name = file_name;
		return this;
	}

	public FileDTO setFile_size(int file_size)
	{
		this.file_size = file_size;
		return this;
	}

	public FileDTO setReview_code(int review_code)
	{
		this.review_code = review_code;
		return this;
	}

	public FileDTO setItem_category_code(String item_category_code)
	{
		this.item_category_code = item_category_code;
		return this;
	}

	public FileDTO setItem_code(int item_code)
	{
		this.item_code = item_code;
		return this;
	}

	public FileDTO setUploaded_date_time(String uploaded_date_time)
	{
		this.uploaded_date_time = uploaded_date_time;
		return this;
	}

	public FileDTO setImage_position(String image_position)
	{
		this.image_position = image_position;
		return this;
	}
}