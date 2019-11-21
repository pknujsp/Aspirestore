<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	@SuppressWarnings("unchecked")
	HashMap<String, HashMap<String, String>> categoryData = (HashMap<String, HashMap<String, String>>) request
			.getAttribute("CATEGORY_DATA");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


<title>도서 추가</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">

</head>
<body>
	<form id="add_form" name="add_form" action="/AspireStore/management/bookRegistration.aspire" method="POST" enctype="multipart/form-data">

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
						<h6>사진 추가</h6>
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
										<img src="" id="main_img" alt="No Image" width="400px" />
									</td>
									<td>
										<img src="" id="thumbnail_img" alt="No Image" width="100px" />
									</td>

									<td>
										<input type="file" id="main_img_btn" name="main_img_btn" value="사진 추가" accept=".jpg, .jpeg, .png" multiple="multiple">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div>
						<div class="form-group">
							<label for="it_item_name">도서 명</label>
							<input type="text" class="form-control col-5" id="it_item_name" name="it_item_name">
						</div>

						<div class="form-group">
							<label for="it_item_category_code">도서 카테고리</label> <select class="form-control col-5" id="it_item_category_code" name="it_item_category_code">
								<optgroup label="게임">
									<option value="101">게임 기획</option>
									<option value="102">게임 개발</option>
									<option value="103">게임 가이드북</option>
									<option value="104">모바일 게임</option>
								</optgroup>
								<optgroup label="그래픽/디자인/멀티미디어">
									<option value="201">3DS/MAX</option>
									<option value="202">건축CG</option>
									<option value="203">그래픽일반/자료집</option>
									<option value="204">그래픽툴/저작툴</option>
									<option value="205">디렉터</option>
									<option value="206">라이트룸</option>
									<option value="207">베가스</option>
									<option value="208">인디자인</option>
									<option value="209">일러스트레이터</option>
									<option value="210">캐릭터/애니메이션</option>
									<option value="211">페인터</option>
									<option value="212">포토샵</option>
									<option value="213">프리미어</option>
									<option value="214">플래시</option>
									<option value="215">애프터 이펙트</option>
									<option value="216">오토캐드</option>
									<option value="217">멀티미디어/컴퓨터</option>
									<option value="218">디지털 카메라</option>
								</optgroup>
								<optgroup label="네트워크/해킹/보안">
									<option value="301">네트워크 일반</option>
									<option value="302">TCP/IP</option>
									<option value="303">보안/해킹</option>
								</optgroup>
								<optgroup label="모바일 프로그래밍">
									<option value="401">아이폰</option>
									<option value="402">안드로이드폰</option>
									<option value="403">윈도우폰</option>
									<option value="404">모바일 게임</option>
								</optgroup>
								<optgroup label="모바일/태블릿/SNS">
									<option value="501">아이패드</option>
									<option value="502">아이폰</option>
									<option value="503">안드로이드태블릿</option>
									<option value="504">안드로이드폰</option>
									<option value="505">트위터</option>
									<option value="506">페이스북</option>
									<option value="507">유튜브</option>
									<option value="508">앱가이드</option>
								</optgroup>
								<optgroup label="오피스 활용">
									<option value="601">한글</option>
									<option value="602">엑셀</option>
									<option value="603">파워포인트</option>
									<option value="604">워드</option>
									<option value="605">액세스</option>
									<option value="606">아웃룩</option>
									<option value="607">프레젠테이션</option>
									<option value="608">오피스</option>
								</optgroup>
								<optgroup label="웹사이트">
									<option value="701">HTML/JAVASCRIPT/CSS</option>
									<option value="702">웹디자인</option>
									<option value="703">웹기획</option>
									<option value="704">UI/UX</option>
									<option value="705">블로그/홈페이지</option>
								</optgroup>
								<optgroup label="인터넷 비즈니스">
									<option value="801">쇼핑몰/창업</option>
									<option value="802">인터넷 마케팅</option>
									<option value="803">공공정책/자료</option>
								</optgroup>
								<optgroup label="컴퓨터 공학">
									<option value="901">컴퓨터 교육</option>
									<option value="902">네트워크/데이터 통신</option>
									<option value="903">마이크로 프로세서</option>
									<option value="904">소프트웨어 공학</option>
									<option value="905">취미 공학</option>
									<option value="906">인공지능</option>
									<option value="907">컴퓨터구조</option>
									<option value="908">운영체제</option>
									<option value="909">데이터베이스</option>
									<option value="910">개발방법론</option>
									<option value="911">블록체인</option>
									<option value="912">자료구조/알고리즘</option>
									<option value="913">전산수학</option>
									<option value="914">정보통신</option>
								</optgroup>
								<optgroup label="컴퓨터 수험서">
									<option value="1001">컴퓨터활용능력</option>
									<option value="1002">워드프로세서</option>
									<option value="1003">그래픽 관련</option>
									<option value="1004">사무자동화</option>
									<option value="1005">DIAT</option>
									<option value="1006">ITQ</option>
									<option value="1007">MOS</option>
									<option value="1008">ICDL</option>
									<option value="1009">상공회의소</option>
									<option value="1010">정보처리/보안</option>
									<option value="1011">신규자격증/기타</option>
								</optgroup>
								<optgroup label="컴퓨터 입문/활용">
									<option value="1101">어른을 위한 컴퓨터</option>
									<option value="1102">어린이 컴퓨터</option>
									<option value="1103">윈도우 입문서/활용</option>
									<option value="1104">인터넷 입문서</option>
									<option value="1105">컴퓨터 조립/수리</option>
								</optgroup>
								<optgroup label="프로그래밍">
									<option value="1201">.NET</option>
									<option value="1202">JAVA</option>
									<option value="1203">PYTHON</option>
									<option value="1204">C</option>
									<option value="1205">C#</option>
									<option value="1206">C++</option>
									<option value="1207">JAVASCRIPT</option>
									<option value="1208">JSP</option>
									<option value="1209">PHP</option>
									<option value="1210">RUBY</option>
									<option value="1211">XML</option>
									<option value="1212">VB</option>
									<option value="1213">프로그래밍 교육</option>
								</optgroup>
								<optgroup label="OS/DB">
									<option value="1301">윈도우</option>
									<option value="1302">MAC</option>
									<option value="1303">리눅스</option>
									<option value="1304">유닉스</option>
									<option value="1305">Access</option>
									<option value="1306">MySQL</option>
									<option value="1307">ORACLE</option>
									<option value="1308">SQL Server</option>
									<option value="1309">클라우드/빅데이터</option>
									<option value="1310">시스템관리/서버</option>
								</optgroup>
							</select>
						</div>

						<hr>

						<div class="form-group">
							<label for="it_fixed_price">정가(원)</label>
							<input type="text" class="form-control col-5" id="it_fixed_price" name="it_fixed_price">
						</div>
						<div class="form-group">
							<label for="it_selling_price">판매가(원)</label>
							<input type="text" class="form-control col-5" id="it_selling_price" name="it_selling_price">
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
													<input type="date" class="form-control" id="it_pub_date" name="it_pub_date">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="page_number">쪽수</label>
													<input type="text" class="form-control col-5" id="it_page_number" name="it_page_number">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="weight">무게</label>
													<input type="text" class="form-control col-5" id="it_weight" name="it_weight">
												</div>
											</td>
											<td>
												<div class="form-group">
													<label for="size">크기(100/150/30mm 가로/세로/높이)</label>
													<input type="text" class="form-control col-5" id="it_size" name="it_size">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="isbn13">ISBN13</label>
													<input type="text" class="form-control col-7" id="it_isbn13" name="it_isbn13">
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="form-group">
													<label for="isbn10">ISBN10</label>
													<input type="text" class="form-control col-7" id="it_isbn10" name="it_isbn10">
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
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_book_introduction" id="it_book_introduction" rows="12"></textarea>
							</div>
						</div>
						<hr />
						<div>
							<div class="form-group">
								<label for="it_item_contents_table">목차</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_item_contents_table" id="it_item_contents_table" rows="12"></textarea>
							</div>
						</div>
						<hr />
						<div>
							<h6>상세 정보 사진 변경</h6>
							<img src="" id="info_img" alt="No Image" width="100%" />
							<input type="file" id="info_img_btn" name="info_img_btn" value="사진 추가" accept=".jpg, .jpeg, .png" multiple="multiple">
						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="btn_author">저자 정보</label>
								<input type="button" id="btn_author" class="btn btn-primary" data-target="#author_modal" data-toggle="modal" value="저자 정보 추가">
							</div>
						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="btn_publisher">출판사 정보</label>
								<input type="button" id="btn_publisher" class="btn btn-primary" data-target="#publisher_modal" data-toggle="modal" value="출판사 정보 추가">
							</div>
						</div>
						<hr>
						<div>
							<div class="form-group">
								<label for="it_item_publisher_review">출판사 리뷰</label>
								<textarea style="resize: none; word-break: break-all;" class="form-control" name="it_item_publisher_review" id="it_item_publisher_review" rows="12"></textarea>
							</div>
						</div>

						<hr>

					</div>
					<input type="submit" class="btn btn-primary" id="complete_registration_btn" name="complete_registration_btn" value="등록">

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
						<h5 class="modal-title" id="author_modal_title">저자 정보</h5>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<ul id="author_list" style="list-style: none; padding: 2px; margin: 2px;" class="list-group">
							<li id="author[]" class="list-group-item">
								<div class="form-row">
									<div class="form-group col-sm-6">
										<label for="au_author_code">저자 코드</label>
										<input type="text" class="form-control form-control-sm" id="au_author_code[]" name="au_author_code[]" readonly="readonly">
									</div>
									<div class="form-group col-sm-6">
										<label for="au_author_name">저자 명</label>
										<input type="text" class="form-control form-control-sm" id="au_author_name[]" name="au_author_name[]">
									</div>
									<div class="form-group col-sm-6">
										<label for="au_author_region">지역</label> <select id="au_author_region[]" name="au_author_region[]" class="form-control">
											<option value="d" selected="selected">국내</option>
											<option value="a">국외</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="au_author_desc">저자 소개</label>
									<textarea style="resize: none; word-break: break-all;" class="form-control form-control-sm" id="au_author_desc[]" name="au_author_desc[]" rows="3"></textarea>
								</div>
							</li>
						</ul>
						<br>
						<input type="button" class="btn btn-info btn-sm btn-block" onclick="addAuthor()" value="저자 추가">
						<hr>
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
							<div class="col-auto form-check form-check-inline">

								<input type="checkbox" class="form-check-input" id="checkbox_new_author" onclick="javascript:newAuthor(this)">
								<label class="form-check-label" for="checkbox_new_author">신규 추가</label>
							</div>
							<div class="col-auto">
								<input type="text" class="form-control form-control-sm" id="input_find_author_name">
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="getAuthors()">저자 조회</button>
							</div>

							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="checkRegion('au_author_region')" data-dismiss="modal">등록</button>
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
						<h5 class="modal-title" id="publisher_modal_title">출판사 정보</h5>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div>
							<div class="form-row">
								<div class="form-group col-sm-6">
									<label for="pu_publisher_code">출판사 코드</label>
									<input type="text" class="form-control form-control-sm" id="pu_publisher_code" name="pu_publisher_code" readonly="readonly">
								</div>
								<div class="form-group col-sm-6">
									<label for="pu_publisher_name">출판사 명</label>
									<input type="text" class="form-control form-control-sm" id="pu_publisher_name" name="pu_publisher_name">
								</div>
								<div class="form-group col-sm-6">
									<label for="pu_publisher_region">지역</label> <select id="pu_publisher_region" name="pu_publisher_region" class="form-control">
										<option value="d" selected="selected">국내</option>
										<option value="a">국외</option>
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
							<div class="col-auto form-check form-check-inline">
								<input type="checkbox" class="form-check-input" id="checkbox_new_publisher" onclick="javascript:newPublisher(this)">
								<label class="form-check-label" for="checkbox_new_publisher">신규 추가</label>
							</div>
							<div class="col-auto">
								<input type="text" class="form-control form-control-sm" id="input_find_publisher_name">
							</div>
							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="getPublishers()">출판사 조회</button>
							</div>

							<div class="col-auto">
								<button type="button" class="btn btn-primary" onclick="checkRegion('pu_publisher_region')" data-dismiss="modal">등록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<input type="hidden" id="publisher_status" name="publisher_status">
		<input type="hidden" id="author_status" name="author_status">
	</form>


	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>
	<script type="text/javascript">
		var authorList = [];
		var publisherList = [];
		var selectedAuthorIndex = 0;
		var selectedPublisherIndex = 0;
		var authorFormList = document.getElementById('author_list');

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

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
			document.getElementById('checkbox_new_author').checked = false;
			newAuthor('checkbox_new_author');

			let listLength = authorFormList.getElementsByTagName('li').length;

			let authorNameElements = document
					.getElementsByName('au_author_name[]');
			let authorRegionElements = document
					.getElementsByName('au_author_region[]');
			let authorDescElements = document
					.getElementsByName('au_author_desc[]');
			let authorCodeElements = document
					.getElementsByName('au_author_code[]');

			selectedAuthorIndex = index;

			let selectElement = authorRegionElements[listLength - 1];

			if ('d' == authorList[index]['author_region'])
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

			authorDescElements[listLength - 1].value = authorList[index]['author_desc'];
			authorNameElements[listLength - 1].value = authorList[index]['author_name'];
			authorCodeElements[listLength - 1].value = authorList[index]['author_code'];
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

			if (region != 'd' && region != 'a')
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
			document.getElementById('checkbox_new_publisher').checked = false;
			newPublisher('checkbox_new_publisher');

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

		function newAuthor(obj)
		{
			let authorNameElements = document
					.getElementsByName('au_author_name[]');
			let authorRegionElements = document
					.getElementsByName('au_author_region[]');
			let authorDescElements = document
					.getElementsByName('au_author_desc[]');
			let authorCodeElements = document
					.getElementsByName('au_author_code[]');

			let listLength = authorFormList.getElementsByTagName('li').length;

			if (obj.checked == true)
			{
				// 신규 추가
				for (let index = 0; index < listLength; ++index)
				{
					authorNameElements[index].readOnly = false;
					authorRegionElements[index].readOnly = false;
					authorDescElements[index].readOnly = false;

					authorCodeElements[index].value = '';
					authorNameElements[index].value = '';

					authorRegionElements[index].setAttribute('onFocus', '');
					authorRegionElements[index].setAttribute('onchange', '');

					authorDescElements[index].value = '';
				}
			} else
			{
				for (let index = 0; index < listLength; ++index)
				{
					authorNameElements[index].readOnly = true;
					authorDescElements[index].readOnly = true;

					authorRegionElements[index].setAttribute('onFocus',
							'this.initialSelect = this.selectedIndex;');
					authorRegionElements[index].setAttribute('onchange',
							'this.selectedIndex = this.initialSelect;');
				}
			}
		}

		function newPublisher(obj)
		{
			let publisherNameElement = document
					.getElementById('pu_publisher_name');
			let publisherRegionElement = document
					.getElementById('pu_publisher_region');
			let publisherCodeElement = document
					.getElementById('pu_publisher_code');

			if (obj.checked == true)
			{
				// 신규 추가
				publisherNameElement.readOnly = false;
				publisherRegionElement.readOnly = false;

				publisherCodeElement.value = '';
				publisherNameElement.value = '';

				publisherRegionElement.setAttribute('onFocus', '');
				publisherRegionElement.setAttribute('onchange', '');
			} else
			{
				publisherNameElement.readOnly = true;

				publisherRegionElement.setAttribute('onFocus',
						'this.initialSelect = this.selectedIndex;');
				publisherRegionElement.setAttribute('onchange',
						'this.selectedIndex = this.initialSelect;');
			}
		}

		function addAuthor()
		{
			const index = authorFormList.getElementsByTagName('li').length;

			const htmlElement = '<div class=\"form-row\">'
					+ '<div class=\"form-group col-sm-6\">'
					+ '<label for=\"au_author_code\">저자 코드</label>'
					+ '<input type=\"text\" class=\"form-control form-control-sm\" id=\"au_author_code[]\" name=\"au_author_code[]\" readonly=\"readonly\">'
					+ '</div>'
					+ '<div class=\"form-group col-sm-6\">'
					+ '<label for=\"au_author_name\">저자 명</label>'
					+ '<input type=\"text\" class=\"form-control form-control-sm\" id=\"au_author_name[]\" name=\"au_author_name[]\">'
					+ '</div>'
					+ '<div class=\"form-group col-sm-6\">'
					+ '<label for=\"au_author_region\">지역</label> <select id=\"au_author_region[]\" name=\"au_author_region[]\" class=\"form-control\">'
					+ '<option value=\"d\" selected=\"selected\">국내</option>'
					+ '<option value=\"a\">국외</option>'
					+ '</select>'
					+ '</div>'
					+ '</div>'
					+ '<div class=\"form-group\">'
					+ '<label for=\"au_author_desc\">저자 소개</label>'
					+ '<textarea style=\"resize: none; word-break: break-all;\" class=\"form-control form-control-sm\" id=\"au_author_desc[]\" name=\"au_author_desc[]\" rows=\"3\"></textarea>'
					+ '</div>'
					+ '<input type=\"button\" value=\"삭제\" class=\"btn btn-secondary\" onclick=\"javascript:this.parentNode.remove();\">';

			const newElement = document.createElement('li');
			newElement.setAttribute('class', 'list-group-item');
			newElement.setAttribute('id', 'author[]');
			newElement.innerHTML = htmlElement;
			authorFormList.appendChild(newElement);
		}
	</script>
</body>
</html>