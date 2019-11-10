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
							<th colspan="10">
								<strong>도서 목록</strong>&ensp; 표시할 데이터 개수 : <select class="custom-select custom-select-sm w-25" id="select_menu">
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="50">50</option>
								</select>
								<input type="button" data-target="#modal" data-toggle="modal" value="카테고리 선택">
								&nbsp;
								<input type="button" id="viewButton" onclick="processPage()" value="도서 조회">
								&nbsp;
								<input type="button" id="refreshButton" onclick="processPage()" value="새로고침">
							</th>
						</tr>
						<tr>
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

	<!--  Modal  -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_title">카테고리 선택</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-4">
							<div class="list-group" id="list-tab" role="tablist">
								<a class="list-group-item list-group-item-action" id="list-game-root" data-toggle="list" href="#list-game" role="tab" aria-controls="game">
									게임&ensp;
									<span id="checkbox_game_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-graphic-root" data-toggle="list" href="#list-graphic" role="tab" aria-controls="graphic">
									그래픽/디자인/멀티미디어&ensp;
									<span id="checkbox_graphic_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-network-root" data-toggle="list" href="#list-network" role="tab" aria-controls="network">
									네트워크/해킹/보안&ensp;
									<span id="checkbox_network_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-mobileprogramming-root" data-toggle="list" href="#list-mobileprogramming" role="tab" aria-controls="mobileprogramming">
									모바일 프로그래밍&ensp;
									<span id="checkbox_mobileprogramming_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-mobilesns-root" data-toggle="list" href="#list-mobilesns" role="tab" aria-controls="mobilesns">
									모바일/태블릿/SNS&ensp;
									<span id="checkbox_mobilesns_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-office-root" data-toggle="list" href="#list-office" role="tab" aria-controls="office">
									오피스 활용&ensp;
									<span id="checkbox_office_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-website-root" data-toggle="list" href="#list-website" role="tab" aria-controls="website">
									웹사이트&ensp;
									<span id="checkbox_website_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-business-root" data-toggle="list" href="#list-business" role="tab" aria-controls="business">
									인터넷 비즈니스&ensp;
									<span id="checkbox_business_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-computer-root" data-toggle="list" href="#list-computer" role="tab" aria-controls="computer">
									컴퓨터 공학&ensp;
									<span id="checkbox_computer_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-learningcomputer-root" data-toggle="list" href="#list-learningcomputer" role="tab" aria-controls="learingcomputer">
									컴퓨터 수험서&ensp;
									<span id="checkbox_learningcomputer_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-startcomputer-root" data-toggle="list" href="#list-startcomputer" role="tab" aria-controls="startcomputer">
									컴퓨터 입문/활용&ensp;
									<span id="checkbox_startcomputer_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-programming-root" data-toggle="list" href="#list-programming" role="tab" aria-controls="programming">
									프로그래밍 언어&ensp;
									<span id="checkbox_programming_badge" class="badge badge-primary badge-pill">0</span>
								</a>
								<a class="list-group-item list-group-item-action" id="list-osdb-root" data-toggle="list" href="#list-osdb" role="tab" aria-controls="osdb">
									OS/DB&ensp;
									<span id="checkbox_osdb_badge" class="badge badge-primary badge-pill">0</span>
								</a>
							</div>
						</div>
						<div class="col-8">
							<div class="tab-content" id="tab_content">
								<div class="tab-pane fade" id="list-game" role="tabpanel" aria-labelledby="list-game-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="101" id="checkbox_game_101" name="checkbox_game" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_game_101">게임 기획</label>
										<br>
										<input class="form-check-input" type="checkbox" value="102" id="checkbox_game_102" name="checkbox_game" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_game_102">게임 개발</label>
										<br>
										<input class="form-check-input" type="checkbox" value="103" id="checkbox_game_103" name="checkbox_game" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_game_103">게임 가이드북</label>
										<br>
										<input class="form-check-input" type="checkbox" value="104" id="checkbox_game_104" name="checkbox_game" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_game_104">모바일 게임</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-graphic" role="tabpanel" aria-labelledby="list-graphic-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="201" id="checkbox_graphic_201" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_201">3DS/MAX</label>
										<br>
										<input class="form-check-input" type="checkbox" value="202" id="checkbox_graphic_202" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_202">건축CG</label>
										<br>
										<input class="form-check-input" type="checkbox" value="203" id="checkbox_graphic_203" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_203">그래픽 일반/자료집</label>
										<br>
										<input class="form-check-input" type="checkbox" value="204" id="checkbox_graphic_204" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_204">그래픽 툴/저작 툴</label>
										<br>
										<input class="form-check-input" type="checkbox" value="205" id="checkbox_graphic_205" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_205">디렉터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="206" id="checkbox_graphic_206" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_206">라이트 룸</label>
										<br>
										<input class="form-check-input" type="checkbox" value="207" id="checkbox_graphic_207" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_207">베가스</label>
										<br>
										<input class="form-check-input" type="checkbox" value="208" id="checkbox_graphic_208" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_208">인 디자인</label>
										<br>
										<input class="form-check-input" type="checkbox" value="209" id="checkbox_graphic_209" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_209">일러스트레이터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="210" id="checkbox_graphic_210" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_210">캐틱터/애니메이션</label>
										<br>
										<input class="form-check-input" type="checkbox" value="211" id="checkbox_graphic_211" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_211">페인터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="212" id="checkbox_graphic_212" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_212">포토샵</label>
										<br>
										<input class="form-check-input" type="checkbox" value="213" id="checkbox_graphic_213" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_213">프리미어</label>
										<br>
										<input class="form-check-input" type="checkbox" value="214" id="checkbox_graphic_214" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_214">플래시</label>
										<br>
										<input class="form-check-input" type="checkbox" value="215" id="checkbox_graphic_215" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_215">애프터 이펙트</label>
										<br>
										<input class="form-check-input" type="checkbox" value="216" id="checkbox_graphic_216" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_216">오토 캐드</label>
										<br>
										<input class="form-check-input" type="checkbox" value="217" id="checkbox_graphic_217" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_217">멀티미디어/컴퓨터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="218" id="checkbox_graphic_218" name="checkbox_graphic" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_graphic_218">디지털 카메라</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-network" role="tabpanel" aria-labelledby="list-network-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="301" id="checkbox_network_301" name="checkbox_network" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_network_301">네트워크 일반</label>
										<br>
										<input class="form-check-input" type="checkbox" value="302" id="checkbox_network_302" name="checkbox_network" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_network_302">TCP/IP</label>
										<br>
										<input class="form-check-input" type="checkbox" value="303" id="checkbox_network_303" name="checkbox_network" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_network_303">보안/해킹</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-mobileprogramming" role="tabpanel" aria-labelledby="list-mobileprogramming-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="401" id="checkbox_mobileprogramming_401" name="checkbox_mobileprogramming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobileprogramming_401">아이폰</label>
										<br>
										<input class="form-check-input" type="checkbox" value="402" id="checkbox_mobileprogramming_402" name="checkbox_mobileprogramming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobileprogramming_402">안드로이드폰</label>
										<br>
										<input class="form-check-input" type="checkbox" value="403" id="checkbox_mobileprogramming_403" name="checkbox_mobileprogramming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobileprogramming_403">윈도우폰</label>
										<br>
										<input class="form-check-input" type="checkbox" value="404" id="checkbox_mobileprogramming_404" name="checkbox_mobileprogramming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobileprogramming_404">모바일 게임</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-mobilesns" role="tabpanel" aria-labelledby="list-mobilesns-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="501" id="checkbox_mobilesns_501" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_501">아이패드</label>
										<br>
										<input class="form-check-input" type="checkbox" value="502" id="checkbox_mobilesns_502" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_502">아이폰</label>
										<br>
										<input class="form-check-input" type="checkbox" value="503" id="checkbox_mobilesns_503" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_503">안드로이드 태블릿</label>
										<br>
										<input class="form-check-input" type="checkbox" value="504" id="checkbox_mobilesns_504" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_504">안드로이드 폰</label>
										<br>
										<input class="form-check-input" type="checkbox" value="505" id="checkbox_mobilesns_505" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_505">트위터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="506" id="checkbox_mobilesns_506" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_506">페이스북</label>
										<br>
										<input class="form-check-input" type="checkbox" value="507" id="checkbox_mobilesns_507" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_507">유튜브</label>
										<br>
										<input class="form-check-input" type="checkbox" value="508" id="checkbox_mobilesns_508" name="checkbox_mobilesns" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_mobilesns_508">앱 가이드</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-office" role="tabpanel" aria-labelledby="list-office-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="601" id="checkbox_office_601" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_601">한글</label>
										<br>
										<input class="form-check-input" type="checkbox" value="602" id="checkbox_office_602" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_602">엑셀</label>
										<br>
										<input class="form-check-input" type="checkbox" value="603" id="checkbox_office_603" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_603">파워 포인트</label>
										<br>
										<input class="form-check-input" type="checkbox" value="604" id="checkbox_office_604" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_604">워드</label>
										<br>
										<input class="form-check-input" type="checkbox" value="605" id="checkbox_office_605" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_605">액세스</label>
										<br>
										<input class="form-check-input" type="checkbox" value="606" id="checkbox_office_606" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_606">아웃룩</label>
										<br>
										<input class="form-check-input" type="checkbox" value="607" id="checkbox_office_607" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_607">프레젠테이션</label>
										<br>
										<input class="form-check-input" type="checkbox" value="608" id="checkbox_office_608" name="checkbox_office" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_office_608">오피스</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-website" role="tabpanel" aria-labelledby="list-website-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="701" id="checkbox_website_701" name="checkbox_website" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_website_701">HTML/JAVASCRIPT/CSS</label>
										<br>
										<input class="form-check-input" type="checkbox" value="702" id="checkbox_website_702" name="checkbox_website" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_website_702">웹 디자인</label>
										<br>
										<input class="form-check-input" type="checkbox" value="703" id="checkbox_website_703" name="checkbox_website" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_website_703">웹 기획</label>
										<br>
										<input class="form-check-input" type="checkbox" value="704" id="checkbox_website_704" name="checkbox_website" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_website_704">UI/UX</label>
										<br>
										<input class="form-check-input" type="checkbox" value="705" id="checkbox_website_705" name="checkbox_website" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_website_705">블로그/홈 페이지</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-business" role="tabpanel" aria-labelledby="list-business-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="801" id="checkbox_business_801" name="checkbox_business" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_business_801">쇼핑몰/창업</label>
										<br>
										<input class="form-check-input" type="checkbox" value="802" id="checkbox_business_802" name="checkbox_business" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_business_802">인터넷 마케팅</label>
										<br>
										<input class="form-check-input" type="checkbox" value="803" id="checkbox_business_803" name="checkbox_business" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_business_803">공공정책/자료</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-computer" role="tabpanel" aria-labelledby="list-computer-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="901" id="checkbox_computer_901" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_901">컴퓨터 교육</label>
										<br>
										<input class="form-check-input" type="checkbox" value="902" id="checkbox_computer_902" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_902">네트워크/데이터 통신</label>
										<br>
										<input class="form-check-input" type="checkbox" value="903" id="checkbox_computer_903" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_903">마이크로 프로세서</label>
										<br>
										<input class="form-check-input" type="checkbox" value="904" id="checkbox_computer_904" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_904">소프트웨어 공학</label>
										<br>
										<input class="form-check-input" type="checkbox" value="905" id="checkbox_computer_905" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_905">취미 공학</label>
										<br>
										<input class="form-check-input" type="checkbox" value="906" id="checkbox_computer_906" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_906">인공지능</label>
										<br>
										<input class="form-check-input" type="checkbox" value="907" id="checkbox_computer_907" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_907">컴퓨터 구조</label>
										<br>
										<input class="form-check-input" type="checkbox" value="908" id="checkbox_computer_908" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_908">운영체제</label>
										<br>
										<input class="form-check-input" type="checkbox" value="909" id="checkbox_computer_909" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_909">데이터베이스</label>
										<br>
										<input class="form-check-input" type="checkbox" value="910" id="checkbox_computer_910" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_910">개발 방법론</label>
										<br>
										<input class="form-check-input" type="checkbox" value="911" id="checkbox_computer_911" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_911">블록체인</label>
										<br>
										<input class="form-check-input" type="checkbox" value="912" id="checkbox_computer_912" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_912">자료구조/알고리즘</label>
										<br>
										<input class="form-check-input" type="checkbox" value="913" id="checkbox_computer_913" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_913">전산 수학</label>
										<br>
										<input class="form-check-input" type="checkbox" value="914" id="checkbox_computer_914" name="checkbox_computer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_computer_914">정보 통신</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-learningcomputer" role="tabpanel" aria-labelledby="list-learningcomputer-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="1001" id="checkbox_learningcomputer_1001" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1001">컴퓨터 활용능력</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1002" id="checkbox_learningcomputer_1002" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1002">워드 프로세서</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1003" id="checkbox_learningcomputer_1003" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1003">그래픽 관련</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1004" id="checkbox_learningcomputer_1004" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1004">사무자동화</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1005" id="checkbox_learningcomputer_1005" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1005">DIAT</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1006" id="checkbox_learningcomputer_1006" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1006">ITQ</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1007" id="checkbox_learningcomputer_1007" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1007">MOS</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1008" id="checkbox_learningcomputer_1008" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1008">ICDL</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1009" id="checkbox_learningcomputer_1009" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1009">상공회의소</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1010" id="checkbox_learningcomputer_1010" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1010">정보처리/보안</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1011" id="checkbox_learningcomputer_1011" name="checkbox_learningcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_learningcomputer_1011">신규자격증/기타</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-startcomputer" role="tabpanel" aria-labelledby="list-startcomputer-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="1101" id="checkbox_startcomputer_1101" name="checkbox_startcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_startcomputer_1101">어른을 위한 컴퓨터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1102" id="checkbox_startcomputer_1102" name="checkbox_startcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_startcomputer_1102">어린이 컴퓨터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1103" id="checkbox_startcomputer_1103" name="checkbox_startcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_startcomputer_1103">윈도우 입문서/활용</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1104" id="checkbox_startcomputer_1104" name="checkbox_startcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_startcomputer_1104">인터넷 입문서</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1105" id="checkbox_startcomputer_1105" name="checkbox_startcomputer" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_startcomputer_1105">컴퓨터 조립/수리</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-programming" role="tabpanel" aria-labelledby="list-programming-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="1201" id="checkbox_programming_1201" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1201">.NET</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1202" id="checkbox_programming_1202" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1202">JAVA</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1203" id="checkbox_programming_1203" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1203">PYTHON</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1204" id="checkbox_programming_1204" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1204">C</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1205" id="checkbox_programming_1205" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1205">C#</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1206" id="checkbox_programming_1206" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1206">C++</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1207" id="checkbox_programming_1207" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1207">JAVASCRIPT</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1208" id="checkbox_programming_1208" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1208">JSP</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1209" id="checkbox_programming_1209" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1209">PHP</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1210" id="checkbox_programming_1210" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1210">RUBY</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1211" id="checkbox_programming_1211" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1211">XML</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1212" id="checkbox_programming_1212" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1212">VB</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1213" id="checkbox_programming_1213" name="checkbox_programming" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_programming_1213">프로그래밍 교육</label>
									</div>
								</div>
								<div class="tab-pane fade" id="list-osdb" role="tabpanel" aria-labelledby="list-osdb-root">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="1301" id="checkbox_osdb_1301" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1301">윈도우</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1302" id="checkbox_osdb_1302" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1302">MAC</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1303" id="checkbox_osdb_1303" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1303">리눅스</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1304" id="checkbox_osdb_1304" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1304">유닉스</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1305" id="checkbox_osdb_1305" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1305">Access</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1306" id="checkbox_osdb_1306" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1306">MySQL</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1307" id="checkbox_osdb_1307" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1307">ORACLE</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1308" id="checkbox_osdb_1308" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1308">SQL Server</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1309" id="checkbox_osdb_1309" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1309">클라우드/빅데이터</label>
										<br>
										<input class="form-check-input" type="checkbox" value="1310" id="checkbox_osdb_1310" name="checkbox_osdb" onchange="changeBadge(this)">
										<label class="form-check-label" for="checkbox_osdb_1310">시스템 관리/서버</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer" id="modal_footer">
						<button type="button" class="btn btn-primary" onclick="makeJSONForCategory()" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		var bookList = [];
		var checkedCategoryList = [];

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

		function changeBadge(obj)
		{
			let checkboxes = document.getElementsByName(obj.name);
			let checkedNum = 0;

			for (let index = 0; index < checkboxes.length; index++)
			{
				if (checkboxes[index].checked == true)
				{
					++checkedNum;
				}
			}
			document.getElementById(obj.name + '_badge').innerText = checkedNum;
		}

		function setTableCol(bookData)
		{
			let tableBody = document.getElementById('tableBody');
			let index = tableBody.rows.length;
			let newRow = tableBody.insertRow(index);

			const bookObj =
			{
				'book_code' : bookData.BOOK.ITEM_CODE,
				'book_category_code' : bookData.BOOK.CATEGORY_CODE,
				'book_category_desc' : bookData.BOOK.CATEGORY_DESC,
				'book_name' : bookData.BOOK.ITEM_NAME,
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

		function initializeTable()
		{
			let tbody = document.getElementById('tableBody');

			if (tbody.rows.length != 0)
			{
				for (let index = tbody.rows.length - 1; index >= 0; --index)
				{
					tbody.deleteRow(index);
				}
			}
		}

		function referBookData()
		{
			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const responseDataList = JSON.parse(xhr.responseText);

					pageData['list_size'] = responseDataList.BOOKS.length;
					initializeTable();
					bookList = [];

					let listSize = pageData['list_size'];
					for (let index = 0; index < pageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							setTableCol(responseDataList.BOOKS[index]);
						}
					}
					setpaginationBar();
				}
			};

			xhr.open('POST', '/AspireStore/management/bookManagement.aspire',
					'true');
			xhr.setRequestHeader('Content-type', 'application/json');

			var typeObj =
			{
				type : 'GET_RECORDS'
			};
			checkedCategoryList.push(typeObj);
			xhr.send(JSON.stringify(checkedCategoryList));
			checkedCategoryList.pop();
		}

		function processPage()
		{
			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const totalRecords = Number(xhr.responseText);
					const numDataToDisplaySelect = document
							.getElementById('select_menu');

					pageData['total_record'] = totalRecords;
					pageData['num_per_page'] = numDataToDisplaySelect.options[numDataToDisplaySelect.selectedIndex].value;
					calcPageData();
					referBookData();
				}
			};
			xhr.open('POST', '/AspireStore/management/bookManagement.aspire',
					'true');
			xhr.setRequestHeader('Content-type', 'application/json');

			var typeObj =
			{
				type : 'GET_TOTAL_RECORDS'
			};
			checkedCategoryList.push(typeObj);
			xhr.send(JSON.stringify(checkedCategoryList));
			checkedCategoryList.pop();
		}

		function calcPageData()
		{
			pageData['begin_index'] = (pageData['current_page'] * pageData['num_per_page'])
					- pageData['num_per_page'];
			pageData['end_index'] = pageData['num_per_page'];
			pageData['total_page'] = parseInt(Math
					.ceil(parseFloat(pageData['total_record'])
							/ pageData['num_per_page']));
			pageData['current_block'] = parseInt(Math
					.ceil(parseFloat(pageData['current_page'])
							/ pageData['page_per_block']));
			pageData['total_block']
					- parseInt(Math.ceil(parseFloat(pageData['total_page'])
							/ pageData['page_per_block']));
		}

		function paging(num)
		{
			pageData['current_page'] = num;
			processPage();
		}

		function moveBlock(num)
		{
			pageData['current_page'] = pageData['page_per_block'] * (num - 1)
					+ 1;
			processPage();
		}

		function setPaginationBar()
		{
			let beginPage = ((pageData['current_block'] - 1) * pageData['page_per_block']) + 1;
			let endPage = ((beginPage + pageData['page_per_block']) <= pageData['total_page']) ? (beginPage + pageData['page_per_block'])
					: pageData['total_page'] + 1;

			const totalPage = pageData['total_page'];
			const totalBlock = pageData['total_block'];
			const currentPage = pageData['current_page'];
			const currentBlock = pageData['current_block'];

			let paginationElement = '';

			if (totalPage != 0)
			{
				if (currentBlock > 1)
				{
					// 이전 paginationElement
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"javascript:moveBlock(\''
							+ (currentBlock - 1)
							+ '\')\" tabindex=\"-1\" aria-disabled=\"true\">이전</a></li>';
				}
				while (beginPage < endPage)
				{
					if (beginPage == currentPage)
					{
						// 현재 페이지 active
						paginationElement += '<li class=\"page-item active\" aria-current=\"page\"><a class=\"page-link\" href=\"javascript:paging(\''
								+ beginPage
								+ '\')\">'
								+ beginPage
								+ '<span class=\"sr-only\">(현재 페이지)</span></a></li>';
					} else
					{
						// 1, 2, 3 버튼
						paginationElement += '<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(\''
								+ beginPage
								+ '\')\">'
								+ beginPage
								+ '</a></li>';
					}
					++beginPage;
				}
				if (totalBlock > currentBlock)
				{
					// 다음 버튼
					paginationElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"moveBlock('
							+ (currentBlock + 1) + ')\">다음</a></li>';
				}
			}
			document.gelElementById('pagination_ul').innerHTML = paginationElement;
		}

		function makeJSONForCategory()
		{
			const tabContent = document.getElementById('tab_content');
			const inputTags = tabContent.getElementsByTagName('input');
			checkedCategoryList = [];
			let dataMap = new Map();
			let sequence = 0;

			for (let index = 0; index < inputTags.length; ++index)
			{
				if (dataMap.get('tag_name_' + String(sequence - 1)) == inputTags[index].name)
				{
					continue;
				} else
				{
					dataMap.set("tag_name_" + String(sequence++),
							inputTags[index].name);
				}
			}

			for (let index = 0; index < dataMap.size; ++index)
			{
				const category = document.getElementsByName(dataMap
						.get('tag_name_' + String(index)));
				const checkedList = [];
				for (let j = 0; j < category.length; ++j)
				{
					if (category[j].checked == true)
					{
						checkedList.push(category[j].value);
					}
				}
				const rootObj = new Object();
				rootObj[String(index * 100 + 100)] = checkedList;
				checkedCategoryList.push(rootObj);
			}
			let jsonData = JSON.stringify(checkedCategoryList);
			return jsonData;
		}
	</script>
</body>
</html>