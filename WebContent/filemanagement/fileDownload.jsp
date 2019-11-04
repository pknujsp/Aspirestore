<%@page import="java.io.File"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page language="java" contentType="application; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	final String fileUri = request.getParameter("fileUri");
	final String fileName = request.getParameter("fileName");
	final File file = new File(fileUri + File.separator + fileName);
	byte[] fileData = new byte[(int) file.length()];

	response.setHeader("Accept-Ranges", "bytes");

	if (request.getHeader("User-Agent").indexOf("MSIE6.0") != -1)
	{
		response.setContentType("application/smnet;charset=utf-8");
		response.setHeader("Content-Disposition", "filename=" + fileName + ";");
	} else
	{
		response.setContentType("application/smnet;charset=utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
	}

	out.clear();
	out = pageContext.pushBody();

	if (file.isFile())
	{
		try (BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(
						response.getOutputStream());)
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
%>