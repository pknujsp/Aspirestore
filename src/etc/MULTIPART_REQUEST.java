package etc;

public enum MULTIPART_REQUEST
{
	SAVE_FOLDER("C:/programming/eclipseprojects/AspireStore/WebContent/qnaImages"),
	BOOKIMG_SAVE_FOLDER("C:/programming/eclipseprojects/AspireStore/WebContent/itemImages"), ENC_TYPE("UTF-8"),
	MAX_SIZE("10485760");

	final String name;

	private MULTIPART_REQUEST(String name)
	{
		this.name = name;
	}

	public String getName()
	{
		return name;
	}
}