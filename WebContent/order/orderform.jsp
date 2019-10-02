<%@page import="etc.OrderInformation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> items = (ArrayList<ItemsDTO>) request.getAttribute("ITEMS");
	
	@SuppressWarnings("unchecked")
	ArrayList<OrderInformation> orderInformations = (ArrayList<OrderInformation>) request
			.getAttribute("ORDER_INFORMATIONS");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성</title>
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
						<%
							for (int i = 0; i < items.size(); ++i)
							{
						%>
						<td><b><a
								href="/AspireStore/items/item.aspire?ccode=701&icode=<%=items.get(i).getItem_code()%>"
								id="itemName"><%=items.get(i).getItem_name()%></a></b></td>
						<td><label><%=items.get(i).getItem_selling_price()%></label></td>
						<td><label><%=orderInformations.get(i).getOrder_quantity()%></label></td>
						<td><label><%=orderInformations.get(i).getTotal_price()%></label></td>
						<%
							}
						%>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>