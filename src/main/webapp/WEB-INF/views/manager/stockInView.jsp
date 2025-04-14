<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String position = (String)session.getAttribute("position");
    String memName = (String)session.getAttribute("memName");
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <title>Title</title>
    <style>
        main{
            margin-left: 250px;  /* ms-sm-auto */
            /*margin-right: auto;*/
            width: 85.3%;  /* col-lg-10 (10/12 * 100%) */
            padding-left: 24px;  /* px-md-4 */
            /*padding-right: 24px;*/
            margin-top: 130px;
        }

        .stockIn-management{
            width: 100%;
            height: 100%;
            padding: 10px;
            display: flex;
            justify-content: space-between;
        }

        .table1, .table2{
            width: 49%;
            max-height: 750px;
            overflow-y: auto;
        }

        .table2{
            max-height: 664px;
        }

        select{
            border-radius: 8px;
        }

        #search-bar{
            display: flex;
            justify-content: space-between;
        }

        .search-bar{
            position: fixed;
        }

        #search-bar-1{
            width: 440px;
            display:flex;
            align-items: center;
            justify-content: space-between;
        }

        #date1, #date2 {
            width: 130px;
            height: 30px;
            font-size: 13px;
            padding: 8px;
            border-radius: 5px;
            appearance: none;
        }

        #date1::-webkit-calendar-picker-indicator,
        #date2::-webkit-calendar-picker-indicator {
            height: 20px;
            width: 20px;
        }


        #stockIn-search-bar{
            width: 80px;
            height: 30px;
            font-size: 14px;
        }

        .search-btn{
            width: 60px;
            height: 30px;
            font-size: 16px;
            border-radius: 8px;
            background-color: white;
            color: black;
            border: 1px solid black;
            padding: 3px;
            font-weight: 500;
        }

        .storage-btn {
            margin-left: auto;
            background-color: #343a40;
            color: white;
            border: none;
            padding: 5px 10px 4px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
        }

        .storage-btn:hover{
            background-color: rgba(52, 58, 64, 0.95);
        }

        tr th,td{
            text-align: center;
        }

        .table{
            margin-top: 10px;
        }

        .table tr td{
            height: 72.5px;
            vertical-align: middle;
        }

        .price-place{
            width: calc(100% - 200px);
            display: flex;
            justify-content: space-between;
            position: relative;
        }

        .table2-container {
            height: 33px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

        .list-table-item {
            display: flex;
            align-items: center;
        }

        .product-info {
            display: flex;
            flex-direction: column;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;

        }

        .list-table-item img {
            margin-right: 10px;
        }

        .product-info p{
            margin: -2PX;
            text-align: justify;
            text-overflow: ellipsis;
            max-width: 100%;
            margin-left: 1px;
            margin-right: 1px;
        }

        .modal-content {
            height: 800px;
            padding: 20px;
            border-radius: 10px;
            position: relative;
            text-align: left;
        }

        .input-space{
            width: 48%;
            height: 100%;
            max-height: 600px;
            overflow-y: auto;
            position: absolute;
            left: 10px;
        }

        .input-space> input, .input-space> select{
            width: 80%;
            height: 40px;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .list-space{
            width: 52%;
            height: 100%;
            max-height: 600px;
            overflow-y: auto;
            position: absolute;
            right: 10px;
        }

        .add-product-btn {
            margin-left: auto;
            background-color: #343a40;
            color: white;
            border: none;
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 8px;
        }

        .add-product-btn:hover {
            background-color: rgba(52, 58, 64, 0.95);
        }

        .input-space2{
            width: 100%;
            height: 10%;
            display: flex;
            gap: 10px;
        }

        .list-space2{
            width: 100%;
            height: 90%;
            max-height: 560px;
            overflow-y: auto;
        }

        .input-space2>input:nth-child(1){
            width: 200px;
            height: 30px;
            font-size: 16px;
            border-radius: 8px;
            background: white;
        }

        .input-space2>input:nth-child(2){
            width: 60px;
            height: 30px;
            font-size: 18px;
            border-radius: 8px;
            background: white;
        }

        .row-checkbox{
            height: 20px;
            width: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
            margin-bottom: 10px;
        }

        .pagination a {
            text-decoration: none;
            color: #000000;
            padding: 10px 15px;
            margin: 0 5px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .pagination a:hover {
            background-color: #717171;
        }

        .pagination .active {
            background-color: #000000;
            color: white;
            border: 1px solid #000000;
        }

        .pagination .disabled {
            color: #ccc;
            cursor: not-allowed;
        }

        .table-container .pagination {
            margin-bottom: auto;
        }

    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div class="container-fluid">

    <jsp:include page="../common/sidebar.jsp"/>

    <main>

        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">입고</h1>
        </div>

        <div class="stockIn-management">
            <div class="table1">
                <div id="search-bar">
                    <form id="statusForm" method="get" action="stockIn.sto">
                        <div id="search-bar-1">
                            <select id="stockIn-search-bar" name="status">
                                <option value="전체" ${selectedStatus == '전체' ? 'selected' : ''}>전체</option>
                                <option value="STOCK_IN_REGISTERED" ${selectedStatus == 'STOCK_IN_REGISTERED' ? 'selected' : ''}>입고 등록</option>
                                <option value="STOCK_IN_PROGRESS" ${selectedStatus == 'STOCK_IN_PROGRESS' ? 'selected' : ''}>입고중</option>
                                <option value="STOCK_IN_COMPLETED" ${selectedStatus == 'STOCK_IN_COMPLETED' ? 'selected' : ''}>입고 완료</option>
                            </select>

                            <input type="date" id="date1" name="startDate" value="${startDate}">
                            ~
                            <input type="date" id="date2" name="endDate" value="${endDate}">

                            <button type="submit" class="search-btn" id="submit-btn">조회</button>
                        </div>
                    </form>

                    <button class="storage-btn" id="storage-submit-btn" onclick="showModal()">입고서 등록</button>
                </div>
                <div>
                    <table class="table table1 table-striped table-hover" id="stock-table">
                        <thead>
                        <tr>
                            <th>입고번호</th>
                            <th>상태</th>
                            <th>입고신청일자</th>
                            <th>입고예정일자</th>
                            <th>입고금액</th>
                            <th>요청자</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty stock}">
                                <c:forEach var="s" items="${stock}">
                                    <c:if test="${s.stockStatus eq 'STOCK_IN_REGISTERED' or s.stockStatus eq 'STOCK_IN_PROGRESS' or s.stockStatus eq 'STOCK_IN_COMPLETED'}">

                                        <tr data-storage-no="${s.stockNo}">
                                            <td>${s.stockNo}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${s.stockStatus eq 'STOCK_IN_REGISTERED'}">
                                                        <span class="badge bg-secondary">입고 등록</span>
                                                    </c:when>
                                                    <c:when test="${s.stockStatus eq 'STOCK_IN_PROGRESS'}">
                                                        <span class="badge bg-warning">입고중</span>
                                                    </c:when>
                                                    <c:when test="${s.stockStatus eq 'STOCK_IN_COMPLETED'}">
                                                        <span class="badge bg-success">입고 완료</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${s.stockDate}</td>
                                            <td>${s.expDate}</td>
                                            <td>
                                                <c:set var="totalAmount" value="0" />
                                                <c:forEach var="p" items="${stockProduct}">
                                                    <c:if test="${p.stockNo eq s.stockNo}">
                                                        <c:set var="itemTotal" value="${p.amount * p.price + p.taxPrice}" />
                                                        <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                                                    </c:if>
                                                </c:forEach>
                                                <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true" />
                                            </td>

                                            <td>${s.memName}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${memName eq s.memName and s.stockStatus eq 'STOCK_IN_REGISTERED' or position eq 'manager' and s.stockStatus eq 'STOCK_IN_REGISTERED'}">
                                                        <button type="button" class="btn btn-outline-danger btn-sm btn-delete" onclick="cancelStock('${s.stockNo}')">삭제</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-outline-danger btn-sm btn-delete" disabled>삭제</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7">입고 데이터가 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>

                        </tbody>

                    </table>
                    <div class="pagination">
                        <c:choose>
                            <c:when test="${pi.currentPage == 1}">
                                <a href="#" class="disabled">이전</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageUrl}?cpage=${pi.currentPage - 1}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}">이전</a>
                            </c:otherwise>
                        </c:choose>

                        <!-- 숫자 버튼 -->
                        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                            <c:choose>
                                <c:when test="${i == pi.currentPage}">
                                    <a href="#" class="active">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageUrl}?cpage=${i}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- 다음 버튼 -->
                        <c:choose>
                            <c:when test="${pi.currentPage == pi.maxPage}">
                                <a href="#" class="disabled">다음</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageUrl}?cpage=${pi.currentPage + 1}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}">다음</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="table2">
                <div class="table2-container">
                    <div class="price-place">
                        <div id="item-count" style="font-weight: bold; font-size: 14px;">1 품목</div>
                        <div id="total-amount" style="font-weight: bold; font-size: 14px;">총 수량 2</div>
                        <div id="total-summary" style="font-weight: bold; font-size: 14px;">
                            총 공급가액 0원 + 총 부가세 0원 = 총 합계금액 0원
                        </div>
                    </div>
                    <% if (position.equals("manager")) { %>
                    <div>
                        <button class="storage-btn" id="storage-approve-btn" onclick="approveStock()">입고 승인</button>
                    </div>
                    <% } %>
                </div>
                <div>
                    <table class="table table2 table-striped table-hover">
                        <thead>
                        <tr>
                            <th colspan="2" style="width: 35%;">품목</th>
                            <th>입고수량</th>
                            <th>구매단가</th>
                            <th>공급가액</th>
                            <th>부가세</th>
                            <th>합계금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="sp" items="${stockProduct}">
                            <c:forEach var="s" items="${stock}">
                                <c:if test="${sp.stockNo eq s.stockNo and s.stockStatus eq 'STOCK_IN_REGISTERED'}">
                                    <tr>
                                        <td colspan="2" class="list-table-item">
                                            <input type="hidden" value="${sp.stockNo}" class="stockNo">
                                            <c:forEach var="i" items="${image}">
                                                <c:if test="${i.productNo eq sp.productNo}">
                                                    <c:choose>
                                                        <c:when test="${empty i.imageUrl}">
                                                            <img src="<c:url value='/resources/default.png' />" style="width: 50px; height: 50px;" alt="제품사진">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="<c:url value='${i.imageUrl}' />" style="width: 50px; height: 50px;" alt="제품사진">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                            <div class="product-info">
                                                <p style="font-size: 14px;">${sp.productNo}</p>
                                                <p style="font-weight:600; font-size: 14px;">${sp.productName}</p>
                                                <p style="font-size: 12px;">${sp.categoryName} ${sp.color} ${sp.productSize}</p>
                                            </div>
                                        </td>
                                        <td></td>
                                        <td>${sp.amount}</td>
                                        <td><fmt:formatNumber value="${sp.price}" type="number" groupingUsed="true" /></td>
                                        <td><fmt:formatNumber value="${sp.amount * sp.price}" type="number" groupingUsed="true" /></td>
                                        <td><fmt:formatNumber value="${sp.taxPrice}" type="number" groupingUsed="true" /></td>
                                        <td><fmt:formatNumber value="${sp.amount * sp.price + sp.taxPrice}" type="number" groupingUsed="true" /></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<%--입고서 모달--%>
