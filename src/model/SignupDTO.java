package model;

public class SignupDTO
{
	String id;
	String password;
	String name;
	String nickname;
	String birthdate;
	String phone;
	String gender;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getBirthdate()
	{
		return birthdate;
	}

	public void setBirthdate(String birthdate)
	{
		this.birthdate = birthdate;
	}

	public String getPhone()
	{
		return phone;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public String getGender()
	{
		return gender;
	}

	public void setGender(String gender)
	{
		this.gender = gender;
	}

	public SignupDTO(String id, String password, String name, String nickname, String birthdate, String phone,
			String gender)
	{
		
		this.id = id;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.birthdate = birthdate;
		this.phone = phone;
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
