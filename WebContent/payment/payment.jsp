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
<meta charset="UTF-8">
<title>주문/결제</title>
</head>
<body>

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
</body>
</html>