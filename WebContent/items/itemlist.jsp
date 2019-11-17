<%@page import="java.util.HashMap"%>
<%@page import="model.FileDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> itemList = (ArrayList<ItemsDTO>) request.getAttribute("BOOKLIST");
	@SuppressWarnings("unchecked")
	ArrayList<FileDTO> thumbnails = (ArrayList<FileDTO>) request.getAttribute("THUMBNAILS");
	@SuppressWarnings("unchecked")
	HashMap<String, Integer> pageData = (HashMap<String, Integer>) request.getAttribute("PAGE_DATA");

	pageContext.setAttribute("THUMBNAILS", thumbnails);
	pageContext.setAttribute("BOOKLIST", itemList);
	pageContext.setAttribute("PAGE_DATA", pageData);
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>상품 목록</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>

	<jsp:include page="/navbar.jsp"></jsp:include>
	<br>

	<div class="container border border-info" align="center">
		<table>
			<tr>
				<td>
					<h6>월간 인기 순위</h6>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<div class="container border border-info" align="center">
		<br>
		<c:forEach var="book" items="${pageScope.BOOKLIST}" varStatus="status">
			<div class="card border-dark mb-3" style="width: 55rem; height: 14rem;">
				<div class="row">

					<div class="col-md-4">
						<c:if test="${pageScope.THUMBNAILS[status.index] != null }">
							<img class="align-self-center img-fluid" src="/imgfolder/itemImages/${pageScope.THUMBNAILS[status.index].file_name }" class="card-img" alt="이미지 없음" width="100px" />
						</c:if>
						<c:if test="${pageScope.THUMBNAILS[status.index] == null }">
							<img class="img-fluid" src="" class="card-img" alt="이미지 없음">
						</c:if>
					</div>
					<div class="col-md-8">
						<div class="card-body">
							<b><a href="/AspireStore/items/item.aspire?ccode=${book.item_category_code }&icode=${book.item_code }" id="itemName" class="card-title">
									<c:out value="${book.item_name }" />
								</a></b>
							<p id="item_introduction" class="card-text">
								<c:out value="${book.item_book_introduction }" />
							</p>
						</div>
					</div>
				</div>
			</div>
			
			
			<table class="table">
				<tr>
					<div>
						<div>
						</div>
					</div>
				</tr>
			 </table>
		</c:forEach>

	</div>
	<%@ include file="/footer.html"%>

	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
</body>

</html>