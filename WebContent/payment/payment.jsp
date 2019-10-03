<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	ItemsDTO item = (ItemsDTO) request.getAttribute("ITEM");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>주문/결제</title>

<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>
	<div>
		<h4>주문 도서 확인</h4>
		<div>
			<table>
				<thead>
					<tr>
						<th>도서 명</th>
						<th>금액</th>
						<th>주문 수량</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><b><a
								href="/AspireStore/items/item.aspire?ccode=701&icode=<%=item.getItem_code()%>"
								id="itemName"><%=item.getItem_name()%></a></b></td>
				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="/footer.html"%>
	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>