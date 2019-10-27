<%@page import="model.OrderhistoryDTO"%>
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
				<a href="#" class="list-group-item list-group-item-action bg-light">배송</a>
			</div>
		</div>

		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>

			<div class="container-fluid">
				<table class="table table-sm table-hover">
					<thead class="thead-light">
						<tr>
							<th colspan="5">
								<h5>
									미 처리 주문 목록&nbsp; <input type="button" id="viewButton" onclick="setDataTable()" value="새로고침">
								</h5>
							</th>
							<th colspan="8">
								표시할 데이터 개수 : <select class="custom-select custom-select-sm w-25" id="select_menu">
									<option value="2">2</option>
									<option value="5" selected>5</option>
									<option value="10">10</option>
									<option value="20">20</option>
									<option value="50">50</option>
								</select> &nbsp; <input type="button" id="viewButton" onclick="setDataTable()" value="데이터 조회"> &nbsp; <input type="button" id="processingButton" onclick="preProcessCheckedOrderShipment()" data-toggle="modal" data-target="#modal" value="처리">
							</th>
						</tr>
						<tr>
							<th scope="col">
								<input type="checkbox" id="checkBoxButton" onclick="selectAllCheckBox()">
							</th>
							<th scope="col">주문코드</th>
							<th scope="col">주문자 ID</th>
							<th scope="col">주문 도서</th>
							<th scope="col">주문자 정보</th>
							<th scope="col">수령자 정보</th>
							<th scope="col">배송지 정보</th>
							<th scope="col">요청 사항</th>
							<th scope="col">최종 결제 금액</th>
							<th scope="col">결제 수단</th>
							<th scope="col">배송 방법</th>
							<th scope="col">주문 날짜</th>
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

	<!-- Modal -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_title"></h5>
					&nbsp;
					<h6 class="modal-title" id="this_order_code"></h6>

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
				<div class="modal-footer" id="modal_footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
					&nbsp;
				</div>
			</div>
		</div>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		var tableDataList = [];

		var pageData =
		{
			'total_record' : 0, //전체 레코드 수
			'num_per_page' : 5, // 페이지당 레코드 수 
			'page_per_block' : 5, //블럭당 페이지 수 
			'total_page' : 0, //전체 페이지 수
			'total_block' : 0, //전체 블럭수 
			'current_page' : 1, // 현재 페이지
			'current_block' : 1, //현재 블럭
			'begin_index' : 0, //QUERY select 시작번호
			'end_index' : 5, //시작번호로 부터 가져올 레코드 갯수
			'list_size' : 0
		//현재 읽어온 데이터의 수
		};

		(function()
		{
			setDataTable();
		})();

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		// 테이블 열의 <최종 결제 금액, 배송 방법, 결제 수단, 주문 날짜, 주문코드, 주문자 ID>는 td value에 바로 등록한다.
		function precessTagValues(list)
		{
			var orderData = new Object(); // 주문 정보 객체(리스트에 저장됨)
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
			orderData['user_id'] = list.ORDERER_ID;
			orderData['final_total_price'] = list.FINAL_TOTAL_PRICE;
			orderData['payment_method'] = list.PAYMENT_METHOD;
			orderData['delivery_method'] = list.DELIVERY_METHOD;
			orderData['order_date'] = list.ORDER_DATE;

			// 체크박스 생성
			var newCheckBox = document.createElement('input');
			newCheckBox.setAttribute('type', 'checkbox');
			newCheckBox.setAttribute('id', 'checkBox');
			newCheckBox.setAttribute('name', 'checkBox');
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
			ordererInput.setAttribute('data-toggle', 'modal');
			ordererInput.setAttribute('data-target', '#modal');

			ordererCol.appendChild(ordererInput);

			// 수령자 정보 버튼 생성
			var recepientInput = document.createElement('input');
			recepientInput.setAttribute('type', 'button');
			recepientInput.setAttribute('onclick', 'getRecepientInfo(\''
					+ String(index) + '\')');
			recepientInput.setAttribute('value', '수령자 정보');
			recepientInput.setAttribute('data-toggle', 'modal');
			recepientInput.setAttribute('data-target', '#modal');

			recepientCol.appendChild(recepientInput);

			// 배송지 정보 버튼 생성
			var addressInput = document.createElement('input');
			addressInput.setAttribute('type', 'button');
			addressInput.setAttribute('onclick', 'getAddressInfo(\''
					+ String(index) + '\')');
			addressInput.setAttribute('value', '배송지 정보');
			addressInput.setAttribute('data-toggle', 'modal');
			addressInput.setAttribute('data-target', '#modal');

			addressCol.appendChild(addressInput);

			if (list.REQUESTED_TERM.REQUESTED_TERM != '')
			{
				// 요청 사항 정보 버튼 생성
				let requestedTermInput = document.createElement('input');
				requestedTermInput.setAttribute('type', 'button');
				requestedTermInput.setAttribute('onclick',
						'getRequestedTermInfo(\'' + String(index) + '\')');
				requestedTermInput.setAttribute('value', '요청 사항 ');
				requestedTermInput.setAttribute('data-toggle', 'modal');
				requestedTermInput.setAttribute('data-target', '#modal');

				requestedTermCol.appendChild(requestedTermInput);
			} else
			{
				requestedTermCol.innerHTML = '없음';
			}

			// 처리 버튼 생성
			var processingButton = document.createElement('input');
			processingButton.setAttribute('type', 'button');
			processingButton.setAttribute('onclick',
					'preProcessSingleOrderShipment(\'' + String(index) + '\')');
			processingButton.setAttribute('value', '처리');
			processingButton.setAttribute('data-toggle', 'modal');
			processingButton.setAttribute('data-target', '#modal');

			processingCol.appendChild(processingButton);

			var keyDataList = new Array(); // keyData 배열 ( orderData객체에 프로퍼티로 저장됨)

			// KEY_DATA의 정보를 tableDataList에 객체로 저장한다.
			for (let j = 0; j < list.KEY_DATA.length; ++j)
			{
				var keyData =
				{
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
			var ordererData =
			{
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
			var recepientData =
			{
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
			var addressData =
			{
				'postal_code' : list.ADDRESS.POSTAL_CODE,
				'road' : list.ADDRESS.ROAD,
				'number' : list.ADDRESS.NUMBER,
				'detail' : list.ADDRESS.DETAIL
			};
			orderData['address_data'] = addressData;

			// 요청사항 정보를 tableDataList에 객체로 저장한다.
			var requestedTermData =
			{
				'requested_term' : list.REQUESTED_TERM.REQUESTED_TERM
			};
			orderData['requested_term_data'] = requestedTermData;

			tableDataList.push(orderData);
		}

		function getBookInfo(index)
		{
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);

			document.getElementById('modal_title').innerHTML = '도서 정보 목록';
			document.getElementById('this_order_code').innerHTML = tableDataList[idx]['order_code'];

			newThead.insertCell(0).innerHTML = '도서 명'
			newThead.insertCell(1).innerHTML = '주문 수량';
			newThead.insertCell(2).innerHTML = '저자';
			newThead.insertCell(3).innerHTML = '출판사';
			newThead.insertCell(4).innerHTML = '판매가';
			newThead.insertCell(5).innerHTML = '합계 금액';

			for (let j = 0; j < tableDataList[idx].key_data.length; ++j)
			{
				let newTbody = modalTbody.insertRow(modalTbody.rows.length);

				newTbody.insertCell(0).innerHTML = tableDataList[idx].key_data[j]['book_name'];
				newTbody.insertCell(1).innerHTML = tableDataList[idx].key_data[j]['quantity'];
				newTbody.insertCell(2).innerHTML = tableDataList[idx].key_data[j]['author_name'];
				newTbody.insertCell(3).innerHTML = tableDataList[idx].key_data[j]['publisher_name'];
				newTbody.insertCell(4).innerHTML = tableDataList[idx].key_data[j]['selling_price'];
				newTbody.insertCell(5).innerHTML = Number(tableDataList[idx].key_data[j]['selling_price'])
						* Number(tableDataList[idx].key_data[j]['quantity']);
			}
		}

		function getOrdererInfo(index)
		{
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);

			document.getElementById('modal_title').innerHTML = '주문자 정보';
			document.getElementById('this_order_code').innerHTML = tableDataList[idx]['order_code'];

			newThead.insertCell(0).innerHTML = '주문자'
			newThead.insertCell(1).innerHTML = '휴대전화';
			newThead.insertCell(2).innerHTML = '일반전화';

			let newTbody = modalTbody.insertRow(0);

			let mobileNum = tableDataList[idx].orderer_data['orderer_mobile1']
					+ '-' + tableDataList[idx].orderer_data['orderer_mobile2']
					+ '-' + tableDataList[idx].orderer_data['orderer_mobile3'];

			let generalNum = tableDataList[idx].orderer_data['orderer_general1']
					+ '-'
					+ tableDataList[idx].orderer_data['orderer_general2']
					+ '-' + tableDataList[idx].orderer_data['orderer_general3'];

			newTbody.insertCell(0).innerHTML = tableDataList[idx].orderer_data['orderer_name'];
			newTbody.insertCell(1).innerHTML = mobileNum;
			newTbody.insertCell(2).innerHTML = generalNum;

		}

		function getRecepientInfo(index)
		{
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);

			document.getElementById('modal_title').innerHTML = '수령자 정보';
			document.getElementById('this_order_code').innerHTML = tableDataList[idx]['order_code'];

			newThead.insertCell(0).innerHTML = '수령자'
			newThead.insertCell(1).innerHTML = '휴대전화';
			newThead.insertCell(2).innerHTML = '일반전화';

			let newTbody = modalTbody.insertRow(0);

			let mobileNum = tableDataList[idx].recepient_data['recepient_mobile1']
					+ '-'
					+ tableDataList[idx].recepient_data['recepient_mobile2']
					+ '-'
					+ tableDataList[idx].recepient_data['recepient_mobile3'];

			let generalNum = tableDataList[idx].recepient_data['recepient_general1']
					+ '-'
					+ tableDataList[idx].recepient_data['recepient_general2']
					+ '-'
					+ tableDataList[idx].recepient_data['recepient_general3'];

			newTbody.insertCell(0).innerHTML = tableDataList[idx].recepient_data['recepient_name'];
			newTbody.insertCell(1).innerHTML = mobileNum;
			newTbody.insertCell(2).innerHTML = generalNum;

		}

		function getAddressInfo(index)
		{
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);

			document.getElementById('modal_title').innerHTML = '배송지 정보';
			document.getElementById('this_order_code').innerHTML = tableDataList[idx]['order_code'];

			newThead.insertCell(0).innerHTML = '우편번호'
			newThead.insertCell(1).innerHTML = '도로명 주소';
			newThead.insertCell(2).innerHTML = '지번 주소';
			newThead.insertCell(3).innerHTML = '상세 주소';

			let newTbody = modalTbody.insertRow(0);

			newTbody.insertCell(0).innerHTML = tableDataList[idx].address_data['postal_code'];
			newTbody.insertCell(1).innerHTML = tableDataList[idx].address_data['road'];
			newTbody.insertCell(2).innerHTML = tableDataList[idx].address_data['number'];
			newTbody.insertCell(3).innerHTML = tableDataList[idx].address_data['detail'];
		}

		function getRequestedTermInfo(index)
		{
			initializeModalTable();

			let idx = Number(index);
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');

			let newThead = modalThead.insertRow(0);

			//modal title설정
			document.getElementById('modal_title').innerHTML = '요청 사항';
			document.getElementById('this_order_code').innerHTML = tableDataList[idx]['order_code'];

			newThead.insertCell(0).innerHTML = '요청 사항'

			let newTbody = modalTbody.insertRow(0);

			newTbody.insertCell(0).innerHTML = tableDataList[idx].requested_term_data['requested_term'];
		}

		function initializeModalTable()
		{
			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');
			document.getElementById('this_order_code').innerHTML = '';

			// 테이블 행의 길이가 0이면 지우지 않음
			if (modalTbody.rows.length != 0)
			{
				if (modalThead.rows.length != 0)
				{
					modalThead.deleteRow(0);
				}
				for (let index = modalTbody.rows.length - 1; index >= 0; --index)
				{
					modalTbody.deleteRow(index);
				}
			}
			if (document.getElementById('processing_modal_button') != undefined)
			{
				let modalButton = document
						.getElementById('processing_modal_button');
				modalButton.parentNode.removeChild(modalButton);
			}
		}

		function initializePageTable()
		{
			let pageTbody = document.getElementById('tableBody');

			// 테이블 행의 길이가 0이면 지우지 않음
			if (pageTbody.rows.length != 0)
			{
				for (let index = pageTbody.rows.length - 1; index >= 0; --index)
				{
					pageTbody.deleteRow(index);
				}
			}
		}

		function selectAllCheckBox()
		{
			let checkBoxes = document.getElementsByName('checkBox');

			if (checkBoxes.length != 0)
			{
				for (let index = 0; index < checkBoxes.length; ++index)
				{
					checkBoxes[index].checked = true;
				}
				let btn = document.getElementById('checkBoxButton');
				btn.setAttribute('onclick', 'unselectAllCheckBox()');

			}
		}

		function unselectAllCheckBox()
		{
			let checkBoxes = document.getElementsByName('checkBox');

			for (let index = 0; index < checkBoxes.length; ++index)
			{
				checkBoxes[index].checked = false;
			}
			let btn = document.getElementById('checkBoxButton');
			btn.setAttribute('onclick', 'selectAllCheckBox()');

		}

		function referData()
		{
			// 페이지 당 레코드의 수
			var xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					const responseList = JSON.parse(xhr.responseText);

					pageData['list_size'] = responseList.ORDER_DATA.length;
					initializePageTable();

					// 데이터 리스트 초기화
					tableDataList = [];

					let listSize = pageData['list_size'];
					for (let index = 0; index < pageData['num_per_page']; ++index)
					{
						if (index == listSize)
						{
							break;
						} else
						{
							precessTagValues(responseList.ORDER_DATA[index]);
						}
					}

					setPaginationBar();
				}
			};
			xhr.open('POST', '/AspireStore/management/ordersmanagement.aspire',
					true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send('type=' + 'GET_LIST' + '&begin_index='
					+ pageData['begin_index'] + '&end_index='
					+ pageData['end_index']);
		}

		function calcPageData()
		{
			let beginIndex = pageData['begin_index'];
			let endIndex = pageData['end_index'];
			let numPerPage = pageData['num_per_page'];
			let totalRecord = pageData['total_record'];
			let currentPage = pageData['current_page'];
			let pagePerBlock = pageData['page_per_block'];

			pageData['begin_index'] = (currentPage * numPerPage) - numPerPage;
			pageData['end_index'] = numPerPage;
			pageData['total_page'] = parseInt(Math.ceil(parseFloat(totalRecord)
					/ numPerPage));
			pageData['current_block'] = parseInt(Math
					.ceil(parseFloat(currentPage) / pagePerBlock));

			let totalPage = pageData['total_page'];

			pageData['total_block'] = parseInt(Math.ceil(parseFloat(totalPage)
					/ pagePerBlock));
		}

		function paging(num)
		{
			pageData['current_page'] = Number(num);
			setDataTable();
		}

		function moveBlock(num)
		{
			pageData['current_page'] = pageData['page_per_block']
					* (Number(num) - 1) + 1;
			setDataTable();
		}

		function setPaginationBar()
		{
			let pageBegin = ((pageData['current_block'] - 1) * pageData['page_per_block']) + 1;
			let pageEnd = ((pageBegin + pageData['page_per_block']) <= pageData['total_page']) ? (pageBegin + pageData['page_per_block'])
					: pageData['total_page'] + 1;

			const totalPage = pageData['total_page'];
			const totalBlock = pageData['total_block'];
			const currentBlock = pageData['current_block'];
			const currentPage = pageData['current_page'];

			let newElement = '';

			if (totalPage != 0)
			{
				if (currentBlock > 1)
				{
					// 이전 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"javascript:moveBlock(\''
							+ String(currentBlock - 1)
							+ '\')\" tabindex=\"-1\" aria-disabled=\"true\">이전</a></li>';
				}
				while (pageBegin < pageEnd)
				{
					if (pageBegin == currentPage)
					{
						// 현재 페이지 active
						newElement += '<li class=\"page-item active\" aria-current=\"page\"><a class=\"page-link\" href=\"javascript:paging(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '<span class=\"sr-only\">(현재 페이지)</span></a></li>';
					} else
					{
						// 1, 2, 3 버튼
						newElement += '<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(\''
								+ String(pageBegin)
								+ '\')\">'
								+ pageBegin
								+ '</a></li>';
					}
					++pageBegin;
				}
				if (totalBlock > currentBlock)
				{
					// 다음 버튼
					newElement += '<li class =\"page-item\"><a class=\"page-link\" href=\"moveBlock('
							+ currentBlock + 1 + ')\">다음</a></li>';
				}
			}
			document.getElementById('pagination_ul').innerHTML = newElement;
		}

		function setDataTable()
		{
			let xhrForSize = new XMLHttpRequest();

			xhrForSize.onreadystatechange = function()
			{
				if (xhrForSize.readyState == XMLHttpRequest.DONE
						&& xhrForSize.status == 200)
				{
					unselectAllCheckBox();
					var recordsSize = Number(xhrForSize.responseText.toString());
					var selectMenu = document.getElementById('select_menu');

					pageData['total_record'] = recordsSize;
					pageData['num_per_page'] = selectMenu.options[selectMenu.selectedIndex].value;
					calcPageData();
					referData();
				}
			};
			xhrForSize.open('POST',
					'/AspireStore/management/ordersmanagement.aspire', true);
			xhrForSize.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhrForSize.send('type=' + 'GET_RECORDS_SIZE');
		}

		function preProcessSingleOrderShipment(index)
		{
			//하나의 주문에 대해서 발송 완료 전처리를 하는 함수

			// 받은 인덱스에 해당하는 행의 체크박스만 체크, 나머지는 false상태로 변경
			let checkBox = document.getElementsByName('checkBox');
			for (let i = 0; i < checkBox.length; ++i)
			{
				checkBox[i].checked = false;
			}
			checkBox[index].checked = true;
			showModalForProcessing();
		}

		function preProcessCheckedOrderShipment()
		{
			//선택된 주문에 대해서 발송 완료 전처리를 하는 함수
			showModalForProcessing();
		}

		function processOrderShipment()
		{
			// 받은 인덱스에 해당하는 행의 데이터를 가져온다.
			const rowDataArr = [];
			const indexes = getCheckedIndexes();
			let dataToBeSended = '';

			for (let i = 0; i < indexes.length; ++i)
			{
				let orderCode = tableDataList[indexes[i]]['order_code'];
				let userId = tableDataList[indexes[i]]['user_id'];
				dataToBeSended += 'orderCode=' + orderCode + '&userId='
						+ userId + '&';
			}
			dataToBeSended += 'type=' + 'PROCESS_SHIPMENT';

			let xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{
					alert('발송 처리 되었습니다.');
					setDataTable();
				}
			};
			xhr.open('POST', '/AspireStore/management/ordersmanagement.aspire',
					true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send(dataToBeSended);
		}

		function showModalForProcessing()
		{
			initializeModalTable();

			let modalThead = document.getElementById('modal_thead');
			let modalTbody = document.getElementById('modal_tbody');
			let newTbody = modalTbody.insertRow(0);
			let newThead = modalThead.insertRow(0);

			document.getElementById('modal_title').innerHTML = '처리';
			newThead.insertCell(0).innerHTML = '처리';
			let textCol = newTbody.insertCell(0);

			let indexes = getCheckedIndexes();
			if (indexes.length == 0)
			{
				textCol.innerHTML = '처리할 주문을 선택해주세요.';
			} else
			{
				let text = '주문 코드 : ';

				for (let i = 0; i < indexes.length; ++i)
				{
					text += ' < ' + tableDataList[indexes[i]]['order_code'] + ' > '
				}
				text += '에 대해서 발송 완료 처리를 하시겠습니까?';

				textCol.innerHTML = text;

				let modalFooter = document.getElementById('modal_footer');
				let newButton = document.createElement('input');

				newButton.setAttribute('type', 'button');
				newButton.setAttribute('id', 'processing_modal_button');
				newButton.setAttribute('class', 'btn btn-primary');
				newButton.setAttribute('data-dismiss', 'modal');
				newButton.setAttribute('onclick', 'processOrderShipment()');
				newButton.setAttribute('value', '발송 처리');

				modalFooter.appendChild(newButton);
			}
		}

		function getCheckedIndexes()
		{
			let arr = [];
			let checkBox = document.getElementsByName('checkBox');

			for (let i = 0; i < checkBox.length; ++i)
			{
				if (checkBox[i].checked == true)
				{
					arr.push(i);
				}
			}
			return arr;
		}
	</script>
</body>
</html>