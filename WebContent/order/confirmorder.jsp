<%@page import="java.util.ArrayList"%>
<%@page import="model.OrderPaymentDAO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="model.SalehistoryDTO"%>
<%@page import="model.OrderhistoryDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	@SuppressWarnings("unchecked")
	ArrayList<SalehistoryDTO> saleHistory = (ArrayList<SalehistoryDTO>) session.getAttribute("SALE_HISTORY");

	OrderhistoryDTO orderHistory = (OrderhistoryDTO) session.getAttribute("ORDER_HISTORY");

	pageContext.setAttribute("orderHistory", orderHistory);
	pageContext.setAttribute("saleHistory", saleHistory);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
					<c:forEach var="data" items="${pageScope.saleHistory }" varStatus="status">
						<c:set var="idx" value="${status.index}" />
						<tr>
							<td>
								<span>
									<b><a href="/AspireStore/items/item.aspire?ccode=${data.item_category_code}&icode=${data.item_code}">
											<c:out value="${ data.item_name }" />
										</a> </b>
								</span>
								&nbsp; &nbsp;
								<span>
									<i><c:out value="${data.publisher_name }" /></i>
								</span>
							</td>
							<td>
								<c:out value="${ data.item_price }" />
							</td>
							<td>
								<c:out value="${ data.sale_quantity }" />
							</td>
							<td>
								<c:out value="${ data.total_price}" />
							</td>
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
						<th>성명</th>
						<td>
							<c:out value="${pageScope.orderHistory.orderer_name}" />
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<c:out value="${pageScope.orderHistory.orderer_mobile1}" />
							-
							<c:out value="${pageScope.orderHistory.orderer_mobile2}" />
							-
							<c:out value="${pageScope.orderHistory.orderer_mobile3}" />
						</td>
					</tr>
					<tr>
						<th>일반전화</th>
						<td>
							<c:out value="${pageScope.orderHistory.orderer_general1}" />
							-
							<c:out value="${pageScope.orderHistory.orderer_general2}" />
							-
							<c:out value="${pageScope.orderHistory.orderer_general3}" />
						</td>
					</tr>
					<tr>
						<th>이메일 주소</th>
						<td>
							<c:out value="${pageScope.orderHistory.orderer_email}" />
						</td>
					</tr>
				</table>
			</div>
			<hr>
			<div>
				<h5>수령인 정보</h5>
				<table>
					<tr>
						<th>성명</th>
						<td>
							<c:out value="${pageScope.orderHistory.recepient_name}" />
						</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>
							<c:out value="${pageScope.orderHistory.recepient_mobile1}" />
							-
							<c:out value="${pageScope.orderHistory.recepient_mobile2}" />
							-
							<c:out value="${pageScope.orderHistory.recepient_mobile3}" />
						</td>
					</tr>
					<tr>
						<th>일반전화</th>
						<td>
							<c:out value="${pageScope.orderHistory.recepient_general1}" />
							-
							<c:out value="${pageScope.orderHistory.recepient_general2}" />
							-
							<c:out value="${pageScope.orderHistory.recepient_general3}" />
						</td>
					</tr>
				</table>
			</div>

			<hr>

			<div>
				<h5>요청 사항</h5>
				<pre>
					<c:out value="${pageScope.orderHistory.requested_term }" />
				</pre>
			</div>

			<div>
				<h5>배송 정보</h5>
				<table>
					<tr>
						<th>배송 방법</th>
						<td>
							<c:out value="${pageScope.orderHistory.delivery_method_desc}" />
						</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td>
							<c:out value="${pageScope.orderHistory.postal_code}" />
						</td>
					</tr>
					<tr>
						<th>도로명 주소</th>
						<td>
							<c:out value="${pageScope.orderHistory.road}" />
						</td>
					</tr>
					<tr>
						<th>지번 주소</th>
						<td>
							<c:out value="${pageScope.orderHistory.number}" />
						</td>
					</tr>
					<tr>
						<th>세부 주소</th>
						<td>
							<c:out value="${pageScope.orderHistory.detail}" />
						</td>
					</tr>
				</table>
			</div>

			<hr>
			<div>
				<h5>결제 수단</h5>
				<c:out value="${pageScope.orderHistory.payment_method_desc}" />
			</div>
		</div>
	</div>

	<%@ include file="/footer.html"%>
	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>