package model;

public class UserDTO
{
	private String user_id;
	private String user_name;
	private String mobile1;
	private String mobile2;
	private String mobile3;
	private String mobile;
	private String general1;
	private String general2;
	private String general3;
	private String general;
	private String date_time;

	public String getUser_id()
	{
		return user_id;
	}

	public String getUser_name()
	{
		return user_name;
	}

	public String getMobile1()
	{
		return mobile1;
	}

	public String getMobile2()
	{
		return mobile2;
	}

	public String getMobile3()
	{
		return mobile3;
	}

	public String getGeneral1()
	{
		return general1;
	}

	public String getGeneral2()
	{
		return general2;
	}

	public String getGeneral3()
	{
		return general3;
	}

	public String getDate_time()
	{
		return date_time;
	}

	public UserDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public UserDTO setUser_name(String user_name)
	{
		this.user_name = user_name;
		return this;
	}

	public UserDTO setMobile1(String mobile1)
	{
		this.mobile1 = mobile1;
		return this;
	}

	public UserDTO setMobile2(String mobile2)
	{
		this.mobile2 = mobile2;
		return this;
	}

	public String getMobile()
	{
		return mobile;
	}

	public String getGeneral()
	{
		return general;
	}

	public UserDTO setMobile(String mobile)
	{
		this.mobile = mobile;
		return this;
	}

	public UserDTO setGeneral(String general)
	{
		this.general = general;
		return this;
	}

	public UserDTO setMobile3(String mobile3)
	{
		this.mobile3 = mobile3;
		return this;
	}

	public UserDTO setGeneral1(String general1)
	{
		this.general1 = general1;
		return this;
	}

	public UserDTO setGeneral2(String general2)
	{
		this.general2 = general2;
		return this;
	}

	public UserDTO setGeneral3(String general3)
	{
		this.general3 = general3;
		return this;
	}

	public UserDTO setDate_time(String date_time)
	{
		this.date_time = date_time;
		return this;
	}

}
