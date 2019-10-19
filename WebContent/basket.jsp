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

	<div>
		<div>
			<table>
				<thead>
					<tr>
						<th><button type="button">모두 선택</button></th>
						<th>도서 명/저자/출판사</th>
						<th>판매가</th>
						<th>수량</th>
						<th>합계 금액</th>
						<th>처리</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty pageScope.basketData}">
						<c:forEach var="book" items="${pageScope.bookData}"
							varStatus="status">
							<tr>
								<td><input type="checkbox" id="checkBoxBook"
									name="checkBoxBook" value="${book.item_code}"><input
									type="hidden" name="checkedCcode[]"
									value="${book.item_category_code}"></td>
								<td><span><img src="..." alt="이미지 없음"> </span><span><a
										href="/AspireStore/items/item.aspire?ccode=${book.item_category_code}&icode=${book.item_code}"><c:out
												value="${book.item_name}" /></a>&nbsp;<c:out
											value="[${pageScope.authorData[status.index].author_name}]" />&nbsp;<c:out
											value="[${pageScope.publisherData[status.index].publisher_name}]" /></span></td>
								<td><c:out value="${book.item_selling_price}" /></td>
								<td><c:out value="${book.quantity}" /></td>
								<td><c:out value="${book.total_price}" /></td>
								<td><div>
										<div>
											<button type="button" id="btnOrderInstantly"
												name="btnOrderInstantly" onclick="javascript:orderBook()">주문</button>
										</div>
										<div>
											<button type="button" id="btnRemoveBook"
												name="bbtnRemoveBook"
												onclick="javascript:removeBook('${status.index}','${book.ccode }','${book.icode }')">삭제</button>
										</div>
									</div></td>
							</tr>
						</c:forEach>
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
			<span> <b>총 도서 금액</b><br> <c:out
					value="${pageScope.totalPrice}" />
			</span> <span> <b>총 할인 금액</b><br> <c:out
					value="${pageScope.totalDiscount}" />
			</span> <span> <b>최종 결제 금액</b><br> <c:out
					value="${pageScope.finalTotalPrice}" />
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
</body>
</html>