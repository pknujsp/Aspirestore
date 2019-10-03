<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> itemList = (ArrayList<ItemsDTO>) request.getAttribute("BOOKLIST");

	int totalItemNum = 0;
	int itemNumPerPage = 20;
	int pagePerBlock = 10;

	int totalPageNum = 0;
	int totalBlockNum = 0;

	int currentPage = 1;
	int currentBlock = 1;

	int startNum = 0;
	int endNum = 20;

	int itemNum = 0;
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>상품 목록</title>

<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>

	<jsp:include page="/navbar.jsp"></jsp:include>
	<br>

	<div class="container border border-info" align="center">
		<table>
			<tr>
				<td><h6>월간 인기 순위</h6></td>
			</tr>
		</table>
	</div>
	<br>
	<div class="container border border-info" align="center">
		<br>
		<%
			for (int i = 0; i < itemList.size(); ++i)
			{
		%><div class="card border-dark mb-3"
			style="width: 55rem; height: 14rem;">
			<div class="row">

				<div class="col-md-4">
					<img src="..." class="card-img" alt="이미지 없음">
				</div>
				<div class="col-md-8">
					<div class="card-body">
						<b><a
							href="/AspireStore/items/item.aspire?ccode=701&icode=<%=itemList.get(i).getItem_code()%>"
							id="itemName" class="card-title"><%=itemList.get(i).getItem_name()%></a></b>
						<p id="itemIntroduction" class="card-text">
							<%=itemList.get(i).getItem_book_introduction()%>
					</div>
				</div>
			</div>
		</div>
		<%
			}
		%>

	</div>
	<%@ include file="/footer.html"%>

	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
</body>

</html>