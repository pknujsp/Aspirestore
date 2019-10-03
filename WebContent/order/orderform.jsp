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

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>주문서 작성</title>

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
							for (int i = 0; i < items.size(); ++i)
							{
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

		<hr />

		<div>
			<h4>주문서 작성</h4>
			<div>
				<table class="table">

					<tbody>
						<tr>

							<td>
								<form id="deliveryInfoForm" method="post">
									<div>
										<fieldset>
											<legend>배송방법</legend>
											<input type="radio" class="radio" name="delivery_method"
												value="method_general_delivery" />일반택배 <input type="radio"
												class="radio" name="delivery_method"
												value="method_pickup_in_store" />편의점 픽업
										</fieldset>
									</div>
									<br>
									<div>
										<fieldset>
											<legend>배송지</legend>
											<input type="radio" class="radio" name="select_address"
												id="select_address" value="latest_address" />최근 배송지 <input
												type="radio" class="radio" name="select_address"
												id="select_address" value="address_list" />주소록 <input
												type="radio" class="radio" name="select_address"
												id="select_address" value="write_new_address" />신규 입력
										</fieldset>
									</div>
									<br>
									<div>
										<fieldset>
											<legend>성명</legend>
											<input type="text" class="text" name="order_name" value="" />

										</fieldset>
									</div>
									<br>
									<div>
										<fieldset>
											<legend>배송받을 주소</legend>
											<div>
												<span>우편번호 <input type="text" class="text"
													name="postal_code" value="" readonly /></span> <span><input
													type="button" name="searchAddress" id="searchAddress"
													value="주소 검색" /></span>
											</div>
											<div>
												도로명 주소 <input type="text" class="text"
													name="road_name_address" value="" readonly />
											</div>
											<div>

												지번 주소 <input type="text" class="text" name="number_address"
													value="" readonly />
											</div>
										</fieldset>
									</div>

									<br>
									<div>
										<fieldset>
											<legend>휴대 전화</legend>
											<input type="tel" class="text" name="phone_number" value="" />

										</fieldset>
									</div>

									<br>
									<div>
										<fieldset>
											<legend>일반 전화</legend>
											<input type="tel" class="text"
												name="general_telephone_number" value="" />

										</fieldset>
									</div>
								</form>
							</td>
						</tr>
						<tr>
							<td>
								<form id="paymentMethodForm" method="post">
									<div>
										<fieldset>
											<legend>결제 수단 선택</legend>
											<div>
												<em>신용카드</em>&nbsp;<input type="radio" class="radio" name="payment_method"
													id="payment_method" value="domestic_credit_card" />일반
												신용카드(체크카드 포함) <input type="radio" class="radio"
													name="payment_method" id="payment_method"
													value="overseas_credit_card" />해외 발급 신용카드
											</div>
											<div>
												<em>계좌이체</em>&nbsp;<input type="radio" class="radio" name="payment_method"
													id="payment_method" value="account_transfer" />계좌이체 <input type="radio" class="radio"
													name="payment_method" id="payment_method"
													value="deposit" />무통장 입금
											</div>
												<div>
												<em>간편결제</em>&nbsp;
												<input type="radio" class="radio" name="payment_method"
													id="payment_method" value="kakaopay" />카카오 페이 <input type="radio" class="radio"
													name="payment_method" id="payment_method"
													value="payco" />페이코
											</div>

										</fieldset>
									</div>
								</form>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<%@ include file="/footer.html"%>
	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
</body>
</html>