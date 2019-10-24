<%@page import="model.OrderhistoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// 매니저의 아이디
	final String managerId = session.getAttribute("SESSIONKEY").toString();

	int totalRecord = 0; // 전체 레코드 개수
	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 0; // 전체 블록의 수
	int recordNumPerPage = 10; // 페이지당 레코드의  수
	int pageNumPerBlock = 10; // 블록 당 페이지의 수

	int currentPage = 1; // 현제 페이지 번호
	int currentBlock = 1; // 현재 블록 번호

	int startIndex = (currentPage * recordNumPerPage) - recordNumPerPage; // 시작 인덱스
	int endIndex = recordNumPerPage; // 마지막 인덱스

	int listSize = 0; // 미 처리된 주문의 레코드 개수

	ArrayList<OrderhistoryDTO> orderList = null; // 주문 목록

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미 처리된 주문</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">

</head>
<body>


	<div class="d-flex" id="wrapper">

		<div class="bg-light border-right" id="sidebar-wrapper">
			<!-- <div class="sidebar-heading">Start Bootstrap</div> -->
			<div class="list-group list-group-flush">
				<a href="#" class="list-group-item list-group-item-action bg-light">미 처리된 주문</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">처리된 주문</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">주문 취소</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">발송</a>
			</div>
		</div>


		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>
			<div class="container-fluid">
				<table class="table">

					<thead>
						<tr>
							<th>
								<button type="button">모두 선택</button>
							</th>
							<th>주문코드</th>
							<th>주문자 ID</th>
							<th>
								<em>주문 도서</em>
							</th>
							<th>
								<button type="button">주문자 정보</button>
							</th>
							<th>
								<button type="button">수령자 정보</button>
							</th>
							<th>
								<button type="button">배송지 정보</button>
							</th>
							<th>
								<button type="button">요청 사항</button>
							</th>
							<th>최종 결제 금액</th>
							<th>결제 수단</th>
							<th>배송 방법</th>
							<th>주문 날짜</th>
							<th>주문 처리 상태</th>
							<th>처리</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="">
							<form id="unprocessedOrderForm" name="unprocessedOrderForm" method="post">
								<c:forEach var="" items="" varStatus="status">
									<tr>
										<td>
											<input type="checkbox" id="orderCheckBox" name="orderCheckBox" value="">
										</td>
										<td>
											<c:out value=""></c:out>
											<input type="hidden" id="orderCodeArr[]" name="orderCodeArr[]" value="">
										</td>
										<td>
											<c:out value=""></c:out>
											<input type="hidden" id="userIdArr[]" name="userIdArr[]" value="">
										</td>
										<td>
											<button type="button">주문 도서</button>
										</td>
										<td>
											<button type="button">주문자 정보</button>
										</td>
										<td>
											<button type="button">수령자 정보</button>
										</td>
										<td>
											<button type="button">배송지 정보</button>
										</td>
										<td>
											<button type="button">요청 사항</button>
										</td>
										<td>
											<c:out value=""></c:out>
										</td>
										<td>
											<c:out value=""></c:out>
										</td>
										<td>
											<c:out value=""></c:out>
										</td>
										<td>
											<c:out value=""></c:out>
										</td>
										<td>
											<c:out value=""></c:out>
										</td>
										<td>
											<div>
												<div>
													<button type="button">발송 완료</button>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</form>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="/AspireStore/jquery/jquery.min.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.min.js"></script>

	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	</script>
</body>
</html>