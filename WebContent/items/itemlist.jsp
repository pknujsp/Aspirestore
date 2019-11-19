<%@page import="java.util.HashMap"%>
<%@page import="model.FileDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");

	@SuppressWarnings("unchecked")
	ArrayList<ItemsDTO> itemList = (ArrayList<ItemsDTO>) request.getAttribute("BOOKLIST");
	@SuppressWarnings("unchecked")
	ArrayList<FileDTO> thumbnails = (ArrayList<FileDTO>) request.getAttribute("THUMBNAILS");
	@SuppressWarnings("unchecked")
	HashMap<String, Integer> pageData = (HashMap<String, Integer>) request.getAttribute("PAGE_DATA");
	String ccode = request.getAttribute("CCODE").toString();
	String cpcode = request.getAttribute("CPCODE").toString();
	String sortType = request.getAttribute("SORT_TYPE").toString();

	pageContext.setAttribute("THUMBNAILS", thumbnails);
	pageContext.setAttribute("BOOKLIST", itemList);
	pageContext.setAttribute("PAGE_DATA", pageData);
	pageContext.setAttribute("CCODE", ccode);
	pageContext.setAttribute("CPCODE", cpcode);
	pageContext.setAttribute("SORT_TYPE", sortType);
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>상품 목록</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>

	<jsp:include page="/navbar.jsp"></jsp:include>
	<br>

	<div class="container border border-info" align="center">
		<table>
			<tr>
				<td>
					<h6>월간 인기 순위</h6>
				</td>
			</tr>
		</table>
	</div>

	<br>

	<div class="container" align="center">
		<!-- 책 정보 테이블 -->
		<div align="left">
			<span>
				<em>정렬</em>&ensp;
				<a href="javascript:sortList('PUB_DATE_DESC')">출간일 순</a>
				&ensp;
				<a href="javascript:sortList('BEST')">판매량 순</a>
				&ensp;
				<a href="javascript:sortList('PRICE_DESC')">높은 가격 순</a>
				&ensp;
				<a href="javascript:sortList('PRICE_ASC')">낮은 가격 순</a>
			</span>
		</div>
		<ul style="list-style: none; padding: 2px;">

			<c:forEach var="book" items="${pageScope.BOOKLIST}" varStatus="status">
				<li>
					<table class="table table-bordered">
						<tr>
							<td style="width: 20%; text-align: center;">
								<c:if test="${pageScope.THUMBNAILS[status.index] != null }">
									<img class="card-img-top" src="/imgfolder/itemImages/${pageScope.THUMBNAILS[status.index].file_name }" class="card-img" alt="이미지 없음" width="100px" />
								</c:if>
								<c:if test="${pageScope.THUMBNAILS[status.index] == null }">
									<img class="img-fluid" height="100px" src="" class="card-img" alt="이미지 없음">
								</c:if>
							</td>
							<td style="width: 60%; padding: 10px; text-align: left;">

								<a href="/AspireStore/items/item.aspire?ccode=${book.item_category_code }&icode=${book.item_code }" id="book_name">
									<span style="font: bold; font-family: Arial; font-weight: 800; font-size: large">${book.item_name }</span>
								</a>

								<br>

								<span style="font: bold; font-family: Arial; font-weight: 400; font-size: small; color: gray;">${book.item_author_name } | ${book.item_publisher_name } | ${book.item_publication_date } </span>

								<hr>

								<table>
									<tr>
										<td>
											${book.item_book_introduction }
											<hr>
											가격 : ${book.item_selling_price }원 | 평점 : ${book.item_rating }/5
										</td>
									</tr>
								</table>
							</td>
							<td style="width: 20%; padding: 10px; text-align: center;">
								<label for="quantity">수량</label>
								<input type="number" name="quantity${status.index }" id="quantity${status.index }" value="1" min="1">
								<br>
								<br>
								<input type="button" class="btn btn-primary" onclick="javascript:addBookToTheBasket('${book.item_code }','${book.item_category_code }','quantity${status.index }')" value="장바구니에 추가">

								<br>
								<br>

								<input type="button" class="btn btn-primary" onclick="javascript:immediatelyBuy('${book.item_code }','${book.item_category_code }','quantity${status.index }','${book.item_selling_price }')" value="바로 구매" />
							</td>
						</tr>
					</table>
				</li>
			</c:forEach>
		</ul>

		<nav aria-label="PaginationBar">
			<ul class="pagination justify-content-center" id="pagination_ul">
				<c:set var="pageBegin" value="${((pageScope.PAGE_DATA['current_block'] - 1) * pageScope.PAGE_DATA['page_per_block']) + 1}" />
				<c:set var="pageEnd" value="${((pageBegin + pageScope.PAGE_DATA['page_per_block']) <= pageScope.PAGE_DATA['total_page']) ? (pageBegin + pageScope.PAGE_DATA['page_per_block'])
					: pageScope.PAGE_DATA['total_page'] + 1 }" />
				<c:set var="totalPage" value="${pageScope.PAGE_DATA['total_page']}" />
				<c:set var="totalBlock" value="${pageScope.PAGE_DATA['total_block']}" />
				<c:set var="currentBlock" value="${pageScope.PAGE_DATA['current_block']}" />
				<c:set var="currentPage" value="${pageScope.PAGE_DATA['current_page']}" />

				<c:if test="${totalPage != 0 }">
					<c:if test="${currentBlock > 1 }">
						<%-- 이전버튼 --%>
						<li class="page-item">
							<a class="page-link" href="javascript:moveBlock('${ currentBlock - 1}')" tabindex="-1" aria-disabled="true">이전</a>
						</li>
					</c:if>

					<c:forEach begin="${pageBegin }" end="${pageEnd - 1 }" step="1" varStatus="status">
						<c:choose>
							<c:when test="${ pageBegin == currentPage }">
								<li class="page-item active" aria-current="page">
									<a class="page-link" href="javascript:paging('${ pageBegin }')">${ pageBegin }
										<span class="sr-only">(현재 페이지)</span>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="javascript:paging('${ pageBegin }')">${ pageBegin }</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:set var="pageBegin" value="${pageBegin+1}" />
					</c:forEach>
					<c:if test="${totalBlock > currentBlock }">
						<li class="page-item">
							<a class="page-link" href="javascript:moveBlock('${ currentBlock + 1}')">다음</a>
						</li>
					</c:if>
				</c:if>
			</ul>
		</nav>

		<form action="/AspireStore/items/itemlist.aspire?" method="get" id="pagination_form" name="pagination_form">
			<input type="hidden" name="c_page" id="c_page" value="${pageScope.PAGE_DATA['current_page']}">
			<input type="hidden" name="ccode" id="ccode" value="${pageScope.CCODE }">
			<input type="hidden" name="cpcode" id="cpcode" value="${pageScope.CPCODE }">
			<input type="hidden" name="sort_type" id="sort_type" value="${pageScope.SORT_TYPE }">
		</form>

	</div>
	<%@ include file="/footer.html"%>

	<form method="post" id="data_form" name="data_form" action="/AspireStore/orderform.aspire">
		<input type="hidden" name="quantity" id="quantity">
		<input type="hidden" name="itemCategory" id="itemCategory">
		<input type="hidden" name="itemCode" id="itemCode">
		<input type="hidden" name="itemPrice" id="itemPrice">
		<input type="hidden" id="type" name="type" value="ONE_ORDER">
	</form>

	<form action="/AspireStore/basket.aspire" id="basket_form" name="basket_form" method="post">
		<input type="hidden" id="type" name="type" value="GET_BASKET">
	</form>


	<!-- Bootstrap core JavaScript -->
	<script src="/AspireStore/jquery/jquery.min.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.min.js"></script>

	<script>
	
	function paging(num)
	{
		document.pagination_form.c_page.value = Number(num);
		document.pagination_form.submit();
	}

	function moveBlock(num)
	{
		document.pagination_form.c_page.value =  ${pageScope.PAGE_DATA.page_per_block} * (Number(num) - 1) + 1;
		document.pagination_form.submit();
	}
	
	function addBookToTheBasket(icode,ccode,quantityId)
	{
		let xhttp = new XMLHttpRequest();

		xhttp.onreadystatechange = function()
		{
			if (xhttp.readyState == XMLHttpRequest.DONE
					&& xhttp.status == 200)
			{
				var responseArr = xhttp.response;
				showDialog(responseArr[0].MESSAGE, responseArr[0].RESULT);
			}
		};
		xhttp.open('POST', '/AspireStore/basket.aspire', true);
		xhttp.setRequestHeader('Content-type',
				'application/x-www-form-urlencoded');

		xhttp.responseType = 'json';
		
		let quantity = document.getElementById(quantityId).value;
		
		xhttp.send('itemCode=' + icode + '&itemCategory=' + ccode
				+ '&type=' + 'ADD' + '&quantity=' + quantity);
	}

	function showDialog(message, result)
	{
		if (result == 'true')
		{
			var dialogMessage = confirm(message);
			if (dialogMessage)
			{
			document.basket_form.submit();
			} else
			{

			}
		} else
		{
			alert(message);
		}
	}


	function immediatelyBuy(icode,ccode,quantityId,price)
	{
		document.data_form.itemCode.value=icode;
		document.data_form.itemCategory.value=ccode;
		document.data_form.itemPrice.value=price;
		document.data_form.quantity.value=document.getElementById(quantityId).value;
	
		document.data_form.submit();
	}
	
	function sortList(sort)
	{
		document.pagination_form.sort_type.value=sort;
		document.pagination_form.submit();
	}
	</script>
</body>

</html>