package model;

public class PublisherDTO
{
	private int publisher_code;
	private String publisher_name;
	private String publisher_region;

	public int getPublisher_code()
	{
		return publisher_code;
	}

	public String getPublisher_name()
	{
		return publisher_name;
	}

	public String getPublisher_region()
	{
		return publisher_region;
	}

	public PublisherDTO setPublisher_code(int publisher_code)
	{
		this.publisher_code = publisher_code;
		return this;
	}

	public PublisherDTO setPublisher_name(String publisher_name)
	{
		this.publisher_name = publisher_name;
		return this;
	}

	public PublisherDTO setPublisher_region(String publisher_region)
	{
		this.publisher_region = publisher_region;
		return this;
	}

}