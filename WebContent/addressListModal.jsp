<%@page import="model.AddressDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.AddressDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	AddressDAO addressDao = (AddressDAO) request.getServletContext().getAttribute("ADDRESS_DAO");
	ArrayList<AddressDTO> addressList = addressDao.getAddressList(request.getParameter("user_id"));

	pageContext.setAttribute("addressList", addressList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소록</title>
<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>


<body>
	<div>
		<div class="table">
			<table id="addressTable">
				<thead>
					<tr>
						<th>우편번호</th>
						<th>도로명 주소</th>
						<th>지번 주소</th>
						<th>상세 주소</th>
						<th>선택</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty pageScope.addressList}">
						<c:forEach var="address" items="${pageScope.addressList}"
							varStatus="status">
							<tr>
								<td><c:out value="${address.postal_code }" /></td>
								<td><c:out value="${address.road }" /></td>
								<td><c:out value="${address.number }" /></td>
								<td><c:out value="${address.detail }" /></td>
								<td><button type="button"
										onclick="javascript:selectAddress('${address.postal_code}','${address.road }','${address.number }','${address.detail }','${address.code }')">선택</button></td>
								<td><button type="button"
										onclick="javascript:deleteAddress('${status.index}','${address.user_id }','${address.code }')">삭제</button></td>
							</tr>
						</c:forEach>
					</c:if>

				</tbody>
			</table>
		</div>
		<hr>
		<div>
			<button type="button" id="closeModal"
				onclick="javascript:closeModal()">창 닫기</button>
		</div>
	</div>
	<script type="text/javascript">
		function deleteAddress(index, userId, addressCode) {
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200) {
					var table = document.getElementById('addressTable');
					table.deleteRow(index);
				}
			};
			xhttp.open('POST', '/AspireStore/addressbook.aspire', true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhttp.send('ID=' + userId + '&CODE=' + addressCode + '&TYPE='
							+ '1');
		}

		function selectAddress(postal, road, number, detail, code) {
			opener.document.orderForm.postal_code.value = postal;
			opener.document.orderForm.road_name_address.value = road;
			opener.document.orderForm.number_address.value = number;
			opener.document.orderForm.detail_address.value = detail;
			opener.document.orderForm.address_code.value = code;
			self.close();
		}

		function closeModal() {
			self.close();
		}
	</script>
</body>
</html>