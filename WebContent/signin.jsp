<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");
%>
<!DOCTYPE html>
<html>
<head>

<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>로그인</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<form method="post" action="/AspireStore/signin.aspire">
			<div class="form-group">
				<label for="InputEmail">이메일 주소(아이디)</label> <input type="email"
					class="form-control" id="InputEmail" name="InputEmail"
					aria-describedby="emailHelp" placeholder="이메일 주소 입력">
			</div>
			<div class="form-group">
				<label for="InputPassword">비밀번호</label> <input type="password"
					class="form-control" id="InputPassword" name="InputPassword"
					placeholder="비밀번호 입력">
			</div>
			<div class="form-group form-check">
				<input type="checkbox" class="form-check-input" id="KeepLoggedIn"
					name="KeepLoggedIn"> <label class="form-check-label"
					for="KeepLoggedIn">로그인 유지</label> <a href="#" id="FindPassword">비밀번호
					찾기</a>
			</div>
			<button type="submit" class="btn btn-primary">로그인</button>
		</form>
	</div>

</body>

</html>