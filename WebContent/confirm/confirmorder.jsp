<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%
	String sessionKey=(String)session.getAttribute("SESSIONKEY");
	final int[] codes = (int[])session.getAttribute("ORDER_SALE_CODES");
	
	session.removeAttribute("ORDER_SALE_CODES");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>주문 확인</title>

<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>

	<div>
		<hr>
		<div>
			<h5 style="text-align: center">주문/결제 완료, 주문내역을 확인해주세요.</h5>
		</div>
		<hr>
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
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>

	</div>
</body>
</html>