package model;

public class SignupDTO
{
	private String id;
	private String password;
	private String name;
	private String nickname;
	private String birthdate;
	private String phone1;
	private String phone2;
	private String phone3;
	private String gender;

	public String getId()
	{
		return id;
	}

	public String getPassword()
	{
		return password;
	}

	public String getName()
	{
		return name;
	}

	public String getNickname()
	{
		return nickname;
	}

	public String getBirthdate()
	{
		return birthdate;
	}

	public String getPhone1()
	{
		return phone1;
	}

	public String getPhone2()
	{
		return phone2;
	}

	public String getPhone3()
	{
		return phone3;
	}

	public String getGender()
	{
		return gender;
	}

	public SignupDTO setId(String id)
	{
		this.id = id;
		return this;
	}

	public SignupDTO setPassword(String password)
	{
		this.password = password;
		return this;
	}

	public SignupDTO setName(String name)
	{
		this.name = name;
		return this;
	}

	public SignupDTO setNickname(String nickname)
	{
		this.nickname = nickname;
		return this;
	}

	public SignupDTO setBirthdate(String birthdate)
	{
		this.birthdate = birthdate;
		return this;
	}

	public SignupDTO setPhone1(String phone1)
	{
		this.phone1 = phone1;
		return this;
	}

	public SignupDTO setPhone2(String phone2)
	{
		this.phone2 = phone2;
		return this;
	}

	public SignupDTO setPhone3(String phone3)
	{
		this.phone3 = phone3;
		return this;
	}

	public SignupDTO setGender(String gender)
	{
		this.gender = gender;
		return this;
	}

	public SignupDTO(String id, String password, String name, String nickname, String birthdate, String phone1,
			String phone2, String phone3, String gender)
	{
		this.id = id;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.birthdate = birthdate;
		this.phone1 = phone1;
		this.phone2 = phone2;
		this.phone3 = phone3;
		this.gender = changeGenderString(gender);
	}

	String changeGenderString(String gender)
	{
		if (gender.equals("남성"))
		{
			gender = "m";
		} else
		{
			gender = "f";
		}
		return gender;
	}
}
