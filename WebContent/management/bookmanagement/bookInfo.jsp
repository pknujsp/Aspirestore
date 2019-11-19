<%@page import="model.FileDTO"%>
<%@page import="model.PublisherDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	ItemsDTO book = (ItemsDTO) request.getAttribute("BOOK");
	AuthorDTO author = (AuthorDTO) request.getAttribute("AUTHOR");
	PublisherDTO publisher = (PublisherDTO) request.getAttribute("PUBLISHER");
	FileDTO mainImg = (FileDTO) request.getAttribute("MAIN_IMAGE");
	FileDTO infoImg = (FileDTO) request.getAttribute("INFO_IMAGE");

	pageContext.setAttribute("MAIN_IMAGE", mainImg);
	pageContext.setAttribute("INFO_IMAGE", infoImg);

	pageContext.setAttribute("BOOK", book);
	pageContext.setAttribute("AUTHOR", author);
	pageContext.setAttribute("PUBLISHER", publisher);
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

</head>
<body>
	<div class="d-flex" id="wrapper">
		<div class="bg-light border-right" id="sidebar-wrapper">
			<div class="list-group list-group-flush">
				<a href="#" class="list-group-item list-group-item-action bg-light">도서 관리</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">도서 재고</a>
			</div>
		</div>

		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>


			<div class="container border border-info">
				<div>
					<span>
						<img src="/imgfolder/itemImages/${pageScope.MAIN_IMAGE.file_name }" alt="No Image" width="400px" />
					</span>

				</div>
				<div>
					<h4><%=book.getItem_name()%></h4>
				</div>
				<hr />
				<span>
					<span>
						<a href="#" target="_blank"><%=author.getAuthor_name()%></a>
					</span>
					<em>|</em>
					<span>
						<a href="#" target="_blank"><%=publisher.getPublisher_name()%></a>
					</span>
					<em>|</em>
					<span><%=book.getItem_publication_date()%></span>
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
								<td>
									<span>
										<em><%=book.getItem_fixed_price()%> 원</em>
									</span>
								</td>
							</tr>

							<tr>
								<th scope="row">판매가</th>
								<td>
									<span>
										<em><%=book.getItem_selling_price()%> 원</em>
									</span>
								</td>
							</tr>
						</tbody>
					</table>

					<hr>
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
											<td><%=book.getItem_publication_date()%></td>
										</tr>
										<tr>
											<th scope="row">쪽수, 무게, 크기</th>
											<td><%=book.getItem_page_number()%>
												,
												<%=book.getItem_weight()%>
												,
												<%=book.getItem_size()%></td>
										</tr>
										<tr>
											<th scope="row">ISBN13</th>
											<td><%=book.getItem_isbn13()%></td>
										</tr>
										<tr>
											<th scope="row">ISBN10</th>
											<td><%=book.getItem_isbn10()%></td>
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
					<%=book.getItem_book_introduction()%>
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
					<%=book.getItem_contents_table()%>
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
								<img src="/imgfolder/itemImages/${pageScope.INFO_IMAGE.file_name }" alt="No Image" width="100%" />
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
					<%=book.getItem_publisher_review()%>
					</pre>
							</div>
						</div>
					</div>

					<hr>
				</div>
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