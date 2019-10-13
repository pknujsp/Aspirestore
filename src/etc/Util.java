package etc;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Util
{
	public static String getCurrentDateTime()
	{
		return new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
	}

	public static String getCurrentDate()
	{
		return new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	}
}
