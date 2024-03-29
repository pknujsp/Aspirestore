<%@page import="model.FileDTO"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	request.setCharacterEncoding("UTF-8");

	ItemsDTO item = (ItemsDTO) request.getAttribute("ITEM");
	FileDTO mainImg = (FileDTO) request.getAttribute("MAIN_IMAGE");
	FileDTO infoImg = (FileDTO) request.getAttribute("INFO_IMAGE");

	pageContext.setAttribute("ITEM", item);
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

<title>${pageScope.ITEM.item_name}</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>
	<br>

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
				<tr>
					<th scope="row">정가</th>
					<td>
						&nbsp;<em>${pageScope.ITEM.item_fixed_price}</em>&nbsp;원
					</td>
				</tr>

				<tr>
					<th scope="row">판매가</th>
					<td>
						&nbsp;<em>${pageScope.ITEM.item_selling_price}</em>&nbsp;원
					</td>
				</tr>
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
				<h4>도서 소개</h4>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-line;">
					${pageScope.ITEM.item_book_introduction}
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
					<pre style="white-space: pre-line;">${pageScope.ITEM.item_contents_table}
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
			<h5>저자 정보</h5>
			<ul style="list-style: none;">
				<c:forEach var="author" items="${pageScope.ITEM.authors}" varStatus="status">
					<li>
						<div>
							<a href="/AspireStore/author/authorInfo.aspire?acode=${author.author_code }">${author.author_name}</a>
						</div>
						<div>
							<pre style="white-space: pre-line;">${author.author_information }</pre>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<hr />
		<div>
			<div>
				<div>
					<h5>출판사 리뷰</h5>
				</div>
				<div>
					<pre style="white-space: pre-line;">
				${pageScope.ITEM.item_publisher_review}
					</pre>
				</div>
			</div>
		</div>

		<hr>
		<div class="row">
			<div class="col-lg-8 col-md-10 mx-auto">
				<div>
					<h6>간단 리뷰</h6>
					<input type="button" id="sort_Srating_desc_btn" value="평점 순">
					<input type="button" id="sort_Spostdate_desc_btn" value="최신 순">

					<div class="container table-responsive">
						<table class="table" id="simple_review_list" style="table-layout: fixed">

						</table>
					</div>
					<nav aria-label="PaginationBar">
						<ul class="pagination justify-content-center" id="pagination_ul_simple">

						</ul>
					</nav>

					<hr>


					<div class="form-group" id="simple_review_form">
						<h6>간단 리뷰 작성</h6>
						<div class="col-sm-10">
							<div class="form-check form-check-inline">
								<input class="form-check-input" id="simple_review_rating1" name="simple_review_rating" type="radio" value="1">
								<label class="form-check-label" for="simple_review_rating1">매우 비 추천</label>
								<input class="form-check-input" id="simple_review_rating2" name="simple_review_rating" type="radio" value="2">
								<label class="form-check-label" for="simple_review_rating2">비 추천</label>
								<input class="form-check-input" id="simple_review_rating3" name="simple_review_rating" type="radio" value="3">
								<label class="form-check-label" for="simple_review_rating3">보통</label>
								<input class="form-check-input" id="simple_review_rating4" name="simple_review_rating" type="radio" value="4">
								<label class="form-check-label" for="simple_review_rating4">추천</label>
								<input class="form-check-input" id="simple_review_rating5" name="simple_review_rating" type="radio" value="5">
								<label class="form-check-label" for="simple_review_rating5">매우 추천</label>
							</div>
						</div>
						<div class="col">
							<textarea style="resize: none;" autocomplete="off" onkeyup="checkTextBytes(this)" class="form-control" id="simple_review_content" name="simple_review_content" rows="3">
							</textarea>
							<em id="currentTextSize">0</em>/100Byte
							<input type="button" class="btn btn-primary" onclick="applySimpleReview()" value="등록">
						</div>
					</div>
				</div>

				<hr>
				<div id="detail_review_form"></div>

				<hr>
				<div>
					<h6>상세 리뷰</h6>
					<input type="button" id="sort_Drating_desc_btn" value="평점 순">
					<input type="button" id="sort_Dpostdate_desc_btn" value="최신 순">
					<form action="/AspireStore/myaspire/writeReview.jsp" method="GET">
						<input type="submit" class="btn btn-primary" id="write_detail_review_btn" value="리뷰 작성">
						<input type="hidden" id="detail_review_icode" name="detail_review_icode" value="${pageScope.ITEM.item_code }">
						<input type="hidden" id="detail_review_ccode" name="detail_review_ccode" value="${pageScope.ITEM.item_category_code  }">
					</form>
					<div class="container table-responsive">

						<table class="table" id="detail_review_list" style="table-layout: fixed">

						</table>
					</div>
					<nav aria-label="PaginationBar">
						<ul class="pagination justify-content-center" id="pagination_ul_detail">
						</ul>
					</nav>

					<br>

				</div>
			</div>
		</div>
	</div>

	<form action="/AspireStore/basket.aspire" id="basketForm" name="basketForm" method="post">
		<input type="hidden" id="type" name="type" value="GET_BASKET">
	</form>

	<form action="/AspireStore/items/review.aspire" method="POST" id="processing_form" name="processing_form">
		<input type="hidden" id="type" name="type">
		<input type="hidden" id="table_type" name="table_type">
		<input type="hidden" id="review_code" name="review_code">
		<input type="hidden" id="icode" name="icode" value="${pageScope.ITEM.item_code }">
		<input type="hidden" id="ccode" name="ccode" value="${pageScope.ITEM.item_category_code }">
	</form>

	<%@ include file="/footer.html"%>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		function addBookToTheBasket(url)
		{
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function()
			{
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200)
				{
					var responseArr = xhttp.response;
					showDialog(responseArr[0].MESSAGE, responseArr[0].RESULT);
				}
			};
			xhttp.open('POST', url, true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');

			var icode = document.getElementById('itemCode').value;
			var ccode = document.getElementById('itemCategory').value;
			var quantity = document.getElementById('quantity').value;

			xhttp.responseType = 'json';
			xhttp.send('itemCode=' + icode + '&itemCategory=' + ccode
					+ '&type=' + 'ADD' + '&quantity=' + quantity);
		}

		function showDialog(message, result)
		{
			if (result === 'true')
			{
				var dialogMessage = confirm(message);
				if (dialogMessage)
				{
					var paging = document.basketForm;
					paging.submit();
				} else
				{

				}
			} else
			{
				alert(message);
			}
		}
	</script>
	<script>
		function clickButton(uri)
		{
			var form = document.getElementById('itemInfoForm');
			form.setAttribute('action', uri);
			paymentForm.submit();
		}
	</script>

	<script>
		var mySimpleReviewCode = 0;
		var myDetailReviewCode = 0;

		var simpleReviewPageData =
		{
			'total_record' : 0, //전체 레코드 수
			'num_per_page' : 5, // 페이지당 레코드 수 
			'page_per_block' : 5, //블럭당 페이지 수 
			'total_page' : 0, //전체 페이지 수
			'total_block' : 0, //전체 블럭수 
			'current_page' : 1, // 현재 페이지
			'current_block' : 1, //현재 블럭
			'begin_index' : 0, //QUERY select 시작번호
			'end_index' : 5, //시작번호로 부터 가져올 레코드 갯수
			'list_size' : 0
		//현재 읽어온 데이터의 수
		};

		var detailReviewPageData =
		{
			'total_record' : 0, //전체 레코드 수
			'num_per_page' : 5, // 페이지당 레코드 수 
			'page_per_block' : 5, //블럭당 페이지 수 
			'total_page' : 0, //전체 페이지 수
			'total_block' : 0, //전체 블럭수 
			'current_page' : 1, // 현재 페이지
			'current_block' : 1, //현재 블럭
			'begin_index' : 0, //QUERY select 시작번호
			'end_index' : 5, //시작번호로 부터 가져올 레코드 갯수
			'list_size' : 0
		//현재 읽어온 데이터의 수
		};
		const detailReviewList = [];

		(function()
		{
			getSimpleReviewJSON();

		})()

		function getBookCode()
		{
			return document.itemInfoForm.itemCode.value;
		}

		function getCategoryCode()
		{
			return document.itemInfoForm.itemCategory.value;
		}

		function setEmptyUL(id)
		{
			let ul = document.getElementById(id);
			let newLi = document.createElement('li');
			newLi.innerText = '아직 등록되지 않았습니다';
			ul.appendChild(newLi);
		}

		function getSimpleReviewJSON()
		{
			var xhrS = new XMLHttpRequest();

			xhrS.onreadystatechange = function()
			{
				if (xhrS.status == 200
						&& xhrS.readyState == XMLHttpRequest.DONE)
				{
					var recordSize = Number(xhrS.responseText.toString());

					if (recordSize == 0)
					{
						setEmptyUL('simple_review_list');
					} else
					{
						simpleReviewPageData['total_record'] = recordSize;
						calcPageDataS();
						referSimpleReviewData();
					}
				}
			};

			xhrS.open('POST', '/AspireStore/items/review.aspire', false);
			xhrS.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrS.send('type=' + 'GET_S_REVIEW_SIZE' + '&icode='
					+ String(getBookCode()) + '&ccode='
					+ String(getCategoryCode()));
		}

		function referSimpleReviewData()
		{
			var xhrRS = new XMLHttpRequest();

			xhrRS.onreadystatechange = function()
			{
				if (xhrRS.status == 200
						&& xhrRS.readyState == XMLHttpRequest.DONE)
				{
					const responseList = JSON.parse(xhrRS.responseText);

					// 이미 작성한 간단 리뷰가 있는 경우 -> 작성 폼을 숨기고 작성한 내용을 보여줌
					simpleReviewPageData['list_size'] = responseList.REVIEWS.length;
					initializeUL('simple_review_list');

					if (responseList.MY_S_REVIEW != null)
					{
						setSimpleReviewForm(responseList.MY_S_REVIEW);
					}

					let listSize = simpleReviewPageData['list_size'];
					for (let index = 0; index < simpleReviewPageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							setSimpleReviewTable(responseList.REVIEWS[index]);
						}
					}
					setPaginationBarS();
					getDetailReviewJSON();
				}
			};

			xhrRS.open('POST', '/AspireStore/items/review.aspire', false);
			xhrRS.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrRS.send('type=' + 'GET_S_REVIEW_JSON' + '&icode='
					+ getBookCode() + '&ccode=' + getCategoryCode()
					+ '&begin_index=' + simpleReviewPageData['begin_index']
					+ '&end_index=' + simpleReviewPageData['end_index']);
		}

		function setSimpleReviewTable(dataList)
		{
			let reviewTable = document.getElementById('simple_review_list');
			let newRow = reviewTable.insertRow(reviewTable.rows.length);

			let writerId = dataList.REVIEW['WRITER_ID'];
			let postDate = dataList.REVIEW['POST_DATE'];
			let rating = dataList.REVIEW['RATING'];
			let content = dataList.REVIEW['CONTENT'];

			let formCell = newRow.insertCell(0);

			let topDiv = document.createElement('div');
			let downDiv = document.createElement('div');

			let topSpan = document.createElement('span');

			topSpan.innerHTML = '<strong>' + writerId
					+ '</strong>&nbsp;|&nbsp;' + postDate + '&nbsp;|&nbsp;'
					+ convertRating(rating);

			topDiv.appendChild(topSpan);

			let contentPre = document.createElement('pre');
			contentPre.innerText = content;
			downDiv.appendChild(contentPre);

			formCell.appendChild(topDiv);
			formCell.appendChild(downDiv);
		}

		function getDetailReviewJSON()
		{
			var xhrD = new XMLHttpRequest();

			xhrD.onreadystatechange = function()
			{
				if (xhrD.status == 200
						&& xhrD.readyState == XMLHttpRequest.DONE)
				{
					var recordSize = Number(xhrD.responseText.toString());

					if (recordSize == 0)
					{
						setEmptyUL('detail_review_list');
					} else
					{
						detailReviewPageData['total_record'] = recordSize;
						calcPageDataD();
						referDetailReviewData();
					}
				}
			};

			xhrD.open('POST', '/AspireStore/items/review.aspire', false);
			xhrD.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrD.send('type=' + 'GET_D_REVIEW_SIZE' + '&icode=' + getBookCode()
					+ '&ccode=' + getCategoryCode());
		}

		function referDetailReviewData()
		{
			var xhrRD = new XMLHttpRequest();

			xhrRD.onreadystatechange = function()
			{
				if (xhrRD.status == 200
						&& xhrRD.readyState == XMLHttpRequest.DONE)
				{
					const responseList = JSON.parse(xhrRD.responseText);

					detailReviewPageData['list_size'] = responseList.DETAIL_REVIEWS.length;
					initializeUL('detail_review_list');

					let listSize = detailReviewPageData['list_size'];

					if (responseList.MY_D_REVIEW != null)
					{
						setDetailReviewForm(responseList.MY_D_REVIEW);
					}

					for (let index = 0; index < detailReviewPageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							setDetailReviewTable(responseList.DETAIL_REVIEWS[index]);
						}
					}
					setPaginationBarD();
				}
			};

			xhrRD.open('POST', '/AspireStore/items/review.aspire', false);
			xhrRD.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrRD.send('type=' + 'GET_D_REVIEW_JSON' + '&icode='
					+ getBookCode() + '&ccode=' + getCategoryCode()
					+ '&begin_index=' + detailReviewPageData['begin_index']
					+ '&end_index=' + detailReviewPageData['end_index']);
		}

		function calcPageDataS()
		{
			let beginIndex = simpleReviewPageData['begin_index'];
			let endIndex = simpleReviewPageData['end_index'];
			let numPerPage = simpleReviewPageData['num_per_page'];
			let totalRecord = simpleReviewPageData['total_record'];
			let currentPage = simpleReviewPageData['current_page'];
			let pagePerBlock = simpleReviewPageData['page_per_block'];

			simpleReviewPageData['begin_index'] = (currentPage * numPerPage)
					- numPerPage;
			simpleReviewPageData['end_index'] = numPerPage;
			simpleReviewPageData['total_page'] = parseInt(Math
					.ceil(parseFloat(totalRecord) / numPerPage));
			simpleReviewPageData['current_block'] = parseInt(Math
					.ceil(parseFloat(currentPage) / pagePerBlock));

			let totalPage = simpleReviewPageData['total_page'];

			simpleReviewPageData['total_block'] = parseInt(Math
					.ceil(parseFloat(totalPage) / pagePerBlock));
		}

		function pagingS(num)
		{
			simpleReviewPageData['current_page'] = Number(num);
			getSimpleReviewJSON();
		}

		function moveBlockS(num)
		{
			simpleReviewPageData['current_page'] = simpleReviewPageData['page_per_block']
					* (Number(num) - 1) + 1;
			getSimpleReviewJSON();
		}

		function setPaginationBarS()
		{
			let pageBegin = ((simpleReviewPageData['current_block'] - 1) * simpleReviewPageData['page_per_block']) + 1;
			let pageEnd = ((pageBegin + simpleReviewPageData['page_per_block']) <= simpleReviewPageData['total_page']) ? (pageBegin + simpleReviewPageData['page_per_block'])
					: simpleReviewPageData['total_page'] + 1;

			const totalPage = simpleReviewPageData['total_page'];
			const totalBlock = simpleReviewPageData['total_block'];
			const currentBlock = simpleReviewPageData['current_block'];
			const currentPage = simpleReviewPageData['current_page'];

			let newElement = '';

			if (totalPage != 0)
			{
				if (currentBlock > 1)
				{
					// 이전 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"javascript:moveBlockS(\''
							+ String(currentBlock - 1)
							+ '\')\" tabindex=\"-1\" aria-disabled=\"true\">이전</a></li>';
				}
				while (pageBegin < pageEnd)
				{
					if (pageBegin == currentPage)
					{
						// 현재 페이지 active
						newElement += '<li class=\"page-item active\" aria-current=\"page\"><a class=\"page-link\" href=\"javascript:pagingS(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '<span class=\"sr-only\">(현재 페이지)</span></a></li>';
					} else
					{
						// 1, 2, 3 버튼
						newElement += '<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:pagingS(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '</a></li>';
					}
					++pageBegin;
				}
				if (totalBlock > currentBlock)
				{
					// 다음 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"moveBlockS('
							+ currentBlock + 1 + ')\">다음</a></li>';
				}
			}
			document.getElementById('pagination_ul_simple').innerHTML = newElement;
		}

		function setDetailReviewTable(dataList)
		{

			let reviewList = document.getElementById('detail_review_list');
			let index = reviewList.rows.length;
			let newRow = reviewList.insertRow(index);

			let dataCell = newRow.insertCell(0);
			dataCell.setAttribute('style', 'word-break:break-all');

			let writerId = dataList.DETAIL_REVIEW['WRITER_ID'];
			let reviewCode = dataList.DETAIL_REVIEW['REVIEW_CODE'];
			let postDate = dataList.DETAIL_REVIEW['POST_DATE'];
			let rating = dataList.DETAIL_REVIEW['RATING'];
			let subject = dataList.DETAIL_REVIEW['SUBJECT'];
			let content = dataList.DETAIL_REVIEW['CONTENT'];
			let cutedContent = content;
			let collapseBtnCode = '';

			if (content.length >= 120)
			{
				// 펼쳐보기, 감추기 버튼 생성
				cutedContent = cutString(content);
				collapseBtnCode = '<input type=\'button\' id=\'collapse_content_btn'
						+ String(index)
						+ '\' value=\'모두 보기\' onclick=\'showWholeContent('
						+ index + ')\'>';
			}

			var detailReview =
			{
				'nick_name' : dataList.DETAIL_REVIEW['WRITER_ID'],
				'review_code' : dataList.DETAIL_REVIEW['REVIEW_CODE'],
				'post_date' : dataList.DETAIL_REVIEW['POST_DATE'],
				'rating' : dataList.DETAIL_REVIEW['RATING'],
				'content' : dataList.DETAIL_REVIEW['CONTENT'],
				'cuted_content' : cutedContent
			};

			detailReviewList.push(detailReview);

			dataCell.innerHTML = '<div class=\'media\'><div class=\'media-body\'>'
					+ '<b class=\'mt-0 font-weight-bold\'>'
					+ '<a href=\'/AspireStore/items/review.aspire?type=READ_D_REVIEW&rcode='
					+ reviewCode
					+ '&icode='
					+ getBookCode()
					+ '&ccode='
					+ getCategoryCode()
					+ '\'\' >'
					+ subject
					+ '</a>'
					+ '</b>'
					+ ' &ensp;|&ensp;'
					+ postDate
					+ ' &ensp;|&ensp;'
					+ convertRating(rating)
					+ '<div><p class=\'text-justify\' id=\'detail_review_content'
					+ String(index)
					+ '\'>'
					+ cutedContent
					+ '</p></div>'
					+ collapseBtnCode + '</div></div>';
		}

		function calcPageDataD()
		{
			let beginIndex = detailReviewPageData['begin_index'];
			let endIndex = detailReviewPageData['end_index'];
			let numPerPage = detailReviewPageData['num_per_page'];
			let totalRecord = detailReviewPageData['total_record'];
			let currentPage = detailReviewPageData['current_page'];
			let pagePerBlock = detailReviewPageData['page_per_block'];

			detailReviewPageData['begin_index'] = (currentPage * numPerPage)
					- numPerPage;
			detailReviewPageData['end_index'] = numPerPage;
			detailReviewPageData['total_page'] = parseInt(Math
					.ceil(parseFloat(totalRecord) / numPerPage));
			detailReviewPageData['current_block'] = parseInt(Math
					.ceil(parseFloat(currentPage) / pagePerBlock));

			let totalPage = detailReviewPageData['total_page'];

			detailReviewPageData['total_block'] = parseInt(Math
					.ceil(parseFloat(totalPage) / pagePerBlock));
		}

		function pagingD(num)
		{
			detailReviewPageData['current_page'] = Number(num);
			getDetailReviewJSON();
		}

		function moveBlockD(num)
		{
			detailReviewPageData['current_page'] = detailReviewPageData['page_per_block']
					* (Number(num) - 1) + 1;
			getDetailReviewJSON();
		}

		function setPaginationBarD()
		{
			let pageBegin = ((detailReviewPageData['current_block'] - 1) * detailReviewPageData['page_per_block']) + 1;
			let pageEnd = ((pageBegin + detailReviewPageData['page_per_block']) <= detailReviewPageData['total_page']) ? (pageBegin + detailReviewPageData['page_per_block'])
					: detailReviewPageData['total_page'] + 1;

			const totalPage = detailReviewPageData['total_page'];
			const totalBlock = detailReviewPageData['total_block'];
			const currentBlock = detailReviewPageData['current_block'];
			const currentPage = detailReviewPageData['current_page'];

			let newElement = '';

			if (totalPage != 0)
			{
				if (currentBlock > 1)
				{
					// 이전 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"javascript:moveBlockD(\''
							+ String(currentBlock - 1)
							+ '\')\" tabindex=\"-1\" aria-disabled=\"true\">이전</a></li>';
				}
				while (pageBegin < pageEnd)
				{
					if (pageBegin == currentPage)
					{
						// 현재 페이지 active
						newElement += '<li class=\"page-item active\" aria-current=\"page\"><a class=\"page-link\" href=\"javascript:pagingD(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '<span class=\"sr-only\">(현재 페이지)</span></a></li>';
					} else
					{
						// 1, 2, 3 버튼
						newElement += '<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:pagingD(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '</a></li>';
					}
					++pageBegin;
				}
				if (totalBlock > currentBlock)
				{
					// 다음 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"moveBlockD('
							+ currentBlock + 1 + ')\">다음</a></li>';
				}
			}
			document.getElementById('pagination_ul_detail').innerHTML = newElement;
		}

		function cutString(str)
		{
			// 문자열의 길이가 120자 이상인 경우 100자로 제한하여 자른다.
			return str.substr(0, 100) + '...';
		}

		function showWholeContent(index)
		{
			document.getElementById('detail_review_content' + String(index)).innerText = detailReviewList[index]['content'];
			let btn = document.getElementById('collapse_content_btn'
					+ String(index));

			btn.setAttribute('value', '감추기');
			btn.setAttribute('onclick', 'hideWholeContent(\'' + index + '\')');
		}

		function hideWholeContent(index)
		{
			document.getElementById('detail_review_content' + String(index)).innerText = detailReviewList[index]['cuted_content'];

			let btn = document.getElementById('collapse_content_btn'
					+ String(index));

			btn.setAttribute('value', '모두 보기');
			btn.setAttribute('onclick', 'showWholeContent(\'' + index + '\')');
		}

		function initializeUL(id)
		{
			let ul = document.getElementById(id);

			while (ul.firstChild)
			{
				ul.removeChild(ul.firstChild);
			}
		}

		function checkTextBytes(obj)
		{
			let str = obj.value;
			let currentByte = 0;
			let currentLength = 0;
			let character = '';
			let cutedStr = '';
			let maxByte = 100;
			let toBeCutedIndex = 0;

			for (let index = 0; index < str.length; ++index)
			{
				character = str.charCodeAt(index);

				if (character > 128)
				{
					currentByte += 2;
				} else
				{
					++currentByte;
				}
				if (currentByte <= maxByte)
				{
					toBeCutedIndex = index;
				}
			}
			if (currentByte > maxByte)
			{
				cutedStr = str.substr(0, toBeCutedIndex);
				obj.value = cutedStr;
				checkTextBytes(obj);
			} else
			{
				document.getElementById('currentTextSize').innerText = currentByte;
			}
		}

		function applySimpleReview()
		{
			let ratingRadio = document
					.getElementsByName('simple_review_rating');
			let rating = '';
			for (let index = 0; index < ratingRadio.length; ++index)
			{
				if (ratingRadio[index].checked == true)
				{
					rating = ratingRadio[index].value;
				}
			}

			let content = document.getElementById('simple_review_content').value;

			var xhrAS = new XMLHttpRequest();

			xhrAS.onreadystatechange = function()
			{
				if (xhrAS.readyState == XMLHttpRequest.DONE
						&& xhrAS.status == 200)
				{
					getSimpleReviewJSON();
				}
			};
			xhrAS.open('POST', '/AspireStore/items/review.aspire', true);
			xhrAS.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrAS.send('type=' + 'APPLY_S_REVIEW' + '&rating=' + rating
					+ '&content=' + content + '&icode=' + getBookCode()
					+ '&ccode=' + getCategoryCode());
		}

		function convertRating(ratingCode)
		{
			switch (ratingCode)
			{
			case '1':
				return '매우 비 추천';
			case '2':
				return '비 추천';
			case '3':
				return '보통';
			case '4':
				return '추천';
			case '5':
				return '매우 추천';
			}
		}

		function deleteMyReview(tableType)
		{
			let form = document.processing_form;
			form.table_type.value = tableType;

			if (tableType == 'SIMPLE')
			{
				form.review_code.value = mySimpleReviewCode;
			} else
			{
				// DETAIL
				form.review_code.value = myDetailReviewCode;
			}
			form.type.value = 'DELETE';
			form.submit();
		}

		function modifyMyReview(tableType)
		{
			let form = document.processing_form;
			form.table_type.value = tableType;

			if (tableType == 'SIMPLE')
			{
				form.review_code.value = mySimpleReviewCode;
			} else
			{
				// DETAIL
				form.review_code.value = myDetailReviewCode;
			}
			form.type.value = 'MODIFY';
			form.submit();
		}

		function setSimpleReviewForm(data)
		{
			let form = document.getElementById('simple_review_form');

			while (form.firstChild)
			{
				// 해당 div의 모든 요소를 비운다.
				form.removeChild(form.firstChild);
			}
			mySimpleReviewCode = data['REVIEW_CODE'];

			const innerHTML = '<h6>나의 간단 리뷰</h6>'
					+ '<div class=\'media\'><div class=\'media-body\'>'
					+ '<b class=\'mt-0 font-weight-bold\'>' + data['WRITER_ID']
					+ '</a>' + '</b>' + '&ensp;|&ensp;' + data['POST_DATE']
					+ '&ensp;|&ensp;' + convertRating(data['RATING'])
					+ '&nbsp;|&nbsp;'
					+ '<p class=\'card-text\' id=\'simple_review_content\'>'
					+ data['CONTENT'] + '</p>' + '</div></div>';

			form.innerHTML = innerHTML;
		}

		function setDetailReviewForm(data)
		{
			let form = document.getElementById('detail_review_form');

			while (form.firstChild)
			{
				// 해당 div의 모든 요소를 비운다.
				form.removeChild(form.firstChild);
			}
			let writerId = data['WRITER_ID'];
			let reviewCode = data['REVIEW_CODE'];
			let postDate = data['POST_DATE'];
			let rating = data['RATING'];
			let subject = data['SUBJECT'];
			let content = data['CONTENT'];
			let cutedContent = content;
			let collapseBtnCode = '';

			if (content.length >= 120)
			{
				// 펼쳐보기, 감추기 버튼 생성
				cutedContent = cutString(content);
			}

			myDetailReviewCode = data['REVIEW_CODE'];

			form.innerHTML = '<h6>나의 상세 리뷰</h6>'
					+ '<div class=\'media\'><div class=\'media-body\'>'
					+ '<b class=\'mt-0 font-weight-bold\'>'
					+ '<a href=\'/AspireStore/items/review.aspire?type=READ_D_REVIEW&rcode='
					+ reviewCode
					+ '&icode='
					+ getBookCode()
					+ '&ccode='
					+ getCategoryCode()
					+ '\'\' >'
					+ subject
					+ '</a>'
					+ '</b>'
					+ '&ensp;|&ensp;'
					+ postDate
					+ '&ensp;|&ensp;'
					+ convertRating(rating)
					+ '&ensp;|&ensp;'
					+ '<div><p class=\'text-justify\' id=\'detail_my_review_content\'>'
					+ cutedContent + '</p></div>' + '</div></div>';
		}
	</script>
</body>
</html>