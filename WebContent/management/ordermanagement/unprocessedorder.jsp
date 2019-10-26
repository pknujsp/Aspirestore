<%@page import="model.OrderhistoryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	/*
	
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
		
	*/
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
							<th>주문 도서</th>
							<th>주문자 정보</th>
							<th>수령자 정보</th>
							<th>배송지 정보</th>
							<th>요청 사항</th>
							<th>최종 결제 금액</th>
							<th>결제 수단</th>
							<th>배송 방법</th>
							<th>주문 날짜</th>
							<th>처리</th>
						</tr>
					</thead>
					<tbody id="tableBody">

					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_title"></h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="table" id='modal_table'>
						<thead id="modal_thead">

						</thead>
						<tbody id="modal_tbody">

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		const tableDataList = [];

		(function() {
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == XMLHttpRequest.DONE
						&& xhttp.status == 200) {
					const responseList = JSON.parse(xhttp.response);

					for (let index = 0; index < responseList.ORDER_DATA.length; ++index) {
						precessTagValues(responseList.ORDER_DATA[index]);
					}
				}
			};

			xhttp.open('POST',
					'/AspireStore/management/ordersmanagement.aspire', true);
			xhttp.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhttp.send('type=' + 'GET_LIST');
		})();

		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		// 테이블 열의 <최종 결제 금액, 배송 방법, 결제 수단, 주문 날짜, 주문코드, 주문자 ID>는 td value에 바로 등록한다.
		function precessTagValues(list) {
			let tBody = document.getElementById('tableBody');
			let index = tBody.rows.length;
			let newTableRow = tBody.insertRow(index);

			let checkBoxCol = newTableRow.insertCell(0); //
			let orderCodeCol = newTableRow.insertCell(1); //
			let userIdCol = newTableRow.insertCell(2); //
			let bookInfoCol = newTableRow.insertCell(3); //
			let ordererCol = newTableRow.insertCell(4);
			let recepientCol = newTableRow.insertCell(5);
			let addressCol = newTableRow.insertCell(6);
			let requestedTermCol = newTableRow.insertCell(7);
			let finalTotalPriceCol = newTableRow.insertCell(8); //
			let paymentMethodCol = newTableRow.insertCell(9); //
			let deliveryMethodCol = newTableRow.insertCell(10); //
			let orderDateCol = newTableRow.insertCell(11); //
			let processingCol = newTableRow.insertCell(12);

			orderCodeCol.innerHTML = list.ORDER_CODE;
			userIdCol.innerHTML = list.ORDERER_ID;
			finalTotalPriceCol.innerHTML = list.FINAL_TOTAL_PRICE;
			paymentMethodCol.innerHTML = list.PAYMENT_METHOD;
			deliveryMethodCol.innerHTML = list.DELIVERY_METHOD;
			orderDateCol.innerHTML = list.ORDER_DATE;
			
			orderData['order_code'] = list.ORDER_CODE;
			orderData['order_code'] = list.ORDER_CODE;
			orderData['order_code'] = list.ORDER_CODE;
			orderData['order_code'] = list.ORDER_CODE;
			orderData['order_code'] = list.ORDER_CODE;
			orderData['order_code'] = list.ORDER_CODE;

			// 체크박스 생성
			var newCheckBox = document.createElement('input');
			newCheckBox.setAttribute('type', 'checkbox');
			newCheckBox.setAttribute('id', 'orderCheckBox');
			newCheckBox.setAttribute('value', index);

			checkBoxCol.appendChild(newCheckBox);

			// 도서 정보 버튼 생성
			var bookInfoInput = document.createElement('input');
			bookInfoInput.setAttribute('type', 'button');
			bookInfoInput.setAttribute('onclick', 'getBookInfo(\''
					+ String(index) + '\')');
			bookInfoInput.setAttribute('value', '주문 도서 정보');
			bookInfoInput.setAttribute('data-toggle', 'modal');
			bookInfoInput.setAttribute('data-target', '#modal');

			bookInfoCol.appendChild(bookInfoInput);

			// 주문자 정보 버튼 생성
			var ordererInput = document.createElement('input');
			ordererInput.setAttribute('type', 'button');
			ordererInput.setAttribute('onclick', 'getOrdererInfo(\''
					+ String(index) + '\')');
			ordererInput.setAttribute('value', '주문자 정보');

			ordererCol.appendChild(ordererInput);

			// 수령자 정보 버튼 생성
			var recepientInput = document.createElement('input');
			recepientInput.setAttribute('type', 'button');
			recepientInput.setAttribute('onclick', 'getRecepientInfo(\''
					+ String(index) + '\')');
			recepientInput.setAttribute('value', '수령자 정보');

			recepientCol.appendChild(recepientInput);

			// 배송지 정보 버튼 생성
			var addresstInput = document.createElement('input');
			addresstInput.setAttribute('type', 'button');
			addresstInput.setAttribute('onclick', 'getAddressInfo(\''
					+ String(index) + '\')');
			addresstInput.setAttribute('value', '배송지 정보');

			addressCol.appendChild(addresstInput);

			if (list.REQUESTED_TERM.REQUESTED_TERM != '') {
				// 요청 사항 정보 버튼 생성
				let requestedTermInput = document.createElement('input');
				requestedTermInput.setAttribute('type', 'button');
				requestedTermInput.setAttribute('onclick',
						'getRequestedTermInfo(\'' + String(index) + '\')');
				requestedTermInput.setAttribute('value', '요청 사항 ');

				requestedTermCol.appendChild(requestedTermInput);
			} else {
				requestedTermCol.innerHTML = '없음';
			}

			var orderData = new Object(); // 주문 정보 객체(리스트에 저장됨)
			var keyDataList = new Array(); // keyData 배열 ( orderData객체에 프로퍼티로 저장됨)

			// KEY_DATA의 정보를 tableDataList에 객체로 저장한다.
			for (let j = 0; j < list.KEY_DATA.length; ++j) {
				var keyData = {
					'quantity' : list.KEY_DATA[j].QUANTITY,
					'total_price' : list.KEY_DATA[j].TOTAL_PRICE,
					'book_name' : list.KEY_DATA[j].BOOK_NAME,
					'selling_price' : list.KEY_DATA[j].SELLING_PRICE,
					'author_name' : list.KEY_DATA[j].AUTHOR_NAME,
					'publisher_name' : list.KEY_DATA[j].PUBLISHER_NAME
				};
				keyDataList.push(keyData);
			}
			orderData['key_data'] = keyDataList;

			// 주문자 정보를 tableDataList에 객체로 저장한다.
			var ordererData = {
				'orderer_name' : list.ORDERER.ORDERER_NAME,
				'orderer_mobile1' : list.ORDERER.ORDERER_MOBILE1,
				'orderer_mobile2' : list.ORDERER.ORDERER_MOBILE2,
				'orderer_mobile3' : list.ORDERER.ORDERER_MOBILE3,
				'orderer_general1' : list.ORDERER.ORDERER_GENERAL1,
				'orderer_general2' : list.ORDERER.ORDERER_GENERAL2,
				'orderer_general3' : list.ORDERER.ORDERER_GENERAL3
			};
			orderData['orderer_data'] = ordererData;

			// 수령자 정보를 tableDataList에 객체로 저장한다.
			var recepientData = {
				'recepient_name' : list.RECEPIENT.RECEPIENT_NAME,
				'recepient_mobile1' : list.RECEPIENT.RECEPIENT_MOBILE1,
				'recepient_mobile2' : list.RECEPIENT.RECEPIENT_MOBILE2,
				'recepient_mobile3' : list.RECEPIENT.RECEPIENT_MOBILE3,
				'recepient_general1' : list.RECEPIENT.RECEPIENT_GENERAL1,
				'recepient_general2' : list.RECEPIENT.RECEPIENT_GENERAL2,
				'recepient_general3' : list.RECEPIENT.RECEPIENT_GENERAL3
			};
			orderData['recepient_data'] = recepientData;

			// 배송지 정보를 tableDataList에 객체로 저장한다.
			var addressData = {
				'postal_code' : list.ADDRESS.POSTAL_CODE,
				'road' : list.ADDRESS.ROAD,
				'number' : list.ADDRESS.NUMBER,
				'detail' : list.ADDRESS.DETAIL
			};
			orderData['address_data'] = addressData;

			// 요청사항 정보를 tableDataList에 객체로 저장한다.
			var requestedTermData = {
				'requested_term' : list.REQUESTED_TERM.REQUESTED_TERM
			};
			orderData['requested_term_data'] = requestedTermData;

			tableDataList.push(orderData);
		}

		function getBookInfo(index) {
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);
			
			document.getElementById('modal_title').innerHTML = '도서 정보 목록';
			
			newThead.insertCell(0).innerHTML = '도서 명'
			newThead.insertCell(1).innerHTML = '주문 수량';
			newThead.insertCell(2).innerHTML = '저자';
			newThead.insertCell(3).innerHTML = '출판사';
			newThead.insertCell(4).innerHTML = '판매가';

			for (let j = 0; j < tableDataList[idx].key_data.length; ++j) {
				let newTbody = modalTbody.insertRow(modalTbody.rows.length);

				newTbody.insertCell(0).innerHTML = tableDataList[idx].key_data[j]['book_name'];
				newTbody.insertCell(1).innerHTML = tableDataList[idx].key_data[j]['quantity'];
				newTbody.insertCell(2).innerHTML = tableDataList[idx].key_data[j]['author_name'];
				newTbody.insertCell(3).innerHTML = tableDataList[idx].key_data[j]['publisher_name'];
				newTbody.insertCell(4).innerHTML = tableDataList[idx].key_data[j]['selling_price'];
			}
		}

		function getOrdererInfo(index) {

		}

		function getRecepientInfo(index) {

		}

		function getAddressInfo(index) {

		}

		function getRequestedTermInfo(index) {

		}

		function initializeModalTable() {
			let modalTable = document.getElementById('modal_table');

			// 테이블 행의 길이가 0이면 지우지 않음
			if (modalTable.rows.length != 0) {

				for (let index = modalTable.rows.length; index >= 0; --index) {
					modalTable.deleteRow(index);
				}
			}
		}
	</script>
</body>
</html>