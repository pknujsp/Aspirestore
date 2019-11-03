package controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

public class ServletFileManagement extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		downloadFile(request, response, , this.get);

	}

	protected void downloadFile(HttpServletRequest request, HttpServletResponse response,JspWriter jspWriter,PageContext pageContext) throws ServletException, IOException
	{
		final String fileUri = request.getAttribute("FILE_URI").toString();

		File file = new File(fileUri);
		byte[] fileData = new byte[(int) file.length()];

		jspWriter.clear();
		jspWriter=pageContext.pushBody();

		if (file.isFile())
		{
			try (BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
					BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(response.getOutputStream());)
			{
				int length = 0;

				while ((length = bufferedInputStream.read(fileData)) != -1)
				{
					bufferedOutputStream.write(fileData, 0, length);
				}

			} catch (Exception e)
			{
				e.printStackTrace();
			}
		}
	}
}