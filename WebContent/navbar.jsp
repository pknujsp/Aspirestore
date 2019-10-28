<%@ page language="java" contentType="text/html; charset=UTF-8" session="true"%>
<%
	String sessionKey = (String)session.getAttribute("SESSIONKEY");
%>

<script>
	function goToHome()
	{
		location.href = '/AspireStore/index.jsp';
	}
</script>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
	<div class="container-fluid">

		<strong><a class="navbar-brand" href="javascript:goToHome()">Aspire Store</a></strong>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="dropdown">

			<button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">전체 분류</button>

			<ul class="dropdown-menu multi-level" aria-labelledby="dropdownMenu">

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.aspire?ccode=100" tabindex="0" class="dropdown-header dropdown-submenu">게임</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=101&cpcode=100">게임 기획</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=102&cpcode=100">게임 개발</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=103&cpcode=100">게임 가이드북</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=104&cpcode=100">모바일 게임</a>
					</ul>
				</li>

				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=200" tabindex="1" class="dropdown-header dropdown-submenu">그래픽/디자인/멀티미디어</a>

					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=201&cpcode=200">3DS/MAX</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=202&cpcode=200">건축CG</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=203&cpcode=200">그래픽일반/자료집</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=204&cpcode=200">그래픽툴/저작툴</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=205&cpcode=200">디렉터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=206&cpcode=200">라이트룸</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=207&cpcode=200">베가스</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=208&cpcode=200">인디자인</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=209&cpcode=200">일러스트레이터</a>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=210&cpcode=200">캐릭터/애니메이션</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=211&cpcode=200">페인터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=212&cpcode=200">포토샵</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=213&cpcode=200">프리미어</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=214&cpcode=200">플래시</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=215&cpcode=200">애프터 이펙트</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=216&cpcode=200">오토캐드</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=217&cpcode=200">멀티미디어/컴퓨터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=218&cpcode=200">디지털 카메라</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=300" tabindex="2" class="dropdown-header dropdown-submenu">네트워크/해킹/보안</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=301&cpcode=300">네트워크 일반</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=302&cpcode=300">TCP/IP</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=303&cpcode=300">보안/해킹</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=400" tabindex="3" class="dropdown-header dropdown-submenu"> 모바일 프로그래밍</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=401&cpcode=400">아이폰</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=402&cpcode=400">안드로이드폰</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=403&cpcode=400">윈도우폰</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=404&cpcode=400">모바일 게임</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=500" tabindex="4" class="dropdown-header dropdown-submenu">모바일/태블릿/SNS</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=501&cpcode=500">아이패드</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=502&cpcode=500">아이폰</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=503&cpcode=500">안드로이드태블릿</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=504&cpcode=500">안드로이드폰</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=505&cpcode=500">트위터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=506&cpcode=500">페이스북</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=507&cpcode=500">유튜브</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=508&cpcode=500">앱가이드</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=600" tabindex="5" class="dropdown-header dropdown-submenu">오피스 활용</a>
					<ul class="dropdown-menu">

						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=601&cpcode=600">한글</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=602&cpcode=600">엑셀</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=603&cpcode=600">파워포인트</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=604&cpcode=600">워드</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=605&cpcode=600">액세스</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=606&cpcode=600">아웃룩</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=607&cpcode=600">프레젠테이션</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=608&cpcode=600">오피스</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=700" tabindex="6" class="dropdown-header dropdown-submenu">웹사이트</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=701&cpcode=700">HTML/JAVASCRIPT/CSS</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=702&cpcode=700">웹디자인</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=703&cpcode=700">웹기획</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=704&cpcode=700">UI/UX</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=705&cpcode=700">블로그/홈페이지</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=800" tabindex="7" class="dropdown-header dropdown-submenu">인터넷 비즈니스</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=801&cpcode=800">쇼핑몰/창업</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=802&cpcode=800">인터넷 마케팅</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=803&cpcode=800">공공정책/자료</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=900" tabindex="8" class="dropdown-header dropdown-submenu">컴퓨터 공학</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=901&cpcode=900">컴퓨터 교육</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=902&cpcode=900">네트워크/데이터 통신</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=903&cpcode=900">마이크로 프로세서</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=904&cpcode=900">소프트웨어 공학</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=905&cpcode=900">취미 공학</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=906&cpcode=900">인공지능</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=907&cpcode=900">컴퓨터구조</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=908&cpcode=900">운영체제</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=909&cpcode=900">데이터베이스</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=910&cpcode=900">개발방법론</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=911&cpcode=900">블록체인</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=912&cpcode=900">자료구조/알고리즘</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=913&cpcode=900">전산수학</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=914&cpcode=900">정보통신</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=1000" tabindex="9" class="dropdown-header dropdown-submenu">컴퓨터 수험서</a>
					<ul class="dropdown-menu">

						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1001&cpcode=1000">컴퓨터활용능력</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1002&cpcode=1000">워드프로세서</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1003&cpcode=1000">그래픽 관련</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1004&cpcode=1000">사무자동화</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1005&cpcode=1000">DIAT</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1006&cpcode=1000">ITQ</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1007&cpcode=1000">MOS</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1008&cpcode=1000">ICDL</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1009&cpcode=1000">상공회의소</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1010&cpcode=1000">정보처리/보안</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1011&cpcode=1000">신규자격증/기타</a>
						</li>

					</ul>
				</li>

				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=1100" tabindex="10" class="dropdown-header dropdown-submenu"> 컴퓨터 입문/활용</a>
					<ul class="dropdown-menu">

						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1101&cpcode=1100">어른을 위한 컴퓨터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1102&cpcode=1100">어린이 컴퓨터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1103&cpcode=1100">윈도우 입문서/활용</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1104&cpcode=1100">인터넷 입문서</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1105&cpcode=1100">컴퓨터 조립/수리</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.jsp?ccode=1200" tabindex="11" class="dropdown-header dropdown-submenu">프로그래밍 언어</a>

					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1201&cpcode=1200">.NET</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1202&cpcode=1200">JAVA</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1203&cpcode=1200">PYTHON</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1204&cpcode=1200">C</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1205&cpcode=1200">C#</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1206&cpcode=1200">C++</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1207&cpcode=1200">JAVASCRIPT</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1208&cpcode=1200">JSP</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1209&cpcode=1200">PHP</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1210&cpcode=1200">RUBY</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1211&cpcode=1200">XML</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1212&cpcode=1200">VB</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1213&cpcode=1200">프로그래밍 교육</a>
						</li>
					</ul>
				</li>
				<li class="dropdown-divider"></li>

				<li class="dropdown-submenu">
					<a href="/AspireStore/items/itemlist.?ccode=1300" tabindex="12" class="dropdown-header dropdown-submenu">OS/DB</a>
					<ul class="dropdown-menu">
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1301&cpcode=1300">윈도우</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1302&cpcode=1300">MAC</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1303&cpcode=1300">리눅스</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1304&cpcode=1300">유닉스</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1305&cpcode=1300">Access</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1306&cpcode=1300">MySQL</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1307&cpcode=1300">ORACLE</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1308&cpcode=1300">SQL Server</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1309&cpcode=1300">클라우드/빅데이터</a>
						</li>
						<li>
							<a class="dropdown-item" href="/AspireStore/items/itemlist.aspire?ccode=1310&cpcode=1300">시스템관리/서버</a>
						</li>

					</ul>
				</li>
			</ul>

		</div>

		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">

				<%
					if (sessionKey != null) {
				%><li class="nav-item">
					<a class="nav-link disabled">
						<i><%=sessionKey.toString()%></i>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/AspireStore/logout.aspire">로그아웃</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">나의 Aspire</a>
				</li>

				<%
					} else {
				%>
				<li class="nav-item">
					<a class="nav-link" href="/AspireStore/signin.jsp">로그인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/AspireStore/signup.jsp">회원가입</a>
				</li>
				<%
					}
				%>


				<li class="nav-item">
					<a class="nav-link" href="/AspireStore/csservice/qna.aspire?type=GET_QUESTION_LIST">고객센터</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">상품 문의</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="javascript:moveToAnotherPage('GET_BASKET','/AspireStore/basket.aspire')">장바구니</a>
				</li>
			</ul>
		</div>
	</div>

	<script type="text/javascript">
		function moveToAnotherPage(type, action)
		{
			var form = document.createElement('form');
			form.setAttribute('action', action);
			form.setAttribute('method', 'Get');

			var hiddenTag = document.createElement('input');
			hiddenTag.setAttribute('type', 'hidden');
			hiddenTag.setAttribute('name', 'type');
			hiddenTag.setAttribute('value', type);
			form.appendChild(hiddenTag);

			document.body.appendChild(form);
			form.submit();
		}
	</script>
</nav>