<div class="modal fade" id="modal1" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">입고서 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <form>
                    <div class="input-space">
                        <h6>입고 번호</h6>
                        <input type="text" placeholder="자동 생성" readonly >
                        <h6>요청자</h6>
                        <input type="text" id="memName" value="${sessionScope.memName}" readonly>
                        <input type="hidden" id="empNo" value="${sessionScope.empNo}" >
                        <h6>입고처</h6>
                        <select id="client-search-bar">
                            <c:forEach var="c" items="${client}">
                                <option value="${c.clientId}">${c.clientName}</option>
                            </c:forEach>
                        </select>
                        <h6>입고 예정 일자</h6>
                        <input type="date" id="expected-date" readonly>
                        <h6>창고 번호</h6>
                        <select id="storage-search-bar">
                            <c:forEach var="s" items="${storage}">
                                <c:if test="${s.storeId eq sessionScope.storeId}">
                                    <option value="${s.storageNo}">${s.storageLocation}(${s.currentAmount}/${s.ableAmount})</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="list-space">
                        <div style="padding-bottom: 10px; display: flex; justify-content: space-between; align-items: center;">
                            <h6>입고 품목 정보</h6>
                            <button type="button" class="add-product-btn" id="add-product-btn" onclick="showModal2()">+ 품목 추가</button>
                        </div>

                        <h6 style="font-size: 13px;" id="allProductInfo">0 품목 총 수량 0 합계금액 0원 + 부가세 0원 = 총 0원</h6>
                        <hr>
                        <table class="table modal-table1 table-striped table-hover" id="stockIn-table">
                            <thead>
                            <tr>
                                <th colspan="2" style="width: 35%;">품목</th>
                                <th>입고수량</th>
                                <th>구매단가</th>
                                <th>과세여부</th>
                                <th>삭제</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </form>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="stock-submit-btn">확인</button>
            </div>
        </div>
    </div>
