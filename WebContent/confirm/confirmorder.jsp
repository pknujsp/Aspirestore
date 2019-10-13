<%@page import="model.ItemsDTO"%>
<%@page import="model.SalehistoryDTO"%>
<%@page import="model.OrderhistoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="orderPaymentDAO" class="model.OrderPaymentDAO" />

<%
	String sessionKey = (String) session.getAttribute("SESSIONKEY");
	int[] codes = (int[]) session.getAttribute("ORDER_SALE_CODES");
	session.removeAttribute("ORDER_SALE_CODES");
	
	Object[] data = orderPaymentDAO.getLatestOrderInfo(codes, sessionKey);

	pageContext.setAttribute("orderHistoryData", (OrderhistoryDTO) data[0]);
	pageContext.setAttribute("saleHistoryData", (SalehistoryDTO[]) data[1]);
	pageContext.setAttribute("orderedItemsData", (ItemsDTO[]) data[2]);
	pageContext.setAttribute("paymentMethods", orderPaymentDAO.getOrderMethod(
			((OrderhistoryDTO) data[0]).getDelivery_method(), ((OrderhistoryDTO) data[0]).getPayment_method()));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>주문 확인</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
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
						<th>도서 명 / 저자 / 출판사</th>
						<th>금액</th>
						<th>주문 수량</th>
						<th>합계</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="data" items="${pageScope.orderedItemsData }">
						<tr>
							<td><span><b><a
										href="/AspireStore/items/item.aspire?ccode=${data.item_category}&icode=${data.item_code}">
											<c:out value="${ data.item_name }" />
									</a> </b></span> &nbsp;<span><i><c:out value="${data.author_name }" /></i></span>
								&nbsp;<span><i><c:out value="${data.publisher_name }" /></i></span>
							</td>
							<td><c:out value="${ data.selling_price }" /></td>
							<td><c:out value="${ data.quantity }" /></td>
							<td><c:out
									value="${ data.quantity }*${ data.selling_price }" /></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>

		<hr>

		<div>
			<div>
				<h5>주문자 정보</h5>
				<table>
					<tr>
						<td>성명 <c:out
								value="${pageScope.orderHistoryData.orderer_name}" />
						</td>
					</tr>
					<tr>
						<td>휴대전화 <c:out
								value="${pageScope.orderHistoryData.orderer_mobile}" />
						</td>
					</tr>
					<tr>
						<td>일반전화 <c:out
								value="${pageScope.orderHistoryData.orderer_general}" />
						</td>
					</tr>
					<tr>
						<td>이메일 주소 <c:out
								value="${pageScope.orderHistoryData.orderer_email}" />
						</td>
					</tr>
				</table>
			</div>
			<hr>
			<div>
				<h5>수령인 정보</h5>
				<table>
					<tr>
						<td>성명 <c:out
								value="${pageScope.orderHistoryData.recipient_name}" />
						</td>
					</tr>
					<tr>
						<td>휴대전화 <c:out
								value="${pageScope.orderHistoryData.recipient_mobile}" />
						</td>
					</tr>
					<tr>
						<td>일반전화 <c:out
								value="${pageScope.orderHistoryData.recipient_general}" />
						</td>
					</tr>
				</table>
			</div>

			<hr>

			<div>
				<h5>배송 정보</h5>
				<table>
					<tr>
						<td>배송 방법</td>
					</tr>
					<tr>
						<td>우편번호 <c:out
								value="${pageScope.orderHistoryData.postal_code}" />
						</td>
					</tr>
					<tr>
						<td>도로명 주소 <c:out value="${pageScope.orderHistoryData.road}" />
						</td>
					</tr>
					<tr>
						<td>지번 주소 <c:out value="${pageScope.orderHistoryData.number}" />
						</td>
					</tr>
					<tr>
						<td>세부 주소 <c:out value="${pageScope.orderHistoryData.detail}" />
						</td>
					</tr>
				</table>
			</div>

			<hr>		
				<div>
					결제 수단 
				</div>				
		</div>

	</div>
</body>
</html>
