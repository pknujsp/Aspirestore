<%@page import="etc.OrderInformation"%>
<%@page import="model.AuthorDTO"%>
<%@page import="model.ItemsDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");

	ItemsDTO item = (ItemsDTO) request.getAttribute("ITEM");
	AuthorDTO author = (AuthorDTO) request.getAttribute("AUTHOR");
	OrderInformation information = new OrderInformation();

	information.setItem_code(item.getItem_code());
	information.setItem_category(item.getItem_category_code());
	information.setItem_price(item.getItem_selling_price());

	request.setAttribute("orderInformation", information);
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title><%=item.getItem_name()%></title>

<!-- Bootstrap core CSS -->
<link href="../css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../css/shop-homepage.css" rel="stylesheet">

</head>
<body>
	<script>
		function goToMainPage() {
			location.href = '../index.jsp';
		}

		function clickButton(uri) {
			var paymentForm = document.createElement('form');

			paymentForm.setAttribute('method', 'Post');
			paymentForm.setAttribute('action', uri);

			var quantity = document.getElementById('quantity').value;

			var quantityField = document.createElement('input');
			quantityField.setAttribute('type', 'hidden');
			quantityField.setAttribute('name', 'quantity');
			quantityField.setAttribute('value', quantity);


			paymentForm.appendChild(quantityField);
			document.body.appendChild(paymentForm);
			paymentForm.submit();

		}
	</script>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
		style="background: rgba(255, 255, 255, 0.7);">
		<div class="container-fluid">

			<strong><a class="navbar-brand"
				href="javascript:goToMainPage()">Aspire Store</a></strong>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="dropdown">

				<button class="btn btn-secondary btn-sm dropdown-toggle"
					type="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">전체 분류</button>

				<ul class="dropdown-menu multi-level" aria-labelledby="dropdownMenu">

					<li class="dropdown-submenu"><a href="itemlist.jsp?ccode=100"
						tabindex="0" class="dropdown-header dropdown-submenu">게임</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">게임 기획</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">게임 개발</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">게임 가이드북</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">모바일 게임</a>
						</ul></li>

					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=200" tabindex="1"
						class="dropdown-header dropdown-submenu">그래픽/디자인/멀티미디어</a>

						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">3DS/MAX</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">건축CG</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">그래픽일반/자료집</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">그래픽툴/저작툴</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">디렉터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">라이트룸</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">베가스</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">인디자인</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">일러스트레이터</a>
							<li><a class="dropdown-item" href="itemlist.jsp">캐릭터/애니메이션</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">페인터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">포토샵</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">프리미어</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">플래시</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">애프터 이펙트</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">오토캐드</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">멀티미디어/컴퓨터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">디지털 카메라</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=300" tabindex="2"
						class="dropdown-header dropdown-submenu">네트워크/해킹/보안</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">네트워크 일반</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">TCP/IP</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">보안/해킹</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=200" tabindex="3"
						class="dropdown-header dropdown-submenu"> 모바일 프로그래밍</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">아이폰</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">안드로이드폰</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">윈도우폰</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">모바일 게임</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=400" tabindex="3"
						class="dropdown-header dropdown-submenu">모바일/태블릿/SNS</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">아이패드</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">아이폰</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">안드로이드태블릿</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">안드로이드폰</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">트위터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">페이스북</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">유튜브</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">앱가이드</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=500" tabindex="4"
						class="dropdown-header dropdown-submenu">오피스 활용</a>
						<ul class="dropdown-menu">

							<li><a class="dropdown-item" href="itemlist.jsp">한글</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">엑셀</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">파워포인트</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">워드</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">액세스</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">아웃룩</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">프레젠테이션</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">오피스</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=600" tabindex="5"
						class="dropdown-header dropdown-submenu">웹사이트</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">HTML/JAVASCRIPT/CSS</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">웹디자인</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">웹기획</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">UI/UX</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">블로그/홈페이지</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=700" tabindex="6"
						class="dropdown-header dropdown-submenu">인터넷 비즈니스</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">쇼핑몰/창업</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">인터넷 마케팅</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">공공정책/자료</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=800" tabindex="7"
						class="dropdown-header dropdown-submenu">컴퓨터 공학</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">컴퓨터 교육</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">네트워크/데이터
									통신</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">마이크로
									프로세서</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">소프트웨어
									공학</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">취미 공학</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">인공지능</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">컴퓨터구조</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">운영체제</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">데이터베이스</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">개발방법론</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">블록체인</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">자료구조/알고리즘</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">전산수학</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">정보통신</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=900" tabindex="8"
						class="dropdown-header dropdown-submenu">컴퓨터 수험서</a>
						<ul class="dropdown-menu">

							<li><a class="dropdown-item" href="itemlist.jsp">컴퓨터활용능력</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">워드프로세서</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">그래픽 관련</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">사무자동화</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">DIAT</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">ITQ</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">MOS</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">ICDL</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">상공회의소</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">정보처리/보안</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">신규자격증/기타</a></li>

						</ul></li>

					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=1000" tabindex="9"
						class="dropdown-header dropdown-submenu"> 컴퓨터 입문/활용</a>
						<ul class="dropdown-menu">

							<li><a class="dropdown-item" href="itemlist.jsp">어른을 위한
									컴퓨터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">어린이 컴퓨터</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">윈도우
									입문서/활용</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">인터넷 입문서</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">컴퓨터
									조립/수리</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=1100" tabindex="10"
						class="dropdown-header dropdown-submenu">프로그래밍 언어</a>

						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">.NET</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">JAVA</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">PYTHON</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">C</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">C#</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">C++</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">JAVASCRIPT</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">JSP</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">PHP</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">RUBY</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">XML</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">VB</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">프로그래밍
									교육</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=1200" tabindex="11"
						class="dropdown-header dropdown-submenu">OS/DB</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">윈도우</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">MAC</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">리눅스</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">유닉스</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">Access</a>
							</li>
							<li><a class="dropdown-item" href="itemlist.jsp">MySQL</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">ORACLE</a>
							</li>
							<li><a class="dropdown-item" href="itemlist.jsp">SQL
									Server</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">클라우드/빅데이터</a>
							</li>
							<li><a class="dropdown-item" href="itemlist.jsp">시스템관리/서버</a>
							</li>

						</ul></li>
				</ul>

			</div>

			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">

					<%
						if (sessionKey != null) {
					%>
					<li class="nav-item"><a class="nav-link disabled"><i><%=sessionKey.toString()%></i></a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="/AspireStore/logout">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="#">나의
							Aspire</a></li>

					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link" href="../signin.jsp">로그인</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="../signup.jsp">회원가입</a>
					</li>
					<%
						}
					%>


					<li class="nav-item"><a class="nav-link" href="#">고객센터</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품 문의</a></li>
					<li class="nav-item"><a class="nav-link" href="#">장바구니</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<br>


	<div class="container border border-info">
		<div>
			<span> <img src="/AspireStore/images/ReactBookImage.jpg"
				alt="No Image" border="0" style="width: 40%; height: auto;" /><span>
			</span>
			</span>
		</div>

		<div>
			<h4><%=item.getItem_name()%></h4>
		</div>

		<span> <span><a href="#" target="_blank"><%=author.getAuthor_name()%></a></span>
			<em>|</em> <span><a href="#" target="_blank">길벗</a></span> <em>|</em>
			<span><%=item.getItem_publication_date()%></span>
		</span>

		<div>
			<table>
				<colgroup>
					<col width="110" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">정가</th>
						<td><span><%=item.getItem_fixed_price()%></span></td>
					</tr>

					<tr>
						<th scope="row">판매가</th>
						<td><span><%=item.getItem_selling_price()%></span></td>
					</tr>
				</tbody>
			</table>


		</div>

		<div>

			<span> <input type="number" name="quantity" id="quantity"
				value="1" min="1" />
			</span> <span> <a class="btn btn-primary"
				href="javascript:clickButton('/AspireStore/cart.aspire')"
				role="button">장바구니에 추가</a>
			</span> <span> <a class="btn btn-primary"
				href="javascript:clickButton('/AspireStore/orderform.aspire')"
				role="button">바로 구매</a>
			</span>

		</div>



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
								<td><%=item.getItem_publication_date()%></td>
							</tr>
							<tr>
								<th scope="row">쪽수, 무게, 크기</th>
								<td><%=item.getItem_page_number()%> , <%=item.getItem_weight()%>
									, <%=item.getItem_size()%></td>
							</tr>
							<tr>
								<th scope="row">ISBN13</th>
								<td><%=item.getItem_isbn13()%></td>
							</tr>
							<tr>
								<th scope="row">ISBN10</th>
								<td><%=item.getItem_isbn10()%></td>
							</tr>
					</table>
				</div>
			</div>

		</div>

		<div>
			<div>
				<h4>도서 소개</h4>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_book_introduction()%>
					</pre>
				</div>
			</div>

		</div>


		<div>
			<div>
				<h4>목차</h4>
			</div>
			<div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_contents_table()%>
					</pre>
				</div>
			</div>
		</div>

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

		<div>
			<div>
				<h4>저자 소개</h4>
			</div>
			<div>
				<div>
					<div>
						저자 명 :
						<%=author.getAuthor_name()%>
					</div>
					<div>
						저자 소개 :
						<pre style="white-space: pre-wrap;">
						<%=author.getAuthor_information()%>
						</pre>
					</div>
				</div>
			</div>
		</div>

		<div>
			<div>
				<div>
					<h4>출판사 리뷰</h4>
				</div>
				<div>
					<pre style="white-space: pre-wrap;">
					<%=item.getItem_publisher_review()%>
					</pre>
				</div>
			</div>
		</div>
	</div>


	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Aspire
				Store 2019</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js">
		
	</script>
	<script src="js/bootstrap.bundle.min.js"></script>

</body>

</html>