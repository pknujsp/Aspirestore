<%@page import="model.PublisherDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	ItemsDTO book = (ItemsDTO) request.getAttribute("BOOK");
	AuthorDTO author = (AuthorDTO) request.getAttribute("AUTHOR");
	PublisherDTO publisher = (PublisherDTO) request.getAttribute("PUBLISHER");

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

<title>${pageScope.BOOK.item_name}</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">

</head>
<body>
	<form id="modification_form" name="modification_form" action="/AspireStore/management/bookManagement.aspire" method="POST">
		<input type="hidden" id="input_item_category_code" name="input_item_category_code" value="${pageScope.BOOK.item_category_code}">
		<input type="hidden" id="input_item_code" name="input_item_code" value="${pageScope.BOOK.item_code}">
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


				<div class="container border border-info">

					<div>
						<span>
							<img src="/AspireStore/images/ReactBookImage.jpg" alt="No Image" border="0" style="width: 40%; height: auto;" />
						</span>

					</div>
					<div>
						<div class="form-group">
							<label for="input_item_name">도서 명</label>
							<input type="text" class="form-control" id="input_item_name" name="input_item_name" value="${pageScope.BOOK.item_name}" readonly="readonly">
							<input type="button" id="input_item_name_btn" onclick="unlockElement('input_item_name',this)" value="잠금 해제">
						</div>
						<hr>
						<div class="form-group">
							<label for="input_publisher">출판사</label>
							<input type="text" class="form-control" id="input_publisher" name="input_publisher" value="${pageScope.PUBLISHER.publisher_name}" readonly="readonly">
							<input type="button" id="input_publisher_btn" onclick="unlockElement('input_publisher',this)" value="잠금 해제">
						</div>

						<hr />

						<div class="form-group">
							<label for="input_fixed_price">정가</label>
							<input type="text" class="form-control" id="input_fixed_price" name="input_fixed_price" value="${pageScope.BOOK.item_fixed_price}" readonly="readonly">
							원
							<input type="button" id="input_fixed_price_btn" onclick="unlockElement('input_fixed_price',this)" value="잠금 해제">
						</div>
						<div class="form-group">
							<label for="input_selling_price">판매가</label>
							<input type="text" class="form-control" id="input_selling_price" name="input_selling_price" value="${pageScope.BOOK.item_selling_price}" readonly="readonly">
							원
							<input type="button" id="input_selling_price_btn" onclick="unlockElement('input_selling_price',this)" value="잠금 해제">
						</div>
						<hr>
						<div>
							<div>
								<h4>도서 기본 정보</h4>
							</div>
							<div>
								<div>
									<table class="table">
										<tr>
											<td>
												<div class="form-group">
													<label for="input_pub_date">출간 날짜</label>
													<input type="text" class="form-control" id="input_pub_date" name="input_pub_date" value="${pageScope.BOOK.item_publication_date}" readonly="readonly">
													<input type="button" id="input_pub_date_btn" onclick="unlockElement('input_pub_date',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="input_page_number">쪽수</label>
													<input type="text" class="form-control" id="input_page_number" name="input_page_number" value="${pageScope.BOOK.item_page_number}" readonly="readonly">
													<input type="button" id="input_page_number_btn" onclick="unlockElement('input_page_number',this)" value="잠금 해제">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="input_weight">무게</label>
													<input type="text" class="form-control" id="input_weight" name="input_weight" value="${pageScope.BOOK.item_weight}" readonly="readonly">
													<input type="button" id="input_weight_btn" onclick="unlockElement('input_weight',this)" value="잠금 해제">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="input_size">크기</label>
													<input type="text" class="form-control" id="input_size" name="input_size" value="${pageScope.BOOK.item_size}" readonly="readonly">
													<input type="button" id="input_size_btn" onclick="unlockElement('input_size',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="input_isbn13">ISBN13</label>
													<input type="text" class="form-control" id="input_isbn13" name="input_isbn13" value="${pageScope.BOOK.item_isbn13}" readonly="readonly">
													<input type="button" id="input_isbn13_btn" onclick="unlockElement('input_isbn13',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="input_isbn10">ISBN10</label>
													<input type="text" class="form-control" id="input_isbn10" name="input_isbn10" value="${pageScope.BOOK.item_isbn10}" readonly="readonly">
													<input type="button" id="input_isbn10_btn" onclick="unlockElement('input_isbn10',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>

						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="textarea_book_introduction">도서 소개</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" id="textarea_book_introduction" rows="12" readonly="readonly">${pageScope.BOOK.item_book_introduction}</textarea>
								<input type="button" id="textarea_book_introduction_btn" onclick="unlockElement('textarea_book_introduction',this)" value="잠금 해제">
							</div>
						</div>
						<hr />
						<div>
							<div class="form-group">
								<label for="textarea_item_contents_table">목차</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" id="textarea_item_contents_table" rows="12" readonly="readonly">${pageScope.BOOK.item_contents_table}</textarea>
								<input type="button" id="textarea_item_contents_table_btn" onclick="unlockElement('textarea_item_contents_table',this)" value="잠금 해제">
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
						<hr>
						<div>
							<div class="form-group">
								<label for="btn_author">저자 정보</label>
								<input type="button" id="btn_author" class="btn btn-primary" data-target="#author_modal" data-toggle="modal" value="저자 정보 수정">
							</div>
						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="btn_publisher">출판사 정보</label>
								<input type="button" id="btn_publisher" class="btn btn-primary" data-target="#publisher_modal" data-toggle="modal" value="출판사 정보 수정">
							</div>
						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="textarea_item_publisher_review">출판사 리뷰</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" id="textarea_item_publisher_review" rows="12" readonly="readonly">${pageScope.BOOK.item_publisher_review}</textarea>
								<input type="button" id="textarea_item_publisher_review_btn" onclick="unlockElement('textarea_item_publisher_review',this)" value="잠금 해제">
							</div>
						</div>

						<hr>

					</div>
					<input type="button" class="btn btn-primary" id="complete_modification_btn" name="complete_modification_btn" value="수정 완료">
					&nbsp;
					<input type="button" class="btn btn-secondary" id="cancel_modification_btn" name="cancel_modification_btn" value="수정 취소">

				</div>
				<footer>
					<%@ include file="/footer.html"%>
				</footer>
			</div>
		</div>

		<!-- 저자 정보 수정 MODAL -->
		<div class="modal fade" id="author_modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="author_modal_title">저자 정보 수정</h5>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<input type="hidden" id="input_author_code" name="input_author_code" value="${pageScope.AUTHOR.author_code }">
						<div>
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label for="input_author_name">저자 명</label>
									<input type="button" id="input_author_name_btn" class="btn btn-info" onclick="unlockElement('input_author_name',this)" value="잠금 해제">
									<input type="text" class="form-control form-control-sm" id="input_author_name" name="input_author_name" value="${pageScope.AUTHOR.author_name }" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="input_author_region">지역</label>
									<input type="button" id="input_author_region_btn" class="btn btn-info" onclick="unlockElement('input_author_region',this)" value="잠금 해제">
									<input type="text" class="form-control form-control-sm" id="input_author_region" name="input_author_region" value="${pageScope.AUTHOR.author_region }" readonly="readonly">
								</div>
							</div>
							<div class="form-group">
								<label for="textarea_author_desc">저자 소개</label>
								<input type="button" id="textarea_author_desc_btn" class="btn btn-info" onclick="unlockElement('textarea_author_desc',this)" value="잠금 해제">
								<textarea style="resize: none; word-break: break-all;" class="form-control form-control-sm" id="textarea_author_desc" name="textarea_author_desc" rows="3" readonly="readonly">${pageScope.AUTHOR.author_information }</textarea>
							</div>
						</div>
						<div>
							<table class="table" id="author_modal_table">
								<thead id="author_modal_thead">
									<tr>
										<th>저자 명</th>
										<th>지역</th>
										<th>저자 소개</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody id="author_modal_tbody">

								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer" id="author_modal_footer">
						<div class="form-row align-items-right">
							<div class="col-auto">
								<input type="text" class="form-control form-control-sm" id="input_find_author_name" value="${pageScope.AUTHOR.author_name }">
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="getAuthors()">저자 조회</button>
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="temporarilySaveAuthorData()" data-dismiss="modal">확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 출판사 정보 수정 MODAL -->
		<div class="modal fade" id="publisher_modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="publisher_modal_title">출판사 정보 수정</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<table class="table" id='publisher_modal_table'>
							<thead id="publisher_modal_thead">

							</thead>
							<tbody id="publisher_modal_tbody">

							</tbody>
						</table>

					</div>
					<div class="modal-footer" id="publisher_modal_footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		
		<input type="hidden" id="original_item_code" name="original_item_code" value="${pageScope.BOOK.item_code}">
		<input type="hidden" id="original_item_name" name="original_item_name" value="${pageScope.BOOK.item_name}">
		<input type="hidden" id="original_item_publisher_code" name="original_item_publisher_code" value="${pageScope.BOOK.item_publisher_code}">
		<input type="hidden" id="original_item_publication_date" name="original_item_publication_date" value="${pageScope.BOOK.item_publication_date}">
		<input type="hidden" id="original_item_fixed_price" name="original_item_fixed_price" value="${pageScope.BOOK.item_fixed_price}">
		<input type="hidden" id="original_item_selling_price" name="original_item_selling_price" value="${pageScope.BOOK.item_selling_price}">
		<input type="hidden" id="original_item_remaining_quantity" name="original_item_remaining_quantity" value="${pageScope.BOOK.item_remaining_quantity}">
		<input type="hidden" id="original_item_category_code" name="original_item_category_code" value="${pageScope.BOOK.item_category_code}">
		<input type="hidden" id="original_item_page_number" name="original_item_page_number" value="${pageScope.BOOK.item_page_number}">
		<input type="hidden" id="original_item_weight" name="original_item_weight" value="${pageScope.BOOK.item_weight}">
		<input type="hidden" id="original_item_size" name="original_item_size" value="${pageScope.BOOK.item_size}">
		<input type="hidden" id="original_item_isbn13" name="original_item_isbn13" value="${pageScope.BOOK.item_isbn13}">
		<input type="hidden" id="original_item_isbn10" name="original_item_isbn10" value="${pageScope.BOOK.item_isbn10}">
		<input type="hidden" id="original_item_book_introduction" name="original_item_book_introduction" value="${pageScope.BOOK.item_book_introduction}">
		<input type="hidden" id="original_item_contents_table" name="original_item_contents_table" value="${pageScope.BOOK.item_contents_table}">
		<input type="hidden" id="original_item_publisher_review" name="original_item_publisher_review" value="${pageScope.BOOK.item_publisher_review}">
		<input type="hidden" id="original_item_registration_datetime" name="original_item_registration_datetime" value="${pageScope.BOOK.item_registration_datetime}">
		<input type="hidden" id="original_item_category_desc" name="original_item_category_desc" value="${pageScope.BOOK.item_category_desc}">

		<input type="hidden" id="original_author_code" name="original_author_code" value="${pageScope.AUTHOR.author_code}">
		<input type="hidden" id="original_author_name" name="original_author_name" value="${pageScope.AUTHOR.author_name}">
		<input type="hidden" id="original_author_region" name="original_author_region" value="${pageScope.AUTHOR.author_region}">
		<input type="hidden" id="original_author_information" name="original_author_information" value="${pageScope.AUTHOR.author_information}">

		<input type="hidden" id="original_publisher_code" name="original_publisher_code" value="${pageScope.PUBLISHER.publisher_code}">
		<input type="hidden" id="original_publisher_name" name="original_publisher_name" value="${pageScope.PUBLISHER.publisher_name}">
		<input type="hidden" id="original_publisher_region" name="original_publisher_region" value="${pageScope.PUBLISHER.publisher_region}">
	</form>
	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>
	<script type="text/javascript">
		var authorList = [];
		var modifiedAuthorData = new Object();
		var selectedAuthorIndex = 0;

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function unlockElement(elementID, btnObj)
		{
			let element = document.getElementById(elementID);
			// tag의 readonly를 해제
			element.readOnly = false;

			let btn = document.getElementById(btnObj.id);
			btn.setAttribute('value', '잠금');
			btn.setAttribute('onclick', 'lockElement(\'' + elementID
					+ '\', this)');
		}

		function lockElement(elementID, btnObj)
		{
			let element = document.getElementById(elementID);
			// tag의 readonly를 해제
			element.readOnly = true;

			let btn = document.getElementById(btnObj.id);
			btn.setAttribute('value', '잠금 해제');
			btn.setAttribute('onclick', 'unlockElement(\'' + elementID
					+ '\', this)');
		}

		function getAuthors()
		{
			let authorName = document.getElementById('input_find_author_name').value;

			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const responseList = xhr.response;
					initializeAuthorTable();
					authorList = [];

					setAuthorList(responseList.AUTHORS);
					setAuthorTable();
				}
			};
			xhr.open('POST', '/AspireStore/management/authorManagement.aspire',
					'true');
			xhr.responseType = 'json';
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send('type=GET_AUTHORS' + '&author_name=' + authorName);
		}

		function setAuthorList(list)
		{
			for (let index = 0; index < list.length; ++index)
			{
				var authorObj =
				{
					author_name : list[index].AUTHOR.AUTHOR_NAME,
					author_region : list[index].AUTHOR.AUTHOR_REGION,
					author_code : list[index].AUTHOR.AUTHOR_CODE,
					author_desc : list[index].AUTHOR.AUTHOR_DESC
				};
				authorList.push(authorObj);
			}
		}

		function setAuthorTable()
		{
			let tBody = document.getElementById('author_modal_tbody');
			for (let index = 0; index < authorList.length; ++index)
			{
				let newRow = tBody.insertRow(index);

				let authorNameCol = newRow.insertCell(0);
				let authorRegionCol = newRow.insertCell(1);
				let authorDescCol = newRow.insertCell(2);
				let authorSelectionCol = newRow.insertCell(3);

				authorNameCol.innerText = authorList[index]['author_name'];
				authorRegionCol.innerText = authorList[index]['author_region'];
				authorDescCol.innerText = authorList[index]['author_desc'];

				let selectionBtn = document.createElement('input');
				selectionBtn.setAttribute('type', 'button');
				selectionBtn.setAttribute('class', 'btn btn-secondary');
				selectionBtn.setAttribute('onclick', 'setAuthorForm(' + index
						+ ')');
				selectionBtn.setAttribute('value', '선택');
				authorSelectionCol.appendChild(selectionBtn);
			}
		}

		function initializeAuthorTable()
		{
			let tBody = document.getElementById('author_modal_tbody');
			for (let index = tBody.rows.length - 1; index >= 0; --index)
			{
				tBody.deleteRow(index);
			}
		}

		function setAuthorForm(index)
		{
			selectedAuthorIndex = index;
			document.getElementById('input_author_name').value = authorList[index]['author_name'];
			document.getElementById('input_author_region').value = authorList[index]['author_region'];
			document.getElementById('textarea_author_desc').value = authorList[index]['author_desc'];
			document.getElementById('input_author_code').value = authorList[index]['author_code'];
		}

		function convertRegionToChar(region)
		{
			switch (region)
			{
			case '국내':
				return 'd';
			case '해외':
				return 'a';
			}
		}

		function temporarilySaveAuthorData()
		{
			let region = document.getElementById('input_author_region').value;

			if (region != '국내' && region != '해외')
			{
				alert('지역은 국내 또는 해외로 입력해주세요!');
			} else
			{
				modifiedAuthorData['author_name'] = document
						.getElementById('input_author_name').value;
				modifiedAuthorData['author_region'] = convertRegionToChar(document
						.getElementById('input_author_region').value);
				modifiedAuthorData['author_code'] = document
						.getElementById('input_author_code').value;
				modifiedAuthorData['author_desc'] = document
						.getElementById('textarea_author_desc').value;
			}
		}
	</script>
</body>
</html>