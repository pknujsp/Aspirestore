<%@page import="java.util.HashMap"%>
<%@page import="model.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	QnaDTO question = (QnaDTO) request.getAttribute("QUESTION_POST_DATA");
	@SuppressWarnings("unchecked")
	HashMap<String, Integer> pageData = (HashMap<String, Integer>) request.getAttribute("QUESTION_PAGE_DATA");

	pageContext.setAttribute("QUESTION_POST_DATA", question);
	pageContext.setAttribute("QUESTION_PAGE_DATA", pageData);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />

	<div class="container-fluid">
		<form id="question_form" name="question_form" method="get" action="/AspireStore/csservice/qna.aspire">
			<table class="table table-borderless">
				<tr>
					<th>제목</th>
					<td>
						<c:out value="${pageScope.QUESTION_POST_DATA.subject }" />
					</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td>
						<c:out value="${pageScope.QUESTION_POST_DATA.category_desc}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<pre>
						<c:out value="${pageScope.QUESTION_POST_DATA.content }" />
					</pre>
					</td>
				</tr>
				<tr>
					<th>답변상태</th>
					<td>
						<c:out value="${pageScope.QUESTION_POST_DATA.status }" />
					</td>
				</tr>
				<tr>
					<th>처리</th>
					<td>
						<c:if test="${pageScope.QUESTION_PAGE_DATA.answer_code != null }">
							<input type="button" id="answerBtn" name="answerBtn" value="답변보기">
							<input type="hidden" id="answerCode" name="answerCode" value="${pageScope.QUESTION_PAGE_DATA.answer_code }">&nbsp;
					</c:if>
						<input type="button" id="listBtn" name="listBtn" value="목록" onclick="moveToRecordList()"> <input type="hidden" name="type" id="type" value=""> <input type="hidden" name="current_page" id="current_page" value="${pageScope.QUESTION_PAGE_DATA.current_page }">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<jsp:include page="/footer.html" />

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		function moveToRecordList()
		{
			document.question_form.type.value = "GET_QUESTION_LIST";
			document.question_form.submit();
		}

		function moveToAnswerPage()
		{
			document.question_form.type.value = "GET_ANSWER_POST";
			document.question_form.submit();
		}
	</script>
</body>
</html>