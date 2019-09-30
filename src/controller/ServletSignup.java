package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.SigninDAO;
import model.SignupDAO;
import model.SignupDTO;

public class ServletSignup extends HttpServlet
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			SignupDTO information = (SignupDTO) request.getAttribute("SIGNUPDTO");
			SignupDAO dao = (SignupDAO) servletContext.getAttribute("signupDAO");
			PrintWriter out=response.getWriter();
		
			
			if(dao.insertNewUser(information))
			{
				request.setAttribute("VIEWURL", "/index.jsp");
				out.println("<script>alert('회원가입 성공');");
				out.println("</script>");
			}
			else
			{
				request.setAttribute("VIEWURL", "/signup.jsp");
				out.println("<script>alert('회원가입 실패');");
				out.println("</script>");
			}
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}