<%@page import="java.util.Iterator"%>
<%@page import="etc.OrderInformation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%!int getTotalPrice(ArrayList<OrderInformation> list) {
		int totalPrice = 0;

		for (int i = 0; i < list.size(); ++i) {
			totalPrice += list.get(i).getItem_price() * list.get(i).getOrder_quantity();
		}

		return totalPrice;
	}%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> items = (ArrayList<ItemsDTO>) request.getAttribute("ITEMS");

	@SuppressWarnings("unchecked")
	ArrayList<OrderInformation> orderInformations = (ArrayList<OrderInformation>) request
			.getAttribute("ORDER_INFORMATIONS");

	final int totalPrice = getTotalPrice(orderInformations);
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>주문서 작성 및 결제</title>

<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>
	<div>
		<h5>주문 도서 확인</h5>
		<div>
			<table class="table">
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
							for (int i = 0; i < items.size(); ++i) {
						%>
						<td><b><a
								href="/AspireStore/items/item.aspire?ccode=<%=items.get(i).getItem_category_code()%>&icode=<%=items.get(i).getItem_code()%>"
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

		<hr>

		<form method="post" id="orderForm" name="orderForm" action="/AspireStore/payment.aspire">
			<div>
				<h5>주문서 작성</h5>

				<div>
					<strong>주문자 정보</strong>
					<table>
						<tr>
							<th>성명</th>
							<td><span><label><input type="text"
										id="orderer_name" name="orderer_name" value="" /></label></span></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><input type="text" class="text"
								id="orderer_mobilephone_number_1"
								name="orderer_mobilephone_number_1" value="" /> - <input
								type="text" class="text" id="orderer_mobilephone_number_2"
								name="orderer_mobilephone_number_2" value="" /> - <input
								type="text" class="text" id="orderer_mobilephone_number_3"
								name="orderer_mobilephone_number_3" value="" /></td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td><input type="text" class="text"
								id="orderer_generalphone_number_1"
								name="orderer_generalphone_number_1" value="" /> - <input
								type="text" class="text" id="orderer_generalphone_number_2"
								name="orderer_generalphone_number_2" value="" /> - <input
								type="text" class="text" id="orderer_generalphone_number_3"
								name="orderer_generalphone_number_3" value="" /></td>
						</tr>
						<tr>
							<th>이메일 주소</th>
							<td><input type="email" id="orderer_email"
								name="orderer_email" value="" /></td>
					</table>
				</div>
				<hr>
				<div>
					<strong>배송 정보</strong>
					<table>
						<tr>
							<th>배송방법</th>
							<td>
								<div>
									<span><label><input type="radio" class="radio" id="delivery_method"
											name="delivery_method" value="method_general_delivery" />일반택배</label></span>
									<span><label><input type="radio" class="radio" id="delivery_method"
											name="delivery_method" value="method_pickup_in_store" />편의점
											픽업</label></span>
								</div>
							</td>

						</tr>
					</table>
				</div>

				<div>
					<table>
						<tr>
							<th>배송지</th>
							<td>
								<div>
									<span><label><input type="radio" class="radio"
											name="select_address" id="select_address"
											value="latest_address" />최근 배송지</label></span> <span><label><input
											type="radio" class="radio" name="select_address"
											id="select_address" value="address_list" />주소록</label></span> <span><label><input
											type="radio" class="radio" name="select_address"
											id="select_address" value="write_new_address" />신규 입력</label></span>
								</div>
							</td>
						</tr>
					</table>
				</div>

				<div>
					<table>
						<tr>
							<th>수령인 성명</th>
							<td>
								<div>
									<span><label><input type="text" class="text"
											id="recepient_name" name="recepient_name" value="" /></label></span> <span><input
										type="button" id="setRecepientInfo" name="setRecepientInfo"
										value="주문자 정보와 동일" /></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table>
						<tr>
							<th>휴대전화</th>
							<td><input type="text" class="text"
								id="recepient_mobilephone_number_1" name="recepient_mobilephone_number_1" value="" />
								- <input type="text" class="text" id="recepient_mobilephone_number_2"
								name="recepient_mobilephone_number_2" value="" /> - <input type="text"
								class="text" id="recepient_mobilephone_number_3"
								name="recepient_mobilephone_number_3" value="" /></td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td><input type="text" class="text"
								id="recepient_generalphone_number_1" name="recepient_generalphone_number_1" value="" />
								- <input type="text" class="text" id="recepient_generalphone_number_2"
								name="recepient_generalphone_number_2" value="" /> - <input type="text"
								class="text" id="recepient_generalphone_number_3"
								name="recepient_generalphone_number_3" value="" /></td>
						</tr>
					</table>
				</div>

				<div>

					<table>
						<tr>
							<td><p>
									<span>우편번호 <input type="text" class="text"
										id="postal_code" name="postal_code" value=""
										readonly="readonly" /></span> <span><input type="button"
										name="searchAddress" id="searchAddress" value="주소 검색" /></span>
								</p>
								<p>
									도로명 주소 <input type="text" class="text" id="road_name_address"
										name="road_name_address" value="" readonly="readonly" />
								</p>
								<p>
									지번 주소 <input type="text" class="text" id="number_address"
										name="number_address" value="" readonly="readonly" />
								</p> <input type="button" name="add_to_addresslist"
								id="add_to_addresslist" value="주소록에 저장" /></td>
						</tr>
					</table>
				</div>


			</div>
			<hr>

			<div>
				<h5>결제 수단 선택</h5>
				<div>
					<table>
						<tr>
							<th>신용카드</th>
							<td><input type="radio" class="radio" name="payment_method"
								id="payment_method" value="domestic_credit_card" />일반 신용카드(체크카드
								포함)</td>
						</tr>
						<tr>
							<th>계좌이체</th>
							<td><input type="radio" class="radio" name="payment_method"
								id="payment_method" value="account_transfer" />계좌이체 <input
								type="radio" class="radio" name="payment_method"
								id="payment_method" value="deposit" />무통장 입금</td>
						</tr>
						<tr>
							<th>간편결제</th>
							<td><input type="radio" class="radio" name="payment_method"
								id="payment_method" value="kakaopay" />카카오 페이 <input
								type="radio" class="radio" name="payment_method"
								id="payment_method" value="payco" />페이코</td>
						</tr>
					</table>
				</div>
			</div>
			<hr>

			<div>
				<h5>최종 결제 금액</h5>
				<div>
					<span><strong><%=totalPrice%>원</strong></span>
					<input type="hidden" id="total_price" name="total_price" value="<%=totalPrice %>"/>
					 <span><button
							id="payment_button" name="payment_button" onclick="javascript:payment()">결제 하기</button></span>
				</div>
			</div>
		</form>
	</div>


	<%@ include file="/footer.html"%>
	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
		function payment() {
			document.getElementById('orderForm').submit();
		}
		
	</script>
</body>
</html>