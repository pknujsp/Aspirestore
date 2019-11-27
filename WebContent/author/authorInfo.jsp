<%@page import="model.AuthorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	AuthorDTO author = (AuthorDTO) request.getAttribute("AUTHOR");
	pageContext.setAttribute("AUTHOR", author);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageScope.AUTHOR.author_name}</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />

	<div class="container">
		<div>
			<table class="table">
				<tr>
					<td style="width: 20%; text-align: center;">사진 위치</td>
					<td style="width: 80%; text-align: center;">
						<table class="table">
							<tr>
								<td>
									<h5>${pageScope.AUTHOR.author_name}</h5>
								</td>
							</tr>
							<tr>
								<td>${pageScope.AUTHOR.author_region }</td>
							</tr>
							<tr>
								<td>
									<pre style="white-space: pre-line;">${pageScope.AUTHOR.author_information }</pre>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<%@ include file="/footer.html"%>
	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>
</body>
</html>