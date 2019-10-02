<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>아스파이어 스토어</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/shop-homepage.css" rel="stylesheet">

</head>
<body>
	<script>
		function refreshPage() {
			location.reload(true);
		}
	</script>
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">

			<strong><a class="navbar-brand"
				href="javascript:refreshPage()">Aspire Store</a></strong>
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

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.aspire?ccode=100" tabindex="0"
						class="dropdown-header dropdown-submenu">게임</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=101&cpcode=100">게임 기획</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=102&cpcode=100">게임 개발</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=103&cpcode=100">게임 가이드북</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=104&cpcode=100">모바일 게임</a>
						</ul></li>

					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=200" tabindex="1"
						class="dropdown-header dropdown-submenu">그래픽/디자인/멀티미디어</a>

						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=201&cpcode=200">3DS/MAX</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=202&cpcode=200">건축CG</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=203&cpcode=200">그래픽일반/자료집</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=204&cpcode=200">그래픽툴/저작툴</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=205&cpcode=200">디렉터</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=206&cpcode=200">라이트룸</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=207&cpcode=200">베가스</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=208&cpcode=200">인디자인</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=209&cpcode=200">일러스트레이터</a>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=210&cpcode=200">캐릭터/애니메이션</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=211&cpcode=200">페인터</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=212&cpcode=200">포토샵</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=213&cpcode=200">프리미어</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=214&cpcode=200">플래시</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=215&cpcode=200">애프터 이펙트</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=216&cpcode=200">오토캐드</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=217&cpcode=200">멀티미디어/컴퓨터</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=218&cpcode=200">디지털 카메라</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=300" tabindex="2"
						class="dropdown-header dropdown-submenu">네트워크/해킹/보안</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=301&cpcode=300">네트워크 일반</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=302&cpcode=300">TCP/IP</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=303&cpcode=300">보안/해킹</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=400" tabindex="3"
						class="dropdown-header dropdown-submenu"> 모바일 프로그래밍</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=401&cpcode=400">아이폰</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=402&cpcode=400">안드로이드폰</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=403&cpcode=400">윈도우폰</a></li>
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=404&cpcode=400">모바일 게임</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=500" tabindex="3"
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
						href="/AspireStore/items/itemlist.jsp?ccode=600" tabindex="4"
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
						href="/AspireStore/items/itemlist.jsp?ccode=700" tabindex="5"
						class="dropdown-header dropdown-submenu">웹사이트</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=701&cpcode=700">HTML/JAVASCRIPT/CSS</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">웹디자인</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">웹기획</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">UI/UX</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">블로그/홈페이지</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=800" tabindex="6"
						class="dropdown-header dropdown-submenu">인터넷 비즈니스</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemlist.jsp">쇼핑몰/창업</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">인터넷 마케팅</a></li>
							<li><a class="dropdown-item" href="itemlist.jsp">공공정책/자료</a></li>
						</ul></li>
					<li class="dropdown-divider"></li>

					<li class="dropdown-submenu"><a
						href="/AspireStore/items/itemlist.jsp?ccode=900" tabindex="7"
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
						href="/AspireStore/items/itemlist.jsp?ccode=1000" tabindex="8"
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
						href="/AspireStore/items/itemlist.jsp?ccode=1100" tabindex="9"
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
						href="/AspireStore/items/itemlist.jsp?ccode=1200" tabindex="10"
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
						href="/AspireStore/items/itemlist.jsp?ccode=1300" tabindex="11"
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
						if (sessionKey != null)
						{
					%>
					<li class="nav-item"><a class="nav-link disabled"><i><%=sessionKey.toString()%></i></a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="/AspireStore/logout.aspire">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link" href="#">나의
							Aspire</a></li>

					<%
						} else
						{
					%>
					<li class="nav-item"><a class="nav-link" href="signin.jsp">로그인</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="signup.jsp">회원가입</a>
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

	<!-- Page Content -->
	<div class="container" align="center">

		<div class="row">

			<div class="col-lg-9">

				<div id="carouselExampleIndicators" class="carousel slide my-4"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active">
							<img class="d-block img-fluid" src="http://placehold.it/900x350"
								alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="http://placehold.it/900x350"
								alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="http://placehold.it/900x350"
								alt="Third slide">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">이전</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">다음</span>
					</a>
				</div>

				<div class="row">

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#"><img class="card-img-top"
								src="http://placehold.it/700x400" alt=""></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 1</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733;
									&#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#"><img class="card-img-top"
								src="http://placehold.it/700x400" alt=""></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 2</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733;
									&#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#"><img class="card-img-top"
								src="http://placehold.it/700x400" alt=""></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 3</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733;
									&#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#"><img class="card-img-top"
								src="http://placehold.it/700x400" alt=""></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 4</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733;
									&#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#"><img class="card-img-top"
								src="http://placehold.it/700x400" alt=""></a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 5</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733;
									&#9733; &#9734;</small>
							</div>
						</div>
					</div>



				</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Aspire
				Store 2019</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>

</body>

</html>