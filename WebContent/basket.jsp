<%@page import="model.BasketDTO"%>
<%@page import="model.PublisherDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> books = (ArrayList<ItemsDTO>) request.getAttribute("ITEMS");
	@SuppressWarnings("unchecked")
	ArrayList<AuthorDTO> authors = (ArrayList<AuthorDTO>) request.getAttribute("AUTHORS");
	@SuppressWarnings("unchecked")
	ArrayList<PublisherDTO> publishers = (ArrayList<PublisherDTO>) request.getAttribute("PUBLISHERS");
	@SuppressWarnings("unchecked")
	ArrayList<BasketDTO> basket = (ArrayList<BasketDTO>) request.getAttribute("BASKET");

	pageContext.setAttribute("bookData", books);
	pageContext.setAttribute("authorData", authors);
	pageContext.setAttribute("publisherData", publishers);
	pageContext.setAttribute("basketData", basket);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />
	<h5 style="text-align: center">장바구니</h5>
	<div>
		<div>
			<table class="table" id="tableBasketList">
				<thead>
					<tr>
						<th><button type="button" onclick="checkAllCheckBox()">모두
								선택</button></th>
						<th>도서 명/저자/출판사</th>
						<th>판매가</th>
						<th>수량</th>
						<th>합계 금액</th>
						<th>처리</th>
					</tr>
				</thead>
				<tbody id="bookDataTBody">

					<c:if test="${not empty pageScope.basketData}">

						<c:forEach var="book" items="${pageScope.bookData}"
							varStatus="status">
							<tr>
								<td><input type="checkbox" id="checkBoxCode"
									name="checkBoxCode" value="${book.item_code}"><input
									type="hidden" id="checkBoxCcode[]" name="checkBoxCcode[]"
									value="${book.item_category_code}"></td>
								<td><span><img src="..." alt="이미지 없음"> </span><span><a
										href="/AspireStore/items/item.aspire?ccode=${book.item_category_code}&icode=${book.item_code}"><c:out
												value="${book.item_name}" /></a>&nbsp;<c:out
											value="[${pageScope.authorData[status.index].author_name}]" />&nbsp;<c:out
											value="[${pageScope.publisherData[status.index].publisher_name}]" /></span></td>
								<td><c:out value="${book.item_selling_price}" /></td>
								<td><c:out
										value="${pageScope.basketData[status.index].quantity}" /></td>
								<td><c:out
										value="${book.item_selling_price * pageScope.basketData[status.index].quantity}" /></td>
								<td><div>
										<div>
											<button type="button" id="btnOrderInstantly"
												name="btnOrderInstantly" onclick="javascript:orderBooks()">주문</button>
										</div>
										<div>
											<button type="button" id="btnRemoveBook" name="btnRemoveBook"
												onclick="javascript:removeBooks()">삭제</button>
										</div>
									</div></td>
							</tr>
						</c:forEach>
						
						<form method="post" id="formBasket" action="/AspireStore/orderform.aspire">
							<input type="hidden" id="type" name="type" value="BASKET_ORDER">
						</form>
						<!-- 
						<form action="post" id="formBasket" action="/AspireStore/orderform.aspire">
							<input type="hidden" id="categoryCode[]" name="categoryCode[]" value="${book.item_category_code}">
							<input type="hidden" id="itemCode[]" name="itemCode[]" value="${book.item_code}">
							<input type="hidden" id="quantity[]" name="quantity[]" value="${pageScope.basketData[status.index].quantity}">
							<input type="hidden" id="sellingPrice[]" name="sellingPrice[]" value="${book.item_selling_price}">
						</form>
						-->
						
					</c:if>

				</tbody>
			</table>

		</div>

		<div>
			<span><button type="button" id="btnRemoveBooks"
					name="btnRemoveBooks" onclick="javascript:removeBooks()">도서
					삭제</button></span>
		</div>

		<hr>

		<div>
			<span> <b>총 도서 금액</b> : <b id="totalPrice"></b>

			</span> | <span> <b>총 할인 금액</b> : <b id="totalDiscount"></b>
			</span> | <span> <b>최종 결제 금액</b> : <b id="finalTotalPrice"></b>
			</span>
		</div>

		<hr>

		<div>
			<span><button type="button" id="btnOrder" name="btnOrder"
					onclick="javascript:orderBooks()">주문</button></span>
		</div>

	</div>

	<jsp:include page="/footer.html" />

	<script src="jquery/jquery.js"></script>
	<script src="js/bootstrap.bundle.js"></script>

	<script>
		function getTotalPrice() {
			const tableBasket = document.getElementById('tableBasketList');
			const rowLength = tableBasket.rows.length;
			var totalPrice = 0;

			for (var idx = 1; idx < rowLength; ++idx) {
				var price = Number(tableBasket.rows[idx].cells[2].outerText);
				var quantity = Number(tableBasket.rows[idx].cells[3].outerText);
				totalPrice += (price * quantity);
			}
			return totalPrice;
		}

		function getTotalDiscount() {
			return 0;
		}

		function getFinalTotalPrice() {
			return getTotalPrice() - getTotalDiscount();
		}

		(function() {
			document.getElementById('totalPrice').innerHTML = getTotalPrice();
			document.getElementById('totalDiscount').innerHTML = getTotalDiscount();
			document.getElementById('finalTotalPrice').innerHTML = getFinalTotalPrice();
		})()

		function removeBooks() {
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200) {
					var data = document.getElementById('bookDataTBody');
					var indexes = getIndexes();
					for (var idx = 0; idx < indexes.length; ++idx) {
						data.deleteRow(indexes[idx]);
					}
				}
			};
			var checkBoxCode = document.getElementsByName('checkBoxCode');
			var checkBoxCcode = document.getElementsByName('checkBoxCcode[]');

			var itemCodes = new Array();
			var categoryCodes = new Array();
			var dataToBeSended = '';

			for (var idx = 0; idx < checkBoxCode.length; ++idx) {
				if (checkBoxCode[idx].checked == true) {
					itemCodes.push(checkBoxCode[idx].value);
					categoryCodes.push(checkBoxCcode[idx].value);
					dataToBeSended += 'itemCodes='
							+ itemCodes[itemCodes.length - 1]
							+ '&categoryCodes='
							+ categoryCodes[itemCodes.length - 1] + '&';
				}
			}
			dataToBeSended += 'type=DELETE';

			xhttp.open('POST', '/AspireStore/basket.aspire', true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhttp.send(dataToBeSended);
		}

		function getIndexes() {
			var checkBox = document.getElementsByName('checkBoxCode');
			var indexes = new Array();

			for (var index = checkBox.length - 1; index >= 0; --index) {
				if (checkBox[index].checked == true) {
					indexes.push(index);
				}
			}
			return indexes;
		}

		function checkAllCheckBox() {
			var checkBox = document.getElementsByName('checkBoxCode');

			for (var index = 0; index < checkBox.length; ++index) {
				checkBox[index].checked = true;
			}
		}

		function orderBooks() {
			var form = document.getElementById('formBasket');
			form.submit();
		}
	</script>
</body>
</html>