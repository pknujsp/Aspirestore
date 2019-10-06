package model;

public class AddressDTO
{
	private String user_id;
	private int code;
	private String postal_code;
	private String road;
	private String number;
	private String detail;
	private String last_usage;

	public String getUser_id()
	{
		return user_id;
	}
	
	public int getCode()
	{
		return code;
	}

	public String getPostal_code()
	{
		return postal_code;
	}

	public String getRoad()
	{
		return road;
	}

	public String getNumber()
	{
		return number;
	}

	public String getDetail()
	{
		return detail;
	}
	
	public String getLast_usage()
	{
		return last_usage;
	}

	public AddressDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}
	
	public AddressDTO setCode(int code)
	{
		this.code = code;
		return this;
	}

	public AddressDTO setPostal_code(String postal_code)
	{
		this.postal_code = postal_code;
		return this;
	}

	public AddressDTO setRoad(String road)
	{
		this.road = road;
		return this;
	}

	public AddressDTO setNumber(String number)
	{
		this.number = number;
		return this;
	}

	public AddressDTO setDetail(String detail)
	{
		this.detail = detail;
		return this;
	}
	
	public AddressDTO setLast_usage(String last_usage)
	{
		this.last_usage = last_usage;
		return this;
	}
}
