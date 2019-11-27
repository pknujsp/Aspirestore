<%@page import="model.FileDTO"%>
<%@page import="model.PublisherDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	ItemsDTO book = (ItemsDTO) request.getAttribute("BOOK");
	FileDTO mainImg = (FileDTO) request.getAttribute("MAIN_IMAGE");
	FileDTO infoImg = (FileDTO) request.getAttribute("INFO_IMAGE");

	pageContext.setAttribute("MAIN_IMAGE", mainImg);
	pageContext.setAttribute("INFO_IMAGE", infoImg);

	pageContext.setAttribute("ITEM", book);
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title><%=book.getItem_name()%></title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">
<link href="/AspireStore/css/pageSetting.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="../management_navbar.jsp"></jsp:include>

	<div class="container border border-info">
		<div>
			<span>
				<img src="/imgfolder/itemImages/${pageScope.MAIN_IMAGE.file_name }" alt="No Image" width="400px" />
			</span>

		</div>
		<div>
			<h5>${pageScope.ITEM.item_name}</h5>
		</div>
		<hr />
		<span>
			<c:forEach var="author" items="${pageScope.ITEM.authors}" varStatus="status">
				<a href="/AspireStore/author/authorInfo.aspire?acode=${author.author_code }">${author.author_name }</a>&nbsp;
									</c:forEach>
			|&nbsp;
			<a href="#" target="_blank">${pageScope.ITEM.item_publisher_name}</a>
			&nbsp;|&nbsp;${pageScope.ITEM.item_publication_date}
		</span>

		<hr>
		<div>
			<table>
				<tbody>
					<tr>
						<th scope="row">정가</th>
						<td>
							<span>
								<em>${pageScope.ITEM.item_fixed_price} 원</em>
							</span>
						</td>
					</tr>

					<tr>
						<th scope="row">판매가</th>
						<td>
							<span>
								<em>${pageScope.ITEM.item_selling_price} 원</em>
							</span>
						</td>
					</tr>
				</tbody>
			</table>

		</div>
		<hr />
		<div>
			<form method="post" id="itemInfoForm" name="itemInfoForm">
				<span>
					수량
					<input type="number" name="quantity" id="quantity" value="1" min="1" />
					<input type="hidden" name="itemPrice" id="itemPrice" value="${pageScope.ITEM.item_selling_price}" />
					<input type="hidden" name="itemCategory" id="itemCategory" value="${pageScope.ITEM.item_category_code}" />
					<input type="hidden" name="itemCode" id="itemCode" value="${pageScope.ITEM.item_code}" />
				</span>
				<span>
					<button class="btn btn-primary" type="button" onclick="javascript:addBookToTheBasket('/AspireStore/basket.aspire')">장바구니에 추가</button>
				</span>
				<span>
					<input type="submit" class="btn btn-primary" onclick="javascript:clickButton('/AspireStore/orderform.aspire')" value="바로 구매" />
				</span>
				<input type="hidden" id="type" name="type" value="ONE_ORDER">
			</form>
		</div>
		<hr>
		<div>
			<div>
				<h5>도서 기본 정보</h5>
			</div>
			<div>
				<div>
					<table class="table sfont">
						<tbody class="b_size">
							<tr>
								<th scope="row">출간일</th>
								<td>${pageScope.ITEM.item_publication_date}</td>
							</tr>
							<tr>
								<th scope="row">쪽수, 무게, 크기</th>
								<td>${pageScope.ITEM.item_page_number}&nbsp;|&nbsp;${pageScope.ITEM.item_weight}&nbsp;|&nbsp;${pageScope.ITEM.item_size}</td>
							</tr>
							<tr>
								<th scope="row">ISBN13</th>
								<td>${pageScope.ITEM.item_isbn13}</td>
							</tr>
							<tr>
								<th scope="row">ISBN10</th>
								<td>${pageScope.ITEM.item_isbn10}</td>
							</tr>
					</table>
				</div>
			</div>

		</div>
		<hr />
		<div>
			<div>
				<h5>도서 소개</h5>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-line; text-align: left;">
					${pageScope.ITEM.item_book_introduction}
					</pre>
				</div>
			</div>

		</div>
		<hr />
		<div>
			<div>
				<h5>목차</h5>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-line; text-align: left;">${pageScope.ITEM.item_contents_table}
					</pre>
				</div>
			</div>
		</div>
		<hr />
		<div>
			<div>
				<h5>상세 정보(이미지)</h5>
			</div>
			<div>
				<div>
					<img src="/imgfolder/itemImages/${pageScope.INFO_IMAGE.file_name }" alt="No Image" width="100%" />
				</div>
			</div>
		</div>
		<hr />
		<div>
			<h5>저자 정보</h5>
			<ul style="list-style: none;">
				<c:forEach var="author" items="${pageScope.ITEM.authors}" varStatus="status">
					<li>
						<div>
							<a href="/AspireStore/author/authorInfo.aspire?acode=${author.author_code }">${author.author_name}</a>
						</div>
						<div>
							<pre style="white-space: normal; text-align: left;">${author.author_information }</pre>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<hr />
		<div>
			<div>

				<table>
					<tr>
						<td>
							<h5>출판사 리뷰</h5>
						</td>
					</tr>
					<tr>
						<td>
							<pre style="white-space: pre-line; text-align: left;">
								<c:out value="${pageScope.ITEM.item_publisher_review}" />
					
						</pre>
						</td>
					</tr>
				</table>



			</div>
		</div>
	</div>

	<%@ include file="/footer.html"%>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>
	<script>
		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	</script>
</body>
</html>