</div>

<%--입고서 확인 모달--%>
<div class="modal fade" id="modal3" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="UpdatemodalTitle">입고서</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="input-space">
                    <h6>입고 번호</h6>
                    <input type="text" id="stockNo">
                    <h6>요청자</h6>
                    <input type="text" id="stockEmp">
                    <h6>입고 예정 일자</h6>
                    <input type="text" id="expDate">
                    <h6>창고 번호</h6>
                    <input type="text" id="storageLocation">
                </div>
                <div class="list-space">
                    <div style="padding-bottom: 10px; display: flex; justify-content: space-between; align-items: center;">
                        <h6>입고 품목 정보</h6>
                    </div>

                    <h6 style="font-size: 13px;">0 품목 총 수량 0 합계금액 0원 + 부가세 0원 = 총 0원</h6>
                    <hr>
                    <table class="table modal-table1 table-striped table-hover">
                        <thead>
                        <tr>
                            <th colspan="2" style="width: 35%;">품목</th>
                            <th>입고수량</th>
                            <th>구매단가</th>
                            <th>과세여부</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<%--물품 추가 모달--%>
<div class="modal fade" id="modal2" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle2">품목 선택</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body">
                <div class="input-space2">
                    <input type="text" id="product-search-input" placeholder="품목명">
                    <input type="button" id="product-search-btn" value="조회" onclick="searchProduct()">
                </div>
                <div class="list-space2">
                    <table class="table modal-table1 table-striped table-hover" id="product-table">
                        <thead>
                        <tr>
                            <th colspan="2" style="width: 35%;">품목</th>
                            <th>구매단가</th>
                            <th>판매단가</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="product-selection-btn">확인</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/stockIn.js"></script>

