<%@page import="model.BasketDTO"%>
<%@page import="model.PublisherDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	BasketDTO basket = (BasketDTO) request.getAttribute("BASKET");

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
	<form method="post" id="formBasket" action="/AspireStore/orderform.aspire">
		<div>
			<div>
				<table class="table" id="tableBasketList">
					<thead>
						<tr>
							<th>
								<button type="button" id="btnCheck" onclick="checkAllCheckBox()">모두 선택</button>
							</th>
							<th>도서 명/저자/출판사</th>
							<th>판매가</th>
							<th>수량</th>
							<th>합계 금액</th>
							<th>처리</th>
						</tr>
					</thead>
					<tbody id="bookDataTBody">

						<c:if test="${not empty pageScope.basketData}">

							<c:forEach var="book" items="${pageScope.basketData.books}" varStatus="status">
								<tr>
									<td>
										<input type="checkbox" id="checkBoxCode" name="checkBoxCode" value="${book.item_code}">
										<input type="hidden" id="checkBoxCcode[]" name="checkBoxCcode[]" value="${book.item_category_code}">
									</td>
									<td>
										<span>
											<img src="..." alt="이미지 없음">
										</span>
										<span>
											<a href="/AspireStore/items/item.aspire?ccode=${book.item_category_code}&icode=${book.item_code}">
												<c:out value="${book.item_name}" />
											</a>
											&nbsp;
											<c:out value="${book.item_category_desc }"/>
											&nbsp;
											<c:out value="[${book.item_publisher_name}]" />
										</span>
										<input type="hidden" id="bookCategoryCodes[]" name="bookCategoryCodes[]" value="${book.item_category_code}">
										<input type="hidden" id="bookCodes[]" name="bookCodes[]" value="${book.item_code}">
									</td>
									<td>
										<c:out value="${book.item_selling_price}" />
									</td>
									<td>
										<c:out value="${book.order_quantity}" />
									</td>
									<td>
										<c:out value="${book.item_selling_price * book.order_quantity}" />
									</td>
									<td>
										<div>
											<div>
												<button type="button" id="btnOrderInstantly" name="btnOrderInstantly" onclick="javascript:orderBook('${book.item_code}','${book.item_category_code}')">주문</button>
											</div>
											<div>
												<button type="button" id="btnRemoveBook" name="btnRemoveBook" onclick="javascript:removeBook('${book.item_code}','${book.item_category_code}','${status.index}')">삭제</button>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>

							<input type="hidden" id="type" name="type" value="BASKET_ORDER">
						</c:if>
					</tbody>
				</table>

			</div>

			<div>
				<span>
					<button type="button" id="btnRemoveBooks" name="btnRemoveBooks" onclick="javascript:removeBooks()">도서 삭제</button>
				</span>
			</div>

			<hr>

			<div>
				<span>
					<b>총 도서 금액</b> : <b id="totalPrice"></b>

				</span>
				|
				<span>
					<b>총 할인 금액</b> : <b id="totalDiscount"></b>
				</span>
				|
				<span>
					<b>최종 결제 금액</b> : <b id="finalTotalPrice"></b>
				</span>
			</div>

			<hr>

			<div>
				<span>
					<button type="button" id="btnOrder" name="btnOrder" onclick="javascript:orderBooks()">주문</button>
				</span>
			</div>

		</div>
	</form>

	<jsp:include page="/footer.html" />

	<script src="jquery/jquery.js"></script>
	<script src="js/bootstrap.bundle.js"></script>

	<script>
		function getTotalPrice()
		{
			const tableBasket = document.getElementById('tableBasketList');
			const rowLength = tableBasket.rows.length;
			var totalPrice = 0;

			for (var idx = 1; idx < rowLength; ++idx)
			{
				var price = Number(tableBasket.rows[idx].cells[2].outerText);
				var quantity = Number(tableBasket.rows[idx].cells[3].outerText);
				totalPrice += (price * quantity);
			}
			return totalPrice;
		}

		function getTotalDiscount()
		{
			return 0;
		}

		function getFinalTotalPrice()
		{
			return getTotalPrice() - getTotalDiscount();
		}

		(function()
		{
			document.getElementById('totalPrice').innerHTML = getTotalPrice();
			document.getElementById('totalDiscount').innerHTML = getTotalDiscount();
			document.getElementById('finalTotalPrice').innerHTML = getFinalTotalPrice();
		})()

		function removeBooks()
		{
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function()
			{
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200)
				{
					var data = document.getElementById('bookDataTBody');
					var indexes = getIndexes();
					for (var idx = 0; idx < indexes.length; ++idx)
					{
						data.deleteRow(indexes[idx]);
					}
				}
			};
			var checkBoxCode = document.getElementsByName('checkBoxCode');
			var checkBoxCcode = document.getElementsByName('checkBoxCcode[]');

			var itemCodes = new Array();
			var categoryCodes = new Array();
			var dataToBeSended = '';

			for (var idx = 0; idx < checkBoxCode.length; ++idx)
			{
				if (checkBoxCode[idx].checked == true)
				{
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

		function getIndexes()
		{
			var checkBox = document.getElementsByName('checkBoxCode');
			var indexes = new Array();

			for (var index = checkBox.length - 1; index >= 0; --index)
			{
				if (checkBox[index].checked == true)
				{
					indexes.push(index);
				}
			}
			return indexes;
		}

		function checkAllCheckBox()
		{
			var checkBox = document.getElementsByName('checkBoxCode');

			for (var index = 0; index < checkBox.length; ++index)
			{
				checkBox[index].checked = true;
			}
			var btn = document.getElementById('btnCheck');
			btn.setAttribute('onclick', 'javascript:unCheckAllCheckBox()');
		}

		function unCheckAllCheckBox()
		{
			var checkBox = document.getElementsByName('checkBoxCode');

			for (var index = 0; index < checkBox.length; ++index)
			{
				checkBox[index].checked = false;
			}
			var btn = document.getElementById('btnCheck');
			btn.setAttribute('onclick', 'javascript:checkAllCheckBox()');
		}

		function orderBooks()
		{
			var form = document.getElementById('formBasket');

			var checkBoxCode = document.getElementsByName('checkBoxCode');
			var checkBoxCcode = document.getElementsByName('checkBoxCcode[]');

			if (checkBoxCode.length == 1)
			{
				if (checkBoxCode[0].checked == false)
				{
					form.elements['bookCodes[]'][0].disabled = true;
					form.elements['bookCategoryCodes[]'][0].disabled = true;
				}
			} else
			{
				for (var idx = 0; idx < checkBoxCode.length; ++idx)
				{
					if (checkBoxCode[idx].checked == false)
					{
						form.elements['bookCodes[]'][idx].disabled = true;
						form.elements['bookCategoryCodes[]'][idx].disabled = true;
					}
				}
			}
			form.submit();
		}

		function orderBook(bookCode, categoryCode)
		{
			var form = document.getElementById('formBasket');

			var checkBoxCode = document.getElementsByName('checkBoxCode');
			var checkBoxCcode = document.getElementsByName('checkBoxCcode[]');

			if (checkBoxCode.length == 1)
			{
				checkBoxCode[0].checked = true;
			} else
			{
				for (var idx = 0; idx < checkBoxCode.length; ++idx)
				{
					if ((form.elements['bookCodes[]'][idx].value == bookCode)
							&& (form.elements['bookCategoryCodes[]'][idx].value == categoryCode))
					{
						checkBoxCode[idx].checked = true;
					} else
					{
						form.elements['bookCodes[]'][idx].disabled = true;
						form.elements['bookCategoryCodes[]'][idx].disabled = true;
						checkBoxCode[idx].checked = false;
					}
				}
			}
			form.submit();
		}

		function removeBook(bookCode, categoryCode, index)
		{
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function()
			{
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200)
				{
					var data = document.getElementById('bookDataTBody');
					data.deleteRow(index);
				}
			};
			var checkBoxCode = document.getElementsByName('checkBoxCode');
			var checkBoxCcode = document.getElementsByName('checkBoxCcode[]');

			var itemCodes = new Array();
			var categoryCodes = new Array();
			var dataToBeSended = 'itemCodes=' + bookCode + '&categoryCodes='
					+ categoryCode;

			for (var idx = 0; idx < checkBoxCode.length; ++idx)
			{
				if (checkBoxCode[idx].checked == true)
				{
					checkBoxCode[idx].checked = false;
				}
			}
			checkBoxCode[index].checked = true;

			dataToBeSended += '&type=DELETE';

			xhttp.open('POST', '/AspireStore/basket.aspire', true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhttp.send(dataToBeSended);
		}
	</script>
</body>
</html>