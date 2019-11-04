<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
	<div class="container-fluid">
		<strong><a class="navbar-brand">판매자 사이트</a></strong>

		<button class="btn btn-primary" id="menu-toggle">사이드 메뉴</button>

		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">

			<ul class="navbar-nav ml-auto mt-2 mt-lg-0">

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 도서 관리 </a>

					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">신규 도서 등록</a>
						<a class="dropdown-item" href="#">도서 수정</a>
						<a class="dropdown-item" href="#">도서 삭제</a>
						<a class="dropdown-item" href="#">도서 재고 관리</a>
						<div class="dropdown-divider"></div>
					</div>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 주문 관리 </a>

					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/AspireStore/management/ordermanagement/unprocessedorder.jsp">미 처리 주문</a>
						<a class="dropdown-item" href="#">처리된 주문</a>
						<a class="dropdown-item" href="#">주문 취소</a>
						<a class="dropdown-item" href="#">배송</a>
					</div>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 문의/답변 </a>

					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/AspireStore/management/qnamanagement/questionlist.jsp">문의 목록</a>
						<a class="dropdown-item" href="/AspireStore/management/qnamanagement/answerlist.jsp">답변 목록</a>
						<a class="dropdown-item" href="#">문의 통계</a>
					</div>
				</li>

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 매출 관리 </a>

					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">판매 순위</a>
						<a class="dropdown-item" href="#">정산</a>
					</div>
				</li>
			</ul>
		</div>
	</div>

</nav>