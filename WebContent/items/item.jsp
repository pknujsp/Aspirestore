<%@page import="etc.OrderInformation"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	ItemsDTO item = (ItemsDTO) request.getAttribute("ITEM");
	AuthorDTO author = (AuthorDTO) request.getAttribute("AUTHOR");
	String publisherName = (String) request.getAttribute("PUBLISHER_NAME");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title><%=item.getItem_name()%></title>

<!-- Bootstrap core CSS -->
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>
	<script>
		function clickButton(uri) {
			var form = document.getElementById('itemInfoForm');
			form.setAttribute('action', uri);
			paymentForm.submit();
		}
	</script>

	<jsp:include page="/navbar.jsp"></jsp:include>
	<br>

	<div class="container border border-info">
		<div>
			<span> <img src="/AspireStore/images/ReactBookImage.jpg"
				alt="No Image" border="0" style="width: 40%; height: auto;" /></span>

		</div>
		<div>
			<h4><%=item.getItem_name()%></h4>
		</div>
		<hr />
		<span> <span><a href="#" target="_blank"><%=author.getAuthor_name()%></a></span>
			<em>|</em> <span><a href="#" target="_blank"><%=publisherName%></a></span>
			<em>|</em> <span><%=item.getItem_publication_date()%></span>
		</span>


		<hr />
		<div>
			<table>
				<colgroup>
					<col width="110" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">정가</th>
						<td><span><em><%=item.getItem_fixed_price()%> 원</em></span></td>
					</tr>

					<tr>
						<th scope="row">판매가</th>
						<td><span><em><%=item.getItem_selling_price()%> 원</em></span></td>
					</tr>
				</tbody>
			</table>

		</div>
		<hr />
		<div>

			<form method="post" id="itemInfoForm">

				<span> <input type="number" name="quantity" id="quantity"
					value="1" min="1" /> <input type="hidden" name="itemPrice"
					id="itemPrice" value="<%=item.getItem_selling_price()%>" /> <input
					type="hidden" name="itemCategory" id="itemCategory"
					value="<%=item.getItem_category_code()%>" /> <input type="hidden"
					name="itemCode" id="itemPrice" value="<%=item.getItem_code()%>" />
				</span> <span> <input type="submit" class="btn btn-primary"
					onclick="javascript:clickButton('/AspireStore/cart.aspire')"
					role="button" value="장바구니에 추가" />
				</span> <span> <input type="submit" class="btn btn-primary"
					onclick="javascript:clickButton('/AspireStore/orderform.aspire')"
					value="바로 구매" />
				</span>
			</form>
		</div>
		<hr />


		<div>
			<div>
				<h4>도서 기본 정보</h4>
			</div>
			<div>
				<div>
					<table class="table">

						<colgroup>
							<col width="170">
							<col width="*">
						</colgroup>
						<tbody class="b_size">
							<tr>
								<th scope="row">출간일</th>
								<td><%=item.getItem_publication_date()%></td>
							</tr>
							<tr>
								<th scope="row">쪽수, 무게, 크기</th>
								<td><%=item.getItem_page_number()%> , <%=item.getItem_weight()%>
									, <%=item.getItem_size()%></td>
							</tr>
							<tr>
								<th scope="row">ISBN13</th>
								<td><%=item.getItem_isbn13()%></td>
							</tr>
							<tr>
								<th scope="row">ISBN10</th>
								<td><%=item.getItem_isbn10()%></td>
							</tr>
					</table>
				</div>
			</div>

		</div>
		<hr />
		<div>
			<div>
				<h4>도서 소개</h4>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_book_introduction()%>
					</pre>
				</div>
			</div>

		</div>
		<hr />
		<div>
			<div>
				<h4>목차</h4>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_contents_table()%>
					</pre>
				</div>
			</div>
		</div>
		<hr />
		<div>
			<div>
				<h4>상세 정보(이미지)</h4>
			</div>
			<div>
				<div>
					<img src="#" border="0" alt="이미지가 없습니다." />
				</div>
			</div>
		</div>
		<hr />
		<div>
			<div>
				<h4>저자 소개</h4>
			</div>
			<div>
				<div>
					<div>
						저자 명 :
						<%=author.getAuthor_name()%>
					</div>
					<div>
						저자 소개 :
						<pre style="white-space: pre-wrap;">
						<%=author.getAuthor_information()%>
						</pre>
					</div>
				</div>
			</div>
		</div>
		<hr />
		<div>
			<div>
				<div>
					<h4>출판사 리뷰</h4>
				</div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_publisher_review()%>
					</pre>
				</div>
			</div>
		</div>
		<hr />
	</div>


	<%@ include file="/footer.html"%>

	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js">
		
	</script>
	<script src="js/bootstrap.bundle.min.js"></script>

</body>

</html>