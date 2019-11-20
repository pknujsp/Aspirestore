package etc;

import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

import model.AddressDAO;
import model.AuthorDAO;
import model.BasketDAO;
import model.CategoryDAO;
import model.FileDAO;
import model.ItemsDAO;
import model.OrdersManagementDAO;
import model.OrderPaymentDAO;
import model.PublisherDAO;
import model.QnaDAO;
import model.ReviewDAO;
import model.SigninDAO;
import model.SignupDAO;
import model.UserDAO;

public class ServletContextLoaderListener implements ServletContextListener
{

	@Override
	public void contextInitialized(ServletContextEvent event)
	{
		try
		{
			ServletContext servletContext = event.getServletContext();
			InitialContext initialContext = new InitialContext();
			DataSource ds = (DataSource) initialContext.lookup("java:comp/env/jdbc/mariadb");

			SigninDAO signinDAO = new SigninDAO();
			SignupDAO signupDAO = new SignupDAO();
			ItemsDAO itemsDAO = new ItemsDAO();
			AuthorDAO authorDAO = new AuthorDAO();
			OrderPaymentDAO orderpaymentDAO = new OrderPaymentDAO();
			PublisherDAO publisherDAO = new PublisherDAO();
			AddressDAO addressDAO = new AddressDAO();
			UserDAO userDAO = new UserDAO();
			BasketDAO basketDAO = new BasketDAO();
			OrdersManagementDAO ordersManagementDAO = new OrdersManagementDAO();
			QnaDAO qnaDAO = new QnaDAO();
			FileDAO fileDAO = new FileDAO();
			ReviewDAO reviewDAO = new ReviewDAO();
			CategoryDAO categoryDAO = new CategoryDAO();

			signinDAO.setDataSource(ds);
			signupDAO.setDataSource(ds);
			itemsDAO.setDataSource(ds);
			authorDAO.setDataSource(ds);
			orderpaymentDAO.setDataSource(ds);
			publisherDAO.setDataSource(ds);
			addressDAO.setDataSource(ds);
			userDAO.setDataSource(ds);
			basketDAO.setDataSource(ds);
			ordersManagementDAO.setDataSource(ds);
			qnaDAO.setDataSource(ds);
			fileDAO.setDataSource(ds);
			reviewDAO.setDataSource(ds);
			categoryDAO.setDataSource(ds);

			servletContext.setAttribute("signinDAO", signinDAO);
			servletContext.setAttribute("signupDAO", signupDAO);
			servletContext.setAttribute("itemsDAO", itemsDAO);
			servletContext.setAttribute("authorDAO", authorDAO);
			servletContext.setAttribute("ORDER_PAYMENT_DAO", orderpaymentDAO);
			servletContext.setAttribute("PUBLISHER_DAO", publisherDAO);
			servletContext.setAttribute("ADDRESS_DAO", addressDAO);
			servletContext.setAttribute("USER_DAO", userDAO);
			servletContext.setAttribute("BASKET_DAO", basketDAO);
			servletContext.setAttribute("MANAGEMENT_ORDERS_DAO", ordersManagementDAO);
			servletContext.setAttribute("QNA_DAO", qnaDAO);
			servletContext.setAttribute("FILE_DAO", fileDAO);
			servletContext.setAttribute("REVIEW_DAO", reviewDAO);
			servletContext.setAttribute("CATEGORY_DAO", categoryDAO);
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}