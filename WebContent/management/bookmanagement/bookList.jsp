<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// 매니저의 아이디를 page저장소에 저징하여 사용한다.
	//pageContext.setAttribute("MANAGER_ID", (String)session.getAttribute("SESSIONKEY"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 관리</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">

</head>
<body>
	<div class="d-flex" id="wrapper">
		<div class="bg-light border-right" id="sidebar-wrapper">
			<!-- <div class="sidebar-heading">Start Bootstrap</div> -->
			<div class="list-group list-group-flush">
				<a href="#" class="list-group-item list-group-item-action bg-light">도서 관리</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">도서 재고</a>
			</div>
		</div>

		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>

			<div class="container-fluid">
				<table class="table table-sm table-hover">
					<thead class="thead-light">
						<tr>
							<th colspan="5">
								<h5>
									도서 목록&nbsp;
									<input type="button" id="viewButton" onclick="setDataTable()" value="새로고침">
								</h5>
							</th>
							<th colspan="8">
								표시할 데이터 개수 : <select class="custom-select custom-select-sm w-25" id="select_menu">
									<option value="2">2</option>
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="50">50</option>
								</select> &nbsp;
								<input type="button" id="viewButton" onclick="setDataTable()" value="도서 조회">
							</th>
						</tr>
						<tr>
							<th scope="col">
								<input type="checkbox" id="checkBoxButton" onclick="selectAllCheckBox()">
							</th>
							<th scope="col">코드</th>
							<th scope="col">카테고리</th>
							<th scope="col">도서 명</th>
							<th scope="col">저자</th>
							<th scope="col">출판사</th>
							<th scope="col">판매가</th>
							<th scope="col">재고</th>
							<th scope="col">출간 날짜</th>
							<th scope="col">자세히</th>
							<th scope="col">처리</th>
						</tr>
					</thead>
					<tbody id="tableBody">

					</tbody>
				</table>

				<nav aria-label="PaginationBar">
					<ul class="pagination justify-content-center" id="pagination_ul">

					</ul>
				</nav>

			</div>
		</div>
	</div>


	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		var bookList = [];

		var pageData =
		{
			'total_record' : 0,
			'num_per_page' : 5,
			'page_per_block' : 5,
			'total_page' : 0,
			'total_block' : 0,
			'current_page' : 1,
			'current_block' : 1,
			'begin_index' : 0,
			'end_index' : 5,
			'list_size' : 0
		};

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function setTable(bookData)
		{
			let tableBody = document.getElementById('tableBody');
			let index = tableBody.rows.length;
			let newRow = tableBody.insertRow(index);

			const bookObj =
			{
				'book_code' : bookData.BOOK.BOOK_CODE,
				'book_category_code' : bookData.BOOK.CATEGORY_CODE,
				'book_category_desc' : bookData.BOOK.CATEGORY_DESC,
				'book_name' : bookData.BOOK.BOOK_NAME,
				'author_code' : bookData.BOOK.AUTHOR_CODE,
				'author_name' : bookData.BOOK.AUTHOR_NAME,
				'publisher_code' : bookData.BOOK.PUBLISHER_CODE,
				'publisher_name' : bookData.BOOK.PUBLISHER_NAME,
				'selling_price' : bookData.BOOK.SELLING_PRICE,
				'current_stock' : bookData.BOOK.STOCK,
				'publication_date' : bookData.BOOK.PUB_DATE
			};
			bookList.push(bookObj);

			let bookCodeCol = newRow.insertCell(0);
			let bookCategoryCol = newRow.insertCell(1);
			let bookNameCol = newRow.insertCell(2);
			let authorCol = newRow.insertCell(3);
			let publisherCol = newRow.insertCell(4);
			let priceCol = newRow.insertCell(5);
			let stockCol = newRow.insertCell(6);
			let pubDateCol = newRow.insertCell(7);
			let moreCol = newRow.insertCell(8);
			let processingCol = newRow.insertCell(9);

			bookCodeCol.innerText = bookObj['book_code'];
			bookCategoryCol.innerText = bookObj['book_category_desc'] + '('
					+ bookObj['book_category_code'] + ')';
			bookNameCol.innerText = bookObj['book_name'];
			authorCol.innerText = bookObj['author_name'] + '('
					+ bookObj['author_code'] + ')';
			publisherCol.innerText = bookObj['publisher_name'] + '('
					+ bookObj['publisher_code'] + ')';
			priceCol.innerText = bookObj['selling_price'];
			stockCol.innerText = bookObj['current_stock'];
			pubDateCol.innerText = bookObj['publication_date'];

			let moreBtn = document.createElement('input');

			moreBtn.setAttribute('type', 'button');
			moreBtn.setAttribute('class', 'btn btn-primary');
			moreBtn.setAttribute('onclick', '');
			moreBtn.setAttribute('value', '자세히');
			moreCol.appendChild(moreBtn);

			let modificationBtn = document.createElement('input');

			modificationBtn.setAttribute('type', 'button');
			modificationBtn.setAttribute('class', 'btn btn-primary');
			modificationBtn.setAttribute('onclick', '');
			modificationBtn.setAttribute('value', '수정');
			processingCol.appendChild(modificationBtn);
		}
	</script>
</body>
</html>