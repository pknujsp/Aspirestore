package model;

public class AuthorDTO
{
	private int author_code;
	private String author_name;
	private String author_region;
	private String author_information;

	public int getAuthor_code()
	{
		return author_code;
	}

	public String getAuthor_name()
	{
		return author_name;
	}

	public String getAuthor_region()
	{
		return author_region;
	}

	public String getAuthor_information()
	{
		return author_information;
	}

	public AuthorDTO setAuthor_code(int author_code)
	{
		this.author_code = author_code;
		return this;
	}

	public AuthorDTO setAuthor_name(String author_name)
	{
		this.author_name = author_name;
		return this;
	}

	public AuthorDTO setAuthor_region(String author_region)
	{
		this.author_region = author_region;
		return this;
	}

	public AuthorDTO setAuthor_information(String author_information)
	{
		this.author_information = author_information;
		return this;
	}

}