<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 목록</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">

</head>
<body>
	<div class="d-flex" id="wrapper">
		<div class="bg-light border-right" id="sidebar-wrapper">
			<!-- <div class="sidebar-heading">Start Bootstrap</div> -->
			<div class="list-group list-group-flush">
				<a href="#" class="list-group-item list-group-item-action bg-light">문의 목록</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">답변 목록</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">문의 통계</a>
			</div>
		</div>

		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>

			<div class="container-fluid">
				<table class="table table-sm table-hover">
					<thead class="thead-light">
						<tr>
							<th colspan="2">
								<h5>
									답변 목록&nbsp;
									<input type="button" id="refreshButton" onclick="setDataTable()" value="새로고침">
								</h5>
							</th>
							<th colspan="5">
								표시할 데이터 개수 : <select class="custom-select custom-select-sm w-25" id="select_menu">
									<option value="2">2</option>
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="50">50</option>
								</select> &nbsp;
								<input type="button" id="viewButton" onclick="setDataTable()" value="데이터 조회">
								&nbsp;
								<input type="button" id="processingButton" onclick="preProcessCheckedOrderShipment()" data-toggle="modal" data-target="#modal" value="처리">
							</th>
						</tr>
						<tr>
							<th scope="col">답변글 코드</th>
							<th scope="col">문의글 코드</th>
							<th scope="col">문의자(고객) ID</th>
							<th scope="col">답변글 제목</th>
							<th scope="col">카테고리</th>
							<th scope="col">답변 날짜</th>
							<th scope="col">처리</th>
						</tr>
					</thead>
					<tbody id="tableBody">

					</tbody>
				</table>

				<form id="data_form" name="data_form" action="/AspireStore/csservice/qna.aspire" method="post">
					<input type="hidden" id="questioner_id" name="questioner_id" value="">
					<input type="hidden" id="question_code" name="question_code" value="">
					<input type="hidden" id="answer_code" name="answer_code" value="">
				</form>

				<nav aria-label="PaginationBar">
					<ul class="pagination justify-content-center" id="pagination_ul">

					</ul>
				</nav>

			</div>
		</div>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		var tableDataList = [];

		var pageData =
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

		(function()
		{
			setDataTable();
		})();

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function precessTagValues(list)
		{
			var postData = new Object(); // 글 정보 객체(리스트에 저장됨)
			let tBody = document.getElementById('tableBody');
			let index = tBody.rows.length;
			let newTableRow = tBody.insertRow(index);

			let answerCodeCol = newTableRow.insertCell(0); // 답변글 코드
			let questionCodeCol = newTableRow.insertCell(1); // 문의글 코드
			let questionerIdCol = newTableRow.insertCell(2); // 질문자 ID
			let subjectCol = newTableRow.insertCell(3); // 제목
			let categoryCol = newTableRow.insertCell(4); // 카테고리
			let postDateCol = newTableRow.insertCell(5); // 답변 날짜 
			let processingCol = newTableRow.insertCell(6); //처리

			// 처리 버튼 생성
			var processingButton = document.createElement('input');
			processingButton.setAttribute('type', 'button');
			processingButton.setAttribute('onclick', 'javascript:getPost('
					+ index + ')');
			processingButton.setAttribute('value', '문의/답변 보기');

			processingCol.appendChild(processingButton);

			var questionData =
			{
				'questioner_id' : list.QUESTION['questioner_id'],
				'question_code' : list.QUESTION['question_code']
			};

			questionerIdCol.innerHTML = list.QUESTION['questioner_id'];
			questionCodeCol.innerHTML = list.QUESTION['question_code'];
			postData['question_data'] = questionData;

			// 요청사항 정보를 tableDataList에 객체로 저장한다.
			var answerData =
			{
				'subject' : list.ANSWER['subject'],
				'category' : list.ANSWER['category'],
				'post_date' : list.ANSWER['post_date'],
				'answer_code' : list.ANSWER['answer_code']
			};
			subjectCol.innerHTML = list.ANSWER['subject'];
			categoryCol.innerHTML = list.ANSWER['category'];
			postDateCol.innerHTML = list.ANSWER['post_date'];
			answerCodeCol.innerHTML = list.ANSWER['answer_code'];

			postData['answer_data'] = answerData;

			tableDataList.push(postData);
		}

		function initializePageTable()
		{
			let pageTbody = document.getElementById('tableBody');

			// 테이블 행의 길이가 0이면 지우지 않음
			if (pageTbody.rows.length != 0)
			{
				for (let index = pageTbody.rows.length - 1; index >= 0; --index)
				{
					pageTbody.deleteRow(index);
				}
			}
		}

		function referData()
		{
			// 페이지 당 레코드의 수
			var xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const responseList = JSON.parse(xhr.responseText);

					pageData['list_size'] = responseList.POST_DATA.length;
					initializePageTable();

					// 데이터 리스트 초기화
					tableDataList = [];

					let listSize = pageData['list_size'];
					for (let index = 0; index < pageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							precessTagValues(responseList.POST_DATA[index]);
						}
					}
					setPaginationBar();
				}
			};
			xhr.open('POST', '/AspireStore/csservice/qna.aspire', true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send('type=' + 'GET_ANSWER_LIST' + '&begin_index='
					+ pageData['begin_index'] + '&end_index='
					+ pageData['end_index']);
		}

		function calcPageData()
		{
			let beginIndex = pageData['begin_index'];
			let endIndex = pageData['end_index'];
			let numPerPage = pageData['num_per_page'];
			let totalRecord = pageData['total_record'];
			let currentPage = pageData['current_page'];
			let pagePerBlock = pageData['page_per_block'];

			pageData['begin_index'] = (currentPage * numPerPage) - numPerPage;
			pageData['end_index'] = numPerPage;
			pageData['total_page'] = parseInt(Math.ceil(parseFloat(totalRecord)
					/ numPerPage));
			pageData['current_block'] = parseInt(Math
					.ceil(parseFloat(currentPage) / pagePerBlock));

			let totalPage = pageData['total_page'];

			pageData['total_block'] = parseInt(Math.ceil(parseFloat(totalPage)
					/ pagePerBlock));
		}

		function paging(num)
		{
			pageData['current_page'] = Number(num);
			setDataTable();
		}

		function moveBlock(num)
		{
			pageData['current_page'] = pageData['page_per_block']
					* (Number(num) - 1) + 1;
			setDataTable();
		}

		function setPaginationBar()
		{
			let pageBegin = ((pageData['current_block'] - 1) * pageData['page_per_block']) + 1;
			let pageEnd = ((pageBegin + pageData['page_per_block']) <= pageData['total_page']) ? (pageBegin + pageData['page_per_block'])
					: pageData['total_page'] + 1;

			const totalPage = pageData['total_page'];
			const totalBlock = pageData['total_block'];
			const currentBlock = pageData['current_block'];
			const currentPage = pageData['current_page'];

			let newElement = '';

			if (totalPage != 0)
			{
				if (currentBlock > 1)
				{
					// 이전 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"javascript:moveBlock(\''
							+ String(currentBlock - 1)
							+ '\')\" tabindex=\"-1\" aria-disabled=\"true\">이전</a></li>';
				}
				while (pageBegin < pageEnd)
				{
					if (pageBegin == currentPage)
					{
						// 현재 페이지 active
						newElement += '<li class=\"page-item active\" aria-current=\"page\"><a class=\"page-link\" href=\"javascript:paging(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '<span class=\"sr-only\">(현재 페이지)</span></a></li>';
					} else
					{
						// 1, 2, 3 버튼
						newElement += '<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(\''
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
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"moveBlock('
							+ currentBlock + 1 + ')\">다음</a></li>';
				}
			}
			document.getElementById('pagination_ul').innerHTML = newElement;
		}

		function setDataTable()
		{
			let xhrForSize = new XMLHttpRequest();

			xhrForSize.onreadystatechange = function()
			{
				if (xhrForSize.readyState == XMLHttpRequest.DONE
						&& xhrForSize.status == 200)
				{
					var recordsSize = Number(xhrForSize.responseText.toString());
					var selectMenu = document.getElementById('select_menu');

					pageData['total_record'] = recordsSize;
					pageData['num_per_page'] = selectMenu.options[selectMenu.selectedIndex].value;
					calcPageData();
					referData();
				}
			};
			xhrForSize.open('POST', '/AspireStore/csservice/qna.aspire', true);
			xhrForSize.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrForSize
					.send('type=' + 'GET_RECORDS_SIZE' + '&table_type=' + 'ANSWER');
		}

		function getPost(index)
		{
			document.data_form.questioner_id.value = tableDataList[index].question_data['questioner_id'];
			document.data_form.question_code.value = tableDataList[index].question_data['question_code'];
			document.data_form.answer_code.value = tableDataList[index].answer_data['answer_code'];

			document.data_form.submit();
		}
	</script>
</body>
</html>