<script>
    window.approveStock = function () {
        const stockNoInputs = document.querySelectorAll("input.stockNo");

        if (stockNoInputs.length === 0) {
            alert("입고서 먼저 작성해주세요.");
            return;
        }

        // 입고 승인 모달 띄우기
        const confirmApprove = confirm("입고를 승인하시겠습니까?");
        if (!confirmApprove) return;

        const stockNos = Array.from(stockNoInputs).map(input => input.value);
        const uniqueStockNos = [...new Set(stockNos)];

        $.ajax({
            url: "/api/updateStockIn",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({ stockNos: uniqueStockNos }),
            success: function () {
                alert("입고 승인이 완료되었습니다.");
                location.reload();
            },
            error: function (xhr, status, error) {
                console.error("상태 변경 실패:", error);
                alert("입고 승인에 실패했습니다.");
            }
        });
    }

    window.cancelStock = function (stockNo) {
        const confirmed = confirm("정말 입고서를 삭제하시겠습니까?");
        if (!confirmed) return;

        $.ajax({
            url: "/api/deleteStock",
            method: "POST",
            data: { stockNo: stockNo },
            success: function () {
                alert("입고서가 삭제되었습니다.");
                location.reload();
            },
            error: function () {
                alert("삭제 실패하였습니다.");
            }
        });
    };


    $(document).ready(function () {
        $("#stock-table tbody").on("click", "tr", function (e) {
            // 삭제 버튼 누르면 모달 안 뜨게 막기
            if ($(e.target).closest(".btn-delete").length > 0) return;

            const stockNo = $(this).data("storage-no");
            if (stockNo) {
                openUpdateModal(stockNo);
            }
        });
    });


    window.openUpdateModal = function (stockNo) {
        $.ajax({
            url: "/api/selectStock",
            method: "GET",
            data: { stockNo: stockNo },
            success: function (data) {
                fillUpdateModal(data);
                const modal = new bootstrap.Modal(document.getElementById("modal3"));
                modal.show();
            },
            error: function () {
                alert("입고서 정보를 불러오는 데 실패했습니다.");
            }
        });
    };

    function fillUpdateModal(data) {
        const stock = data.stock;
        const products = data.stockProducts;

        // --- 입력 필드 채우기 ---
        $("#stockNo").val(stock.stockNo).prop("readonly", true);
        $("#stockEmp").val(stock.memName).prop("readonly", true);
        $("#expDate").val(stock.expDate).prop("readonly", true);
        const storageLocation = products.length > 0 ? products[0].storageLocation : null;
        $("#storageLocation").val(storageLocation).prop("readonly", true);


        // --- 입고 품목 테이블 채우기 ---
        const tbody = $("#modal3 .modal-table1 tbody");
        tbody.empty();

        products.forEach(function(product) {
            const imageUrl = product.imageUrl && product.imageUrl.trim() !== "" ? product.imageUrl : "/resources/default.png";
            const imgSrc = "<img src=\"" + imageUrl + "\" style=\"width: 50px; height: 50px;\" alt=\"제품사진\">";

            const inputAmount = "<input type=\"number\" min=\"1\" value=\"" + product.amount + "\" class=\"input-quantity\" style=\"width:50px;\" readonly>";

            const selectTax =
                "<select class=\"select-tax\" disabled>" +
                "<option value=\"0\"" + (product.tax === 0 ? " selected" : "") + ">과세</option>" +
                "<option value=\"1\"" + (product.tax === 1 ? " selected" : "") + ">비과세</option>" +
                "</select>";

            const productInfo =
                "<div class=\"product-info\">" +
                "<p style=\"font-size: 14px;\">" + product.productNo + "</p>" +
                "<p style=\"font-weight:600; font-size: 14px;\">" + product.productName + "</p>" +
                "<p style=\"font-size: 12px;\">" + product.categoryName + " " + product.color + " " + product.productSize + "</p>" +
                "</div>";

            const productTr = document.createElement("tr");
            productTr.setAttribute("data-product-no", product.productNo);

            const tdProduct = document.createElement("td");
            tdProduct.classList.add("list-table-item");
            tdProduct.innerHTML = imgSrc + productInfo;
            productTr.appendChild(tdProduct);

            const tdNone = document.createElement("td");
            productTr.appendChild(tdNone);

            const tdInput = document.createElement("td");
            tdInput.innerHTML = inputAmount;
            productTr.appendChild(tdInput);

            const tdInPrice = document.createElement("td");
            tdInPrice.classList.add("td-unit-price");
            tdInPrice.innerText = product.price.toLocaleString();
            productTr.appendChild(tdInPrice);

            const tdselect = document.createElement("td");
            tdselect.innerHTML = selectTax;
            productTr.appendChild(tdselect);

            tbody.append(productTr);
        });

        let totalCount = 0;
        let totalPrice = 0;
        let taxAmount = 0;

        products.forEach(function(p) {
            totalCount += p.amount;
            totalPrice += p.amount * p.price;
            taxAmount += p.taxPrice

        });

        const totalWithTax = totalPrice + taxAmount;
        const summaryText = products.length + " 품목 총 수량 " + totalCount +
            " 합계금액 " + totalPrice.toLocaleString() + "원 + 부가세 " + taxAmount.toLocaleString() +
            "원 = 총 " + totalWithTax.toLocaleString() + "원";

        $("#modal3 .list-space > h6").first().text(summaryText);
    }

</script>

</body>
</html>