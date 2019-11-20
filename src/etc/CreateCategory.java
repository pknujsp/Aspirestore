package etc;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.HashMap;

public class CreateCategory
{
	public static void main(String[] args)
	{
		try
		{
			File file = new File("C:/programming/eclipseprojects/AspireStore/category.txt");
			File processedFile = new File("C:/programming/eclipseprojects/AspireStore/processed.txt");

			BufferedReader buf = new BufferedReader(new FileReader(file));
			BufferedWriter writer = new BufferedWriter(new FileWriter(processedFile));
			String str = null;

			while ((str = buf.readLine()) != null)
			{
				writer.write(processString(str));
				writer.newLine();
			}
			writer.close();
			buf.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	static private String processString(String str)
	{
		String[] separatedStr = str.split("\t");
		int categoryCode = Integer.parseInt(separatedStr[2].substring(1, separatedStr[2].length() - 1));

		return setCode(separatedStr[0].substring(1, separatedStr[0].length() - 1), separatedStr[1].substring(1, separatedStr[1].length() - 1), categoryCode);
	}

	static private String setCode(String name, String parentCode, int categoryCode)
	{
		String result = null;
		if (parentCode.equals("\\N"))
		{
			// parentCode
			result = name + " : " + String.valueOf(categoryCode);
		} else
		{
			result = name + " : " + parentCode + ", " + String.valueOf(categoryCode);
		}
		return result;
	}
}
