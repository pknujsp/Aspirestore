<%@page import="java.util.HashMap"%>
<%@page import="model.QnaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	@SuppressWarnings("unchecked")
	ArrayList<QnaDTO> questionList = (ArrayList<QnaDTO>) request.getAttribute("QUESTION_LIST");
	@SuppressWarnings("unchecked")
	HashMap<String, Integer> pageData = (HashMap<String, Integer>) request.getAttribute("PAGE_DATA");

	pageContext.setAttribute("QUESTION_LIST", questionList);
	pageContext.setAttribute("PAGE_DATA", pageData);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>

	<div class="container-fluid">
		<div>
			<table class="table table-sm table-hover">
				<thead class="thead-light">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록날짜</th>
						<th scope="col">처리 상태</th>
						<!-- 답변여부 -->
					</tr>
				</thead>
				<tbody id="question_tbody">
					<c:forEach var="postData" items="${pageScope.QUESTION_LIST}" varStatus="status">
						<tr>
							<td>
								<c:out value="${pageScope.PAGE_DATA['total_record']-((pageScope.PAGE_DATA['current_page']-1)*pageScope.PAGE_DATA['num_per_page'])-status.index}" />
							</td>
							<td>
								<a href="/AspireStore/csservice/qna.aspire?type=GET_QUESTION_POST&question_code=${postData.question_code }&current_page=${pageScope.PAGE_DATA['current_page']}">
									<c:out value="${postData.subject}" />
								</a>
							</td>
							<td>
								<c:out value="${postData.post_date}" />
							</td>
							<td>
								<c:out value="${postData.status}" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

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

			<form action="/AspireStore/csservice/qna.aspire" method="GET" id="pagination_form" name="pagination_form">
				<input type="hidden" name="type" id="type" value="GET_QUESTION_LIST"> <input type="hidden" name="current_page" id="current_page" value="">
			</form>
		</div>
	</div>

	<jsp:include page="/footer.html" />

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		var questionList = [];
		var pageData =
		{
			'total_page' : 0,
			'total_block' : 0,
			'num_per_page' : 10,
			'page_per_block' : 5,
			'list_size' : 0,
			'total_record' : 0, //전체 레코드 수
			'current_page' : 1, // 현재 페이지
			'current_block' : 1, //현재 블럭
			'begin_index' : 0, //QUERY select 시작번호
			'end_index' : 0
		//시작번호로 부터 가져올 레코드 갯수
		};

		function setQuestionTable()
		{
			let dataToBeSended = 'type=GET_QUESTION_LIST_SIZE&user_id='
					+ '\'${pageScope.USER_ID}\'';

			let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					// 전체 레코드의 개수를 가져온다.
					var listSize = Number(xhr.responseText);
					calcPageData(listSize);
					getQuestionList();
				}
			};

			xhr.open('POST', '/AspireStore/question/questionmanagement.aspire',
					true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send(dataToBeSended);
		}

		function getQuestionList()
		{
			let dataToBeSended = 'type=GET_QUESTION_LIST&user_id='
					+ '\'${pageScope.USER_ID}\'';

			let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					// JSON으로 받은 문의사항 포스트 리스트
					const list = JSON.parse(xhr.responseText);
					const listSize = list.QUESTIONS.length;
					pageData['list_size'] = listSize;

					questionList = [];

					for (let index = 0; index < pageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							setQuestionList(list.QUESTIONS_LIST[index].QUESTION_DATA);
						}
					}
					setPaginationBar();
				}
			};

			xhr.open('POST', '/AspireStore/question/questionmanagement.aspire',
					true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send(dataToBeSended);
		}

		function calcPageData(listSize)
		{
			pageData['total_record'] = listSize;

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

		function setQuestionList(list)
		{
			let questionData = new Object(); // 문의글 객체
			let tBody = document.getElementById('question_tbody');
			let index = tBody.rows.length;
			let newRow = tBody.insertRow(index);

			let subjectCol = newRow.insertCell(0); // 제목 열
			let postDateCol = newRow.insertCell(1); // 등록 날짜 열 
			let statusCol = newRow.insertCell(2); // 답변 상태 열

			let subjectElement = document.createElement('a');
			subjectElement.setAttribute('href',
					'/AspireStore/csservice/questionmanagement.aspire');
			subjectCol.appendChild(subjectElement);
			subjectElement.innerHTML = list.SUBJECT;

			postDateCol.innerHTML = list.POST_DATE;
			statusCol.innerHTML = list.STATUS;

			questionData['QUESTION_CODE'] = list.SUBJECT;
			questionData['USER_ID'] = list.POST_DATE;
			questionData['SUBJECT'] = list.STATUS;
			questionData['CATEGORY_CODE'] = list.CATEGORY_CODE;
			questionData['STATUS'] = list.STATUS;

			questionList.push(questionData);
		}

		function paging(num)
		{
			document.pagination_form.current_page.value = Number(num);
			document.pagination_form.submit();
		}

		function moveBlock(num)
		{
			document.pagination_form.current_page.value =  ${pageScope.PAGE_DATA['page_per_block']} * (Number(num) - 1) + 1;
			document.pagination_form.submit();
		}
	</script>
</body>
</html>

