package model;

public class fileDTO
{
	private int image_code;
	private int question_post_code;
	private int answer_post_code;
	private String uploader_id;
	private String file_uri;
	private String file_name;
	private int file_size;
	private String uploaded_date_time;

	public int getImage_code()
	{
		return image_code;
	}

	public int getQuestion_post_code()
	{
		return question_post_code;
	}

	public int getAnswer_post_code()
	{
		return answer_post_code;
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

	public fileDTO setImage_code(int image_code)
	{
		this.image_code = image_code;
		return this;
	}

	public fileDTO setQuestion_post_code(int question_post_code)
	{
		this.question_post_code = question_post_code;
		return this;
	}

	public fileDTO setAnswer_post_code(int answer_post_code)
	{
		this.answer_post_code = answer_post_code;
		return this;
	}

	public fileDTO setUploader_id(String uploader_id)
	{
		this.uploader_id = uploader_id;
		return this;
	}

	public fileDTO setFile_uri(String file_uri)
	{
		this.file_uri = file_uri;
		return this;
	}

	public fileDTO setFile_name(String file_name)
	{
		this.file_name = file_name;
		return this;
	}

	public fileDTO setFile_size(int file_size)
	{
		this.file_size = file_size;
		return this;
	}

	public fileDTO setUploaded_date_time(String uploaded_date_time)
	{
		this.uploaded_date_time = uploaded_date_time;
		return this;
	}
}