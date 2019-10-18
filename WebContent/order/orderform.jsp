<%@page import="model.UserDTO"%>
<%@page import="model.UserDAO"%>
<%@page import="model.AddressDTO"%>
<%@page import="model.AddressDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="etc.OrderInformation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

	session.setAttribute("ORDER_LIST", orderInformations);

	AddressDAO addressDao = (AddressDAO) this.getServletContext().getAttribute("ADDRESS_DAO"); // 주소록 DAO

	UserDTO userInfo = (UserDTO) session.getAttribute("USER_INFO_SESSION");

	if (userInfo != null) {
		pageContext.setAttribute("USER_INFO", userInfo);
	}

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

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
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

		<form method="post" id="orderForm" name="orderForm"
			action="/AspireStore/orderpayment.aspire" onsubmit="return payment()">
			<div>
				<h5>주문서 작성</h5>
				<div>
					<strong>주문자 정보</strong>
					<table>
						<tr>
							<th>성명</th>
							<td><span><label> <input type="text"
										id="orderer_name" name="orderer_name"
										value="<c:out value="${pageScope.USER_INFO.user_name}"/>">
								</label></span></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>
								<p id="orderer_phone">
									<input type="text" class="text" id="orderer_mobile_1"
										name="orderer_mobile_1" maxlength="3"
										value="<c:out value="${pageScope.USER_INFO.mobile1 }" />">
									- <input type="text" class="text" id="orderer_mobile_2"
										name="orderer_mobile_2" maxlength="4"
										value="<c:out value="${pageScope.USER_INFO.mobile2 }" />">
									- <input type="text" class="text" id="orderer_mobile_3"
										name="orderer_mobile_3" maxlength="4"
										value="<c:out value="${pageScope.USER_INFO.mobile3 }" />">
								</p>
							</td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td>
								<p id="orderer_general">
									<select name="orderer_general_1_select"
										id="orderer_general_1_select">
										<option value="" selected>선택 안함</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="070">070</option>
										<option value="0502">0502</option>
										<option value="0503">0503</option>
										<option value="0505">0505</option>
										<option value="0506">0506</option>
										<option value="0507">0507</option>
										<option value="0508">0508</option>
									</select> - <input type="text" class="text" id="orderer_general_2"
										name="orderer_general_2" maxlength="4"
										value="<c:out value="${pageScope.USER_INFO.general2 }" />">
									- <input type="text" class="text" id="orderer_general_3"
										name="orderer_general_3" maxlength="4"
										value="<c:out value="${pageScope.USER_INFO.general3 }" />">
								</p>
							</td>
						</tr>
						<tr>
							<th>이메일 주소</th>
							<td><input type="email" id="orderer_email"
								name="orderer_email" /></td>
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
									<span><label><input type="radio" class="radio"
											id="delivery_method" name="delivery_method" value="1" />일반택배</label></span>
									<span><label><input type="radio" class="radio"
											id="delivery_method" name="delivery_method" value="2" />편의점
											픽업</label></span>
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
											id="recepient_name" name="recepient_name" /></label></span> <span><input
										type="button" id="setRecepientInfo" name="setRecepientInfo"
										onclick="javascript:setRecepientData()" value="주문자 정보와 동일"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<table>
						<tr>
							<th>휴대전화</th>
							<td>
								<p id="recepient_phone">
									<input type="text" class="text" id="recepient_mobile_1"
										name="recepient_mobile_1" maxlength="3" /> - <input
										type="text" class="text" id="recepient_mobile_2"
										name="recepient_mobile_2" maxlength="4" /> - <input
										type="text" class="text" id="recepient_mobile_3"
										name="recepient_mobile_3" maxlength="4" />
								</p>
							</td>
						</tr>
						<tr>
							<th>일반전화</th>
							<td>
								<p id="recepient_general">
									<select name="recepient_general_1_select"
										id="recepient_general_1_select">
										<option value="" selected>선택 안함</option>
										<option value="02">02</option>
										<option value="031">031</option>
										<option value="032">032</option>
										<option value="033">033</option>
										<option value="041">041</option>
										<option value="042">042</option>
										<option value="043">043</option>
										<option value="044">044</option>
										<option value="051">051</option>
										<option value="052">052</option>
										<option value="053">053</option>
										<option value="054">054</option>
										<option value="055">055</option>
										<option value="061">061</option>
										<option value="062">062</option>
										<option value="063">063</option>
										<option value="064">064</option>
										<option value="070">070</option>
										<option value="0502">0502</option>
										<option value="0503">0503</option>
										<option value="0505">0505</option>
										<option value="0506">0506</option>
										<option value="0507">0507</option>
										<option value="0508">0508</option>
									</select>- <input type="text" class="text" id="recepient_general_2"
										name="recepient_general_2" maxlength="4" /> - <input
										type="text" class="text" id="recepient_general_3"
										name="recepient_general_3" maxlength="4" />
								</p>
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
											value="latest_address"
											onclick="javascript:getLastestAddress()" />최근 배송지</label></span> <span><label><input
											type="radio" class="radio" name="select_address"
											id="select_address" value="address_list"
											onclick="javascript:showAddressListModal()" />주소록</label> </span> <span><label><input
											type="radio" class="radio" name="select_address"
											id="select_address" value="write_new_address"
											onclick="javascript:clearAddressCodeValue()" />신규 입력</label></span>
								</div>
							</td>
						</tr>
					</table>
				</div>

				<div>
					<table>
						<tr>
							<td><p>
									<span>우편번호 <input type="text" class="text"
										id="postal_code" name="postal_code" maxlength="5" /></span> <span><input
										type="button" name="searchAddress" id="searchAddress"
										value="주소 검색" /></span>
								</p>
								<p>
									도로명 주소 <input type="text" class="text" id="road_name_address"
										name="road_name_address" />
								</p>
								<p>
									지번 주소 <input type="text" class="text" id="number_address"
										name="number_address" />
								</p>
								<p>
									상세 주소<input type="text" class="text" id="detail_address"
										name="detail_address" /><input type="hidden"
										id="address_code" name="address_code" value="" />
								</p></td>

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
								id="payment_method" value="1" />일반 신용카드(체크카드 포함)</td>
						</tr>
						<tr>
							<th>계좌이체</th>
							<td><input type="radio" class="radio" name="payment_method"
								id="payment_method" value="2" />계좌이체 <input type="radio"
								class="radio" name="payment_method" id="payment_method"
								value="3" />무통장 입금</td>
						</tr>
						<tr>
							<th>간편결제</th>
							<td><input type="radio" class="radio" name="payment_method"
								id="payment_method" value="4" />카카오 페이 <input type="radio"
								class="radio" name="payment_method" id="payment_method"
								value="5" />페이코</td>
						</tr>
					</table>
				</div>
			</div>
			<hr>
			<div>
				<div>요청사항</div>
				<div>
					<textarea id="requested_term" name="requested_term" cols="50"
						rows="10"></textarea>
				</div>
			</div>

			<div>
				<h5>최종 결제 금액</h5>
				<div>
					<span><strong><%=totalPrice%>원</strong></span> <input type="hidden"
						id="total_price" name="total_price" value="<%=totalPrice%>" /> <span><input
						type="submit" id="payment_button" name="payment_button"
						value="결제하기" /> </span>
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
			setMergedNumber();
			document.getElementById('orderForm').submit();
		}

		function setMergedNumber() {
			document.getElementById('orderer_mobile_number').value = getMergedNumber('orderer_phone');
			document.getElementById('orderer_general_number').value = getMergedNumber('orderer_general');
			document.getElementById('recepient_mobile_number').value = getMergedNumber('recepient_phone');
			document.getElementById('recepient_general_number').value = getMergedNumber('recepient_general');
		}

		function getMergedNumber(pId) {
			let inputList = $('#' + pId + ' input[type=text]');
			let mergedNumber = '';
			$.each(inputList, function(index, value) {
				mergedNumber += $(value).val();
			});

			return mergedNumber;
		}

		function setRecepientData() {
			document.getElementById('recepient_name').value = document
					.getElementById('orderer_name').value;
			setTelNumber('recepient_phone', 'orderer_phone');
			setTelNumber('recepient_general', 'orderer_general');
			setGeneral1();
		}

		function setTelNumber(rId, oId) {
			let numberArr = new Array();
			let ordererInputList = $('#' + oId + ' input[type=text]');
			let i = 0;

			$.each(ordererInputList, function(index, value) {
				numberArr[i] = $(value).val();
				++i;
			});

			i = 0;

			let recepientInputList = $('#' + rId + ' input[type=text]');

			$.each(recepientInputList,
							function(index, value) {
								document.getElementById($(value).attr('id')).value = numberArr[i];
								++i;
							});
		}

		function setGeneral1() {
			let recepientSelectBox = document
					.getElementById('recepient_general_1_select');
			let ordererGeneral1 = document
					.getElementById('orderer_general_1_select');
			recepientSelectBox.options[ordererGeneral1.selectedIndex].selected = true;
		}

		function getLastestAddress() // ajax 이용하여 최근 사용된 주소 가져옴
		{
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200) {
					var responseArr = xhttp.response;

					setReadonlyAddressInput(true);
					document.orderForm.postal_code.value = responseArr[0].POSTAL_CODE;
					document.orderForm.road_name_address.value = responseArr[0].ROAD_NAME;
					document.orderForm.number_address.value = responseArr[0].NUMBER;
					document.orderForm.detail_address.value = responseArr[0].DETAIL;
					document.orderForm.address_code.value = responseArr[0].ADDRESS_CODE;
				}
			};

			xhttp.open('POST', '/AspireStore/addressbook.aspire', true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhttp.responseType = 'json';
			xhttp.send('ID=' + '${sessionScope.SESSIONKEY}' + '&TYPE=' + '0');
		}

		function clearAddressCodeValue() {
			setReadonlyAddressInput(false);
			document.orderForm.address_code.value = '';
		}

		function showAddressListModal() {
			setReadonlyAddressInput(true);
			let id = '${sessionScope.SESSIONKEY}';
			window.open('addressListModal.jsp?user_id=' + id, 'scrollbars=yes,width=400,height=250');
		}
		
		function setReadonlyAddressInput(status){
			document.orderForm.postal_code.readOnly = status;
			document.orderForm.road_name_address.readOnly = status;
			document.orderForm.number_address.readOnly = status;
			document.orderForm.detail_address.readOnly = status;
		}
	</script>

	<script type="text/javascript">
		(function() {
			var selectBox = document.getElementById('orderer_general_1_select');

			for (let idx = 0; idx < selectBox.options.length; ++idx) {
				if (selectBox.options[idx].value == '${pageScope.USER_INFO.general1}') {
					selectBox.options[idx].selected = true;
					break;
				}
			}
		})();
	</script>
</body>
</html>