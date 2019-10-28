<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionKey = (String) session.getAttribute("SESSIONKEY");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>아스파이어 스토어</title>

<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">

</head>
<body>

	<jsp:include page="/navbar.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container" align="center">

		<div class="row">

			<div class="col-lg-9">

				<div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active">
							<img class="d-block img-fluid" src="http://placehold.it/900x350" alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Third slide">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="sr-only">이전</span>
					</a>
					<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="sr-only">다음</span>
					</a>
				</div>

				<div class="row">

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#">
								<img class="card-img-top" src="http://placehold.it/700x400" alt="">
							</a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 1</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#">
								<img class="card-img-top" src="http://placehold.it/700x400" alt="">
							</a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 2</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#">
								<img class="card-img-top" src="http://placehold.it/700x400" alt="">
							</a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 3</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#">
								<img class="card-img-top" src="http://placehold.it/700x400" alt="">
							</a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 4</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
							</div>
						</div>
					</div>

					<div class="col-lg-4 col-md-6 mb-4">
						<div class="card h-100">
							<a href="#">
								<img class="card-img-top" src="http://placehold.it/700x400" alt="">
							</a>
							<div class="card-body">
								<h4 class="card-title">
									<a href="#">아이템 5</a>
								</h4>
								<h5>$24.99</h5>
								<p class="card-text">상품 정보를 표시합니다.</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
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

	<%@ include file="/footer.html"%>
	<!-- Bootstrap core JavaScript -->
	<script src="jquery/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>

</body>
</html>