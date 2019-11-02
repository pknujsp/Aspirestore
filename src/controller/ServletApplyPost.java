package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import model.fileDTO;
import model.QnaDAO;
import model.QnaDTO;

public class ServletApplyPost extends HttpServlet
{
	private final String SAVEFOLDER = "C:/programming/eclipseprojects/AspireStore/WebContent/qnaImages";

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		switch (request.getAttribute("TYPE").toString())
		{
		case "QUESTION":
			applyQuestion(request, response);
			break;
		case "ANSWER":
			applyAnswer(request, response);
			break;
		}
	}

	protected void applyQuestion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			MultipartRequest multipartRequest = (MultipartRequest) request.getAttribute("MULTI_REQUEST");

			@SuppressWarnings("rawtypes")
			Enumeration files = multipartRequest.getFileNames();

			ArrayList<fileDTO> fileList = new ArrayList<fileDTO>();

			String currentTime = etc.Util.getCurrentDateTime();
			String questionerId = request.getAttribute("QUESTIONER_ID").toString();
			String subject = request.getAttribute("SUBJECT").toString();
			String content = request.getAttribute("CONTENT").toString();
			int categoryCode = (int) request.getAttribute("CATEGORY");

			while (files.hasMoreElements())
			{
				String file = (String) files.nextElement();
				String fileName = multipartRequest.getFilesystemName(file);

				if (fileName == null)
				{
					// 파일 미 첨부 인 경우
					break;
				} else
				{
					fileList.add(new fileDTO().setFile_name(fileName)
							.setFile_size((int) multipartRequest.getFile(file).length()).setFile_uri(SAVEFOLDER)
							.setUploaded_date_time(currentTime).setUploader_id(questionerId));
				}
			}

			QnaDTO questionData = new QnaDTO().setUser_id(questionerId).setSubject(subject)
					.setCategory_code(categoryCode).setContent(content).setPost_date(currentTime).setIp("1111")
					.setStatus("n").setNumFiles(fileList.size());

			int questionCode = qnaDAO.applyPost(questionData, 'q');

			if (!fileList.isEmpty())
			{
				// 첨부 파일이 존재하는 경우 DB에 파일정보 저장
				qnaDAO.uploadFiles(fileList, questionCode);
			}

			HttpSession session = request.getSession();

			session.setAttribute("TYPE", "GET_QUESTION_POST");
			session.setAttribute("CURRENT_PAGE", 1);
			session.setAttribute("QUESTION_CODE", questionCode);
			request.setAttribute("VIEWURL", "redirect:/AspireStore/csservice/qna.aspire");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}

	protected void applyAnswer(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{
		try
		{
			ServletContext sc = this.getServletContext();
			QnaDAO qnaDAO = (QnaDAO) sc.getAttribute("QNA_DAO");

			MultipartRequest multipartRequest = (MultipartRequest) request.getAttribute("MULTI_REQUEST");

			@SuppressWarnings("rawtypes")
			Enumeration files = multipartRequest.getFileNames();

			ArrayList<fileDTO> fileList = new ArrayList<fileDTO>();

			String currentTime = etc.Util.getCurrentDateTime();
			String managerId = request.getAttribute("ANSWERER_ID").toString();
			int questionCode = (int) request.getAttribute("QUESTION_CODE");
			String subject = request.getAttribute("SUBJECT").toString();
			int categoryCode = (int) request.getAttribute("CATEGORY");
			String content = request.getAttribute("CONTENT").toString();

			// 파일 첨부가 된 경우
			while (files.hasMoreElements())
			{
				String file = (String) files.nextElement();
				String fileName = multipartRequest.getFilesystemName(file);

				fileList.add(new fileDTO().setFile_name(fileName)
						.setFile_size((int) multipartRequest.getFile(file).length()).setFile_uri(SAVEFOLDER)
						.setUploaded_date_time(currentTime).setUploader_id(managerId));
			}

			QnaDTO answerData = new QnaDTO().setQuestion_code(questionCode).setUser_id(managerId).setSubject(subject)
					.setCategory_code(categoryCode).setContent(content).setPost_date(currentTime)
					.setNumFiles(fileList.size()).setIp("1111");

			int answerCode = qnaDAO.applyPost(answerData, 'a');

			if (!fileList.isEmpty())
			{
				// 첨부 파일이 존재하는 경우 DB에 파일정보 저장
				qnaDAO.uploadFiles(fileList, answerCode);
			}

			request.setAttribute("VIEWURL", "redirect:/AspireStore/management/qnamanagement/answerlist.jsp");
		} catch (Exception e)
		{
			throw new ServletException(e);
		}
	}
}

