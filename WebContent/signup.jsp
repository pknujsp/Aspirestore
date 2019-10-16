<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="회원가입을 하는 페이지입니다.">
<meta name="author" content="Aspire Development">
<title>회원가입</title>

<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/shop-homepage.css" rel="stylesheet">
<script type="text/javascript">
	beSamePassword = false;
</script>
</head>
<body>
	<script type="text/javascript">
		function checkDuplicationPW() {
			var pw1 = document.getElementById('InputPassword').value;
			var pw2 = document.getElementById('CheckPassword').value;

			if (pw1 != '' || pw2 != '') {
				if (pw1 == pw2) {
					document.getElementById('resultStr').innerHTML = '비밀번호 일치';
					document.getElementById('resultStr').style.color = 'blue';
					beSamePassword = true;
				} else {
					document.getElementById('resultStr').innerHTML = '비밀번호 불일치';
					document.getElementById('resultStr').style.color = 'red';
					beSamePassword = false;
				}
			} else {
				document.getElementById('resultStr').innerHTML = '';
				beSamePassword = false;
			}
		}

		function checkCondition() {
			if (beSamePassword == true) {
				return true;
			} else {
				alert('회원가입 불가, 입력하신 정보를 재확인 해주세요!');
				return false;
			}
		}
	</script>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<!--- 아이디, 비밀번호, 비밀번호 확인, 이름, 닉네임, 생년월일, 휴대폰 번호, 성별 --->
	<div class="container">
		<form name="signupform" method="post"
			action="/AspireStore/signup.aspire"
			onsubmit="return checkCondition()">
			<div class="form-group">
				<label for="InputEmail">이메일 주소(아이디)</label> <input type="email"
					class="form-control" id="InputEmail" name="InputEmail"
					aria-describedby="emailHelp" placeholder="이메일 주소 입력">
			</div>
			<div class="form-group">
				<label for="InputPassword">비밀번호</label> <input type="password"
					class="form-control" id="InputPassword" name="InputPassword"
					placeholder="비밀번호 입력" onchange="javascript:checkDuplicationPW()" />
			</div>
			<div class="form-group">
				<label for="CheckPassword">비밀번호 확인</label>&nbsp;&nbsp;<span><b
					id="resultStr"></b></span> <input type="password" class="form-control"
					id="CheckPassword" name="CheckPassword" placeholder="비밀번호 재입력"
					onchange="javascript:checkDuplicationPW()" />

			</div>
			<div class="form-group">
				<label for="InputName">성명</label> <input type="text"
					class="form-control" id="InputName" name="InputName"
					placeholder="성명 입력">
			</div>
			<div class="form-group">
				<label for="InputNickName">닉네임</label> <input type="text"
					class="form-control" id="InputNickName" name="InputNickName"
					placeholder="사용할 닉네임 입력">
			</div>
			<div class="form-group">
				<label for="SetBirthdate">생년월일</label> <input type="date"
					class="form-control" id="SetBirthdate" name="SetBirthdate"
					value="2000-01-01">
			</div>
			<div class="form-group">
				<label for="InputPhoneNumber">휴대폰 번호</label> <input type="text"
					class="form-control" id="InputPhoneNumber1"
					name="InputPhoneNumber1"> - <input type="text"
					class="form-control" id="InputPhoneNumber2"
					name="InputPhoneNumber2"> - <input type="text"
					class="form-control" id="InputPhoneNumber3"
					name="InputPhoneNumber3">
			</div>
			<div class="form-group">
				<label for="InputGender">성별</label> <input type="radio"
					class="form-control" id="InputGender" name="InputGender" value="남성">남성
				<input type="radio" class="form-control" id="InputGender"
					name="InputGender" value="여성">여성
			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</form>
	</div>
</body>
</html>