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

	pageContext.setAttribute("BOOK", book);
	pageContext.setAttribute("AUTHOR", author);
	pageContext.setAttribute("PUBLISHER", publisher);
	pageContext.setAttribute("MAIN_IMAGE", mainImg);
	pageContext.setAttribute("INFO_IMAGE", infoImg);
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
						<h6>사진 변경</h6>
						<table class="table">
							<thead>
								<tr>
									<th>대표 사진</th>
									<th>썸네일</th>
									<th>처리</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<img src="/AspireStore/itemImages/${pageScope.MAIN_IMAGE.file_name }" alt="No Image" width="400px" />
									</td>
									<td>
										<img src="/AspireStore/itemImages/${pageScope.MAIN_IMAGE.file_name }" alt="No Image" width="100px" />
									</td>
									<td>
										<input type="button" class="btn btn-primary" id="main_img_btn" name="main_img_btn" data-toggle="modal" data-target="#image_modal" onclick="changeImgModal('MAIN')" value="사진 변경">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<div class="form-group">
							<label for="it_item_name">도서 명</label>
							<input type="text" class="form-control" id="it_item_name" name="it_item_name" value="${pageScope.BOOK.item_name}" readonly="readonly">
							<input type="button" id="item_name_btn" onclick="unlockElement('it_item_name',this)" value="잠금 해제">
						</div>

						<hr>

						<div class="form-group">
							<label for="it_fixed_price">정가</label>
							<input type="text" class="form-control" id="it_fixed_price" name="it_fixed_price" value="${pageScope.BOOK.item_fixed_price}" readonly="readonly">
							원
							<input type="button" id="fixed_price_btn" onclick="unlockElement('it_fixed_price',this)" value="잠금 해제">
						</div>
						<div class="form-group">
							<label for="it_selling_price">판매가</label>
							<input type="text" class="form-control" id="it_selling_price" name="it_selling_price" value="${pageScope.BOOK.item_selling_price}" readonly="readonly">
							원
							<input type="button" id="selling_price_btn" onclick="unlockElement('it_selling_price',this)" value="잠금 해제">
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
													<label for="it_pub_date">출간 날짜</label>
													<input type="text" class="form-control" id="it_pub_date" name="it_pub_date" value="${pageScope.BOOK.item_publication_date}" readonly="readonly">
													<input type="button" id="pub_date_btn" onclick="unlockElement('it_pub_date',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="page_number">쪽수</label>
													<input type="text" class="form-control" id="it_page_number" name="it_page_number" value="${pageScope.BOOK.item_page_number}" readonly="readonly">
													<input type="button" id="page_number_btn" onclick="unlockElement('it_page_number',this)" value="잠금 해제">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="weight">무게</label>
													<input type="text" class="form-control" id="it_weight" name="it_weight" value="${pageScope.BOOK.item_weight}" readonly="readonly">
													<input type="button" id="weight_btn" onclick="unlockElement('it_weight',this)" value="잠금 해제">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="size">크기</label>
													<input type="text" class="form-control" id="it_size" name="it_size" value="${pageScope.BOOK.item_size}" readonly="readonly">
													<input type="button" id="size_btn" onclick="unlockElement('it_size',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="isbn13">ISBN13</label>
													<input type="text" class="form-control" id="it_isbn13" name="it_isbn13" value="${pageScope.BOOK.item_isbn13}" readonly="readonly">
													<input type="button" id="isbn13_btn" onclick="unlockElement('it_isbn13',this)" value="잠금 해제">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="isbn10">ISBN10</label>
													<input type="text" class="form-control" id="it_isbn10" name="it_isbn10" value="${pageScope.BOOK.item_isbn10}" readonly="readonly">
													<input type="button" id="isbn10_btn" onclick="unlockElement('it_isbn10',this)" value="잠금 해제">
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
								<label for="it_book_introduction">도서 소개</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_book_introduction" id="it_book_introduction" rows="12" readonly="readonly">${pageScope.BOOK.item_book_introduction}</textarea>
								<input type="button" id="book_introduction_btn" onclick="unlockElement('it_book_introduction',this)" value="잠금 해제">
							</div>
						</div>
						<hr />
						<div>
							<div class="form-group">
								<label for="it_item_contents_table">목차</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_item_contents_table" id="it_item_contents_table" rows="12" readonly="readonly">${pageScope.BOOK.item_contents_table}</textarea>
								<input type="button" id="item_contents_table_btn" onclick="unlockElement('it_item_contents_table',this)" value="잠금 해제">
							</div>
						</div>
						<hr />
						<div>
							<h6>상세 정보 사진 변경</h6>
							<table class="table">
								<thead>
									<tr>
										<th>사진</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<img src="/AspireStore/itemImages/${pageScope.INFO_IMAGE.file_name }" alt="No Image" width="100%" />
										</td>
									</tr>
								</tbody>
							</table>
							<input type="button" class="btn btn-primary" id="info_img_btn" name="info_img_btn" data-toggle="modal" data-target="#image_modal" onclick="changeImgModal('INFO')" value="사진 변경">
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
								<label for="it_item_publisher_review">출판사 리뷰</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_item_publisher_review" id="it_item_publisher_review" rows="12" readonly="readonly">${pageScope.BOOK.item_publisher_review}</textarea>
								<input type="button" id="item_publisher_review_btn" onclick="unlockElement('it_item_publisher_review',this)" value="잠금 해제">
							</div>
						</div>

						<hr>

					</div>
					<input type="button" class="btn btn-primary" onclick="confirmModification()" id="complete_modification_btn" name="complete_modification_btn" value="수정 완료">
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
						<div>
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label for="au_author_code">저자 코드</label>
									<input type="text" class="form-control form-control-sm" id="au_author_code" name="au_author_code" value="${pageScope.AUTHOR.author_code }" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="au_author_name">저자 명</label>
									<input type="button" id="author_name_btn" class="btn btn-info" onclick="unlockElement('au_author_name',this)" value="잠금 해제">
									<input type="text" class="form-control form-control-sm" id="au_author_name" name="au_author_name" value="${pageScope.AUTHOR.author_name }" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="au_author_region">지역</label> <select id="au_author_region" name="au_author_region" class="form-control">
										<c:if test="${pageScope.AUTHOR.author_region == 'd' }">
											<option value="d" selected="selected">국내</option>
											<option value="a">국외</option>
										</c:if>
										<c:if test="${pageScope.AUTHOR.author_region == 'a' }">
											<option value="d">국내</option>
											<option value="a" selected="selected">국외</option>
										</c:if>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="au_author_desc">저자 소개</label>
								<input type="button" id="author_desc_btn" class="btn btn-info" onclick="unlockElement('au_author_desc',this)" value="잠금 해제">
								<textarea style="resize: none; word-break: break-all;" class="form-control form-control-sm" id="au_author_desc" name="au_author_desc" rows="3" readonly="readonly">${pageScope.AUTHOR.author_information }</textarea>
							</div>
						</div>
						<div>
							<table class="table" id="author_modal_table">
								<thead id="author_modal_thead">
									<tr>
										<th>저자 코드</th>
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
								<button type="button" class="btn btn-primary" onclick="checkRegion('au_author_region')" data-dismiss="modal">수정완료</button>
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
						<div>
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label for="pu_publisher_code">출판사 코드</label>
									<input type="text" class="form-control form-control-sm" id="pu_publisher_code" name="pu_publisher_code" value="${pageScope.PUBLISHER.publisher_code }" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="pu_publisher_name">출판사 명</label>
									<input type="button" id="publisher_name_btn" class="btn btn-info" onclick="unlockElement('pu_publisher_name',this)" value="잠금 해제">
									<input type="text" class="form-control form-control-sm" id="pu_publisher_name" name="pu_publisher_name" value="${pageScope.PUBLISHER.publisher_name }" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="pu_publisher_region">지역</label> <select id="pu_publisher_region" name="pu_publisher_region" class="form-control">
										<c:if test="${pageScope.PUBLISHER.publisher_region == 'd' }">
											<option value="d" selected="selected">국내</option>
											<option value="a">국외</option>
										</c:if>
										<c:if test="${pageScope.PUBLISHER.publisher_region == 'a' }">
											<option value="d">국내</option>
											<option value="a" selected="selected">국외</option>
										</c:if>
									</select>
								</div>
							</div>
						</div>
						<div>
							<table class="table" id="publisher_modal_table">
								<thead id="publisher_modal_thead">
									<tr>
										<th>출판사 코드</th>
										<th>출판사 명</th>
										<th>지역</th>
										<th>선택</th>
									</tr>
								</thead>
								<tbody id="publisher_modal_tbody">

								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer" id="publisher_modal_footer">
						<div class="form-row align-items-right">
							<div class="col-auto">
								<input type="text" class="form-control form-control-sm" id="input_find_publisher_name" value="${pageScope.PUBLISHER.publisher_name }">
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="getPublishers()">출판사 조회</button>
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="checkRegion('pu_publisher_region')" data-dismiss="modal">수정완료</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div id="original_datalist">
			<input type="hidden" id="original_item_name" name="original_item_name" value="${pageScope.BOOK.item_name}">
			<input type="hidden" id="original_item_publication_date" name="original_item_publication_date" value="${pageScope.BOOK.item_publication_date}">
			<input type="hidden" id="original_item_fixed_price" name="original_item_fixed_price" value="${pageScope.BOOK.item_fixed_price}">
			<input type="hidden" id="original_item_selling_price" name="original_item_selling_price" value="${pageScope.BOOK.item_selling_price}">
			<input type="hidden" id="original_item_page_number" name="original_item_page_number" value="${pageScope.BOOK.item_page_number}">
			<input type="hidden" id="original_item_weight" name="original_item_weight" value="${pageScope.BOOK.item_weight}">
			<input type="hidden" id="original_item_size" name="original_item_size" value="${pageScope.BOOK.item_size}">
			<input type="hidden" id="original_item_isbn13" name="original_item_isbn13" value="${pageScope.BOOK.item_isbn13}">
			<input type="hidden" id="original_item_isbn10" name="original_item_isbn10" value="${pageScope.BOOK.item_isbn10}">
			<input type="hidden" id="original_item_book_introduction" name="original_item_book_introduction" value="${pageScope.BOOK.item_book_introduction}">
			<input type="hidden" id="original_item_contents_table" name="original_item_contents_table" value="${pageScope.BOOK.item_contents_table}">
			<input type="hidden" id="original_item_publisher_review" name="original_item_publisher_review" value="${pageScope.BOOK.item_publisher_review}">

			<input type="hidden" id="original_author_code" name="original_author_code" value="${pageScope.AUTHOR.author_code}">
			<input type="hidden" id="original_author_name" name="original_author_name" value="${pageScope.AUTHOR.author_name}">
			<input type="hidden" id="original_author_region" name="original_author_region" value="${pageScope.AUTHOR.author_region}">
			<input type="hidden" id="original_author_information" name="original_author_information" value="${pageScope.AUTHOR.author_information}">

			<input type="hidden" id="original_publisher_code" name="original_publisher_code" value="${pageScope.PUBLISHER.publisher_code}">
			<input type="hidden" id="original_publisher_name" name="original_publisher_name" value="${pageScope.PUBLISHER.publisher_name}">
			<input type="hidden" id="original_publisher_region" name="original_publisher_region" value="${pageScope.PUBLISHER.publisher_region}">
		</div>
	</form>

	<!-- 사진 수정 MODAL -->
	<div class="modal fade" id="image_modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="image_modal_title">사진 수정</h5>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="image_modal_body">
					<form id="img_form" name="img_form" enctype="multipart/form-data">
						<input type="hidden" id="type" name="type">
						<input type="hidden" id="icode" name="icode" value="${pageScope.BOOK.item_code }">
						<input type="hidden" id="code" name="ccode" value="${pageScope.BOOK.item_category_code }">
						<input type="file" class="form-control-file" id="image" name="image">
					</form>
				</div>
				<div class="modal-footer" id="image_modal_footer">
					<div class="form-row align-items-right">
						<div class="col-auto">
							<button type="button" id="image_modal_cbtn" onclick="requestImgUpdate()" class="btn btn-primary" data-dismiss="modal">수정완료</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<form enctype="application/json" id="confirmation_modification_form" name="confirmation_modification_form" action="/AspireStore/management/bookManagement.aspire" method="POST">
		<input type="hidden" id="datalist" name="datalist">
	</form>
	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>
	<script type="text/javascript">
		var authorList = [];
		var publisherList = [];
		var selectedAuthorIndex = 0;
		var selectedPublisherIndex = 0;
		var itemCode = '${pageScope.BOOK.item_code}';
		var itemCategoryCode = '${pageScope.BOOK.item_category_code}';
		var authorCode = '${pageScope.AUTHOR.author_code}';
		var publisherCode = '${pageScope.PUBLISHER.publisher_code}';

		const originalData =
		{
			it_item_name : '',
			it_pub_date : '',
			it_fixed_price : '',
			it_selling_price : '',
			it_page_number : '',
			it_weight : '',
			it_size : '',
			it_isbn13 : '',
			it_isbn10 : '',
			it_book_introduction : '',
			it_item_contents_table : '',
			it_item_publisher_review : '',
			au_author_code : '',
			au_author_name : '',
			au_author_region : '',
			au_author_desc : '',
			pu_publisher_code : '',
			pu_publisher_name : '',
			pu_publisher_region : ''
		};

		(function saveBookData()
		{
			let dataList = document.getElementById('original_datalist');
			let inputTags = dataList.getElementsByTagName('input');
			let sequence = 0;
			let keys = Object.keys(originalData);

			for (let index = 0; index < inputTags.length; ++index)
			{
				originalData[keys[index]] = inputTags[index].value.toString();
			}

			while (dataList.firstChild)
			{
				// 원본 데이터를 가지고 있는 input tag를 제거
				dataList.removeChild(dataList.childNodes[0]);
			}
		})()

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

				let authorCodeCol = newRow.insertCell(0);
				let authorNameCol = newRow.insertCell(1);
				let authorRegionCol = newRow.insertCell(2);
				let authorDescCol = newRow.insertCell(3);
				let authorSelectionCol = newRow.insertCell(4);

				authorCodeCol.innerText = authorList[index]['author_code'];
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
			document.getElementById('au_author_name').value = authorList[index]['author_name'];

			let selectElement = document.getElementById('au_author_region');

			if (selectElement[0].value == authorList[index]['author_region'])
			{
				// 국내
				selectElement[0].selected = true;
				selectElement[1].selected = false;
			} else
			{
				// 국외
				selectElement[0].selected = false;
				selectElement[1].selected = true;
			}

			document.getElementById('au_author_desc').value = authorList[index]['author_desc'];
			document.getElementById('au_author_code').value = authorList[index]['author_code'];
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

		function checkRegion(id)
		{
			let region = document.getElementById(id).value;

			if (region != '국내' && region != '해외')
			{
				alert('지역은 국내 또는 해외로 입력해주세요!');
			}
		}

		function getPublishers()
		{
			let publisherName = document
					.getElementById('input_find_publisher_name').value;

			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const responseList = xhr.response;
					initializePublisherTable();
					publisherList = [];

					setPublisherList(responseList.PUBLISHERS);
					setPublisherTable();
				}
			};
			xhr.open('POST',
					'/AspireStore/management/publisherManagement.aspire',
					'true');
			xhr.responseType = 'json';
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr
					.send('type=GET_PUBLISHERS' + '&publisher_name='
							+ publisherName);
		}

		function setPublisherList(list)
		{
			for (let index = 0; index < list.length; ++index)
			{
				var publisherObj =
				{
					publisher_name : list[index].PUBLISHER.PUBLISHER_NAME,
					publisher_region : list[index].PUBLISHER.PUBLISHER_REGION,
					publisher_code : list[index].PUBLISHER.PUBLISHER_CODE
				};
				publisherList.push(publisherObj);
			}
		}

		function setPublisherTable()
		{
			let tBody = document.getElementById('publisher_modal_tbody');
			for (let index = 0; index < publisherList.length; ++index)
			{
				let newRow = tBody.insertRow(index);

				let publisherCodeCol = newRow.insertCell(0);
				let publisherNameCol = newRow.insertCell(1);
				let publisherRegionCol = newRow.insertCell(2);
				let publisherSelectionCol = newRow.insertCell(3);

				publisherCodeCol.innerText = publisherList[index]['publisher_code'];
				publisherNameCol.innerText = publisherList[index]['publisher_name'];
				publisherRegionCol.innerText = publisherList[index]['publisher_region'];

				let selectionBtn = document.createElement('input');
				selectionBtn.setAttribute('type', 'button');
				selectionBtn.setAttribute('class', 'btn btn-secondary');
				selectionBtn.setAttribute('onclick', 'setPublisherForm('
						+ index + ')');
				selectionBtn.setAttribute('value', '선택');
				publisherSelectionCol.appendChild(selectionBtn);
			}
		}

		function initializePublisherTable()
		{
			let tBody = document.getElementById('publisher_modal_tbody');
			for (let index = tBody.rows.length - 1; index >= 0; --index)
			{
				tBody.deleteRow(index);
			}
		}

		function setPublisherForm(index)
		{
			selectedPublisherIndex = index;
			document.getElementById('pu_publisher_name').value = publisherList[index]['publisher_name'];

			let selectElement = document.getElementById('pu_publisher_region');

			if (selectElement[0].value == publisherList[index]['publisher_region'])
			{
				// 국내
				selectElement[0].selected = true;
				selectElement[1].selected = false;
			} else
			{
				// 국외
				selectElement[0].selected = false;
				selectElement[1].selected = true;
			}

			document.getElementById('pu_publisher_code').value = publisherList[index]['publisher_code'];
		}

		function getModifiedDataList()
		{
			// 변경된 값의 input tag name을 가지는 리스트
			const modifiedValueList = [];
			const originalObjKeys = Object.keys(originalData);

			const processingData =
			{
				type : 'UPDATE_DATA',
				item_code : itemCode.toString(),
				item_category_code : itemCategoryCode.toString(),
			};
			modifiedValueList.push(processingData);

			if ((document.getElementById('au_author_code').value == originalData['au_author_code'])
					&& (document.getElementById('au_author_name').value == originalData['au_author_name'])
					&& (document.getElementById('au_author_region').value == originalData['au_author_region'])
					&& (document.getElementById('au_author_desc').value == originalData['au_author_desc']))
			{
			} else if (document.getElementById('au_author_code').value == authorCode)
			{
				let count = 0;
				// 저자 코드 동일
				for (let index = 0; index < originalObjKeys.length; ++index)
				{
					const tag = document.getElementById(originalObjKeys[index]);
					const dataType = classifyData(tag.name);

					if (dataType == 'author')
					{
						const modifiedData =
						{
							data_name : tag.name,
							data_value : tag.value.toString(),
							status : 'MODIFIED_AUTHOR_INFO'
						};
						modifiedValueList.push(modifiedData);
						if (++count == 4)
						{
							break;
						}
					}
				}
			} else
			{
				// 저자 코드 변경
				let count = 0;
				for (let index = 0; index < originalObjKeys.length; ++index)
				{
					const tag = document.getElementById(originalObjKeys[index]);
					const dataType = classifyData(tag.name);

					if (dataType == 'author')
					{
						const modifiedData =
						{
							data_name : tag.name,
							data_value : tag.value.toString(),
							status : 'REPLACED_AUTHOR'
						};
						modifiedValueList.push(modifiedData);
						if (++count == 4)
						{
							break;
						}
					}
				}
			}

			if ((document.getElementById('pu_publisher_code').value == originalData['pu_publisher_code'])
					&& (document.getElementById('pu_publisher_name').value == originalData['pu_publisher_name'])
					&& (document.getElementById('pu_publisher_region').value == originalData['pu_publisher_region']))
			{
			} else if (document.getElementById('pu_publisher_code').value == publisherCode)
			{
				let count = 0;
				// 출판사 코드 동일
				for (let index = 0; index < originalObjKeys.length; ++index)
				{
					const tag = document.getElementById(originalObjKeys[index]);
					const dataType = classifyData(tag.name);

					if (dataType == 'publisher')
					{
						const modifiedData =
						{
							data_name : tag.name,
							data_value : tag.value.toString(),
							status : 'MODIFIED_PUBLISHER_INFO'
						};
						modifiedValueList.push(modifiedData);
						if (++count == 3)
						{
							break;
						}
					}
				}
			} else
			{
				// 출판사 코드 변경
				let count = 0;
				for (let index = 0; index < originalObjKeys.length; ++index)
				{
					const tag = document.getElementById(originalObjKeys[index]);
					const dataType = classifyData(tag.name);

					if (dataType == 'publisher')
					{
						const modifiedData =
						{
							data_name : tag.name,
							data_value : tag.value.toString(),
							status : 'REPLACED_PUBLISHER'
						};
						modifiedValueList.push(modifiedData);
						if (++count == 3)
						{
							break;
						}
					}
				}
			}

			// book
			for (let index = 0; index < originalObjKeys.length; ++index)
			{
				// tag의 종류 구별, textarea OR input
				const tag = document.getElementById(originalObjKeys[index]);
				const originalValue = originalData[originalObjKeys[index]]
						.toString();
				const dataType = classifyData(tag.name);

				if (dataType == 'item')
				{
					if (tag.value != originalValue)
					{
						const modifiedData =
						{
							data_name : tag.name,
							data_value : tag.value.toString(),
							status : 'MODIFIED_ITEM'
						};
						modifiedValueList.push(modifiedData);
					}
				}
			}
			return modifiedValueList;
		}

		function confirmModification()
		{
			const modifiedDataList = getModifiedDataList();

			// xhr이용
			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const result = xhr.responseText;
					if (result == 'true')
					{
						alert('수정 완료');
					} else
					{
						alert('수정 실패');
					}
				}
			}

			xhr.open('POST', '/AspireStore/management/bookManagement.aspire',
					true);
			xhr.setRequestHeader('Content-type', 'application/json');
			xhr.send(JSON.stringify(modifiedDataList));
		}

		function classifyData(dataName)
		{
			let dataType = dataName.substring(0, 2);
			if (dataType == 'it')
			{
				return 'item';
			} else if (dataType == 'au')
			{
				return 'author';
			} else if (dataType == 'pu')
			{
				return 'publisher';
			}
		}

		function changeImgModal(imgType)
		{
			let imgForm = document.img_form;

			if (imgType == 'INFO')
			{
				imgForm.type.value = 'UPDATE_INFO_IMG';
			} else
			{
				// MAIN
				imgForm.type.value = 'UPDATE_MAIN_IMG';
			}
		}

		function requestImgUpdate()
		{
			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					if (xhr.responseText == 'true')
					{
						alert('사진 변경 완료');
						location.reload();
					} else
					{
						alert('사진 변경 실패');
					}
				}
			};

			let imgForm = new FormData(document.getElementById('img_form'));

			xhr.open('POST',
					'/AspireStore/management/bookImgManagement.aspire', false);
			xhr.send(imgForm);
		}
	</script>
</body>
</html>