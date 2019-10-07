<%@page import="model.ItemsDTO"%>
<%@page import="model.SalehistoryDTO"%>
<%@page import="model.OrderhistoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<jsp:useBean id="history" class="model.OrderPaymentDAO" />

<%
	String sessionKey = (String) session.getAttribute("SESSIONKEY");
	final int[] codes = (int[]) session.getAttribute("ORDER_SALE_CODES");

	Object[] data = history.getLatestOrderInfo(codes, sessionKey);

	OrderhistoryDTO[] orderHistoryData = (OrderhistoryDTO[]) data[0];
	SalehistoryDTO[] saleHistoryData = (SalehistoryDTO[]) data[1];
	ItemsDTO[] itemData = (ItemsDTO[]) data[2];

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
					<%
						for (int i = 0; i < saleHistoryData.length; ++i)
						{
					%>
					<tr>
						<td></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>

	</div>
</body>
</html>
