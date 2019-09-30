package controller;

import java.awt.event.InputEvent;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.SigninDAO;

public class ServletSignin extends HttpServlet
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			ServletContext servletContext = this.getServletContext();

			String email = (String) request.getAttribute("EMAIL");
			String password = (String) request.getAttribute("PASSWORD");
			SigninDAO dao = (SigninDAO) servletContext.getAttribute("signinDAO");
			PrintWriter out = response.getWriter();

			if (dao.signIn(email, password))
			{
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("SESSIONKEY", email);

				request.setAttribute("VIEWURL", "/index.jsp");
				out.println("<script>alert('로그인 성공');");	
				out.println("</script>");
			} else
			{
				request.setAttribute("VIEWURL", "/signin.jsp");
				out.println("<script>alert('로그인 실패');");				
				out.println("</script>");
			}
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}