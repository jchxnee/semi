<%@ page import="com.kh.semi.domain.vo.Member" %><%--지점장 재고관리 재고/입출고  페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Title</title>

  <style>
    main{
      margin-left: 250px;  /* ms-sm-auto */
      /*margin-right: auto;*/
      width: 85.3%;  /* col-lg-10 (10/12 * 100%) */
      padding-left: 24px;  /* px-md-4 */
      /*padding-right: 24px;*/
      padding-top: 130px;
    }

    select{
      border-radius: 8px;
    }

    #search-bar {
      display: flex;
      align-items: center; /* 수평 정렬 */
      justify-content: flex-start; /* 왼쪽으로 배치 */
    }

    #search-option-bar{
      width: 90px;
      height: 35px;
      font-size: 22px;
      margin-right: 20px; /* 각 요소 간 간격 */
      margin-bottom: 5px;
    }

    #storage-select-bar {
      width: 120px;
      height: 35px;
      font-size: 22px;
      margin-right: 20px;
    }

    #product-search-bar {
      width: 300px;
      height: 35px;
      padding: 5px;
      margin-right: 10px;
      font-size: 22px;
      border-radius: 8px;
    }

    #stockProduct-search-bar{
      width: 300px;
      height: 35px;
      padding: 5px;
      margin-right: 10px;
      font-size: 22px;
      border-radius: 8px;
    }

    #submit-btn {
      width: 80px;
      /*height: 35px;*/
      /*font-size: 22px;*/
      /*border-radius: 8px;*/
      /*cursor: pointer;*/
    }

    input[type="date"]{
      font-size: 20px;
      height: 35px;
      font-weight: 500;
    }
    #start-date{
      margin-right: 10px;
    }
    #wave{
      font-size: 24px;
      font-weight: 500;
    }
    #end-date{
      margin-left: 10px;
      margin-right: 10px;
    }

    .table-container{
      width: 100%;
      position:relative;
    }


    .table-container>table{
      width: 100%;
      font-size: 16px;
      color: black;
      text-align: center;
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

  </style>
</head>

<body>

<jsp:include page="../common/header.jsp"/>
<div class="container-fluid">
<jsp:include page="../common/sidebar.jsp"/>


<main>
  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">재고관리</h1>
  </div>

  <!-- 재고/입출고 선택 -->
  <div id="search-bar">
    <select id="search-option-bar">
      <option value="inventory">재고</option>
      <option value="inout">입출고</option>
    </select>

    <!-- 재고 관련 옵션 (창고명, 상품명 검색) -->
    <div id="inventory-search" class="search-fields">
      <select id="storage-select-bar">
          <%--창고명 옵션--%>
      </select>
      <input type="text" placeholder="상품명" id="product-search-bar">
      <button class="btn btn-primary" type="submit" id="inventory-search-btn" onclick="inventorySearch()">조회</button>
    </div>

    <!-- 입출고 관련 옵션 (날짜 범위) -->
    <div id="inout-search" class="search-fields" style="display: none;">
      <input type="date" id="start-date"> <span id="wave"> ~ </span>
      <input type="date" id="end-date">
      <input type="text" placeholder="상품명" id="stockProduct-search-bar">
      <button class="btn btn-primary" type="submit" id="stockInOut-search-btn" onclick="stockProductSearch()">조회</button>
    </div>
  </div>


  <%--재고페이지--%>

  <div id="inventory-section">
    <div class="table-container">
      <table class="table table-striped table-hover align-middle">
        <thead>
        <tr>
          <th>창고명</th>
          <th>상품번호</th>
          <th>상품명</th>
          <th>카테고리</th>
          <th>색상</th>
          <th>사이즈</th>
          <th>재고수량</th>
        </tr>
        </thead>
        <tbody id="inventory-list">
          <%-- 재고 리스트 --%>
        </tbody>
      </table>
      <!-- 재고용 -->
      <div id="inventory-pagebar" class="pagination"></div>
    </div>
  </div>

  <!-- 입출고 페이지 -->

  <div id="inout-section" style="display: none;">
    <div class="table-container">
      <table class="table table-striped table-hover align-middle">
        <thead>
        <tr>
          <th>입고/출고</th>
          <th>상품번호</th>
          <th>상품명</th>
          <th>색상</th>
          <th>사이즈</th>
          <th>지시번호</th>
          <th>일자</th>
          <th>수량</th>
        </tr>
        </thead>
        <tbody id="inout-list">
          <!--입출고 리스트 -->
        </tbody>
      </table>
        <!-- 입출고용 -->
        <div id="stockProduct-pagebar" class="pagination"></div>
      </div>
    </div>

</main>
</div>


<%
 int storeId = (int)session.getAttribute("storeId");
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

  // 1. 재고/입출고 선택 시 섹션 전환 및 필드 표시 전환
  document.getElementById("search-option-bar").addEventListener("change", function () {
    const selectedValue = this.value;

    // 선택된 값에 따라 섹션 및 필드 전환
    if (selectedValue === "inventory") {
      document.getElementById("inventory-section").style.display = "block";
      document.getElementById("inout-section").style.display = "none";
      document.getElementById("inventory-search").style.display = "flex";
      document.getElementById("inout-search").style.display = "none";
      inventorySearch();
    } else if (selectedValue === "inout") {
      document.getElementById("inventory-section").style.display = "none";
      document.getElementById("inout-section").style.display = "block";
      document.getElementById("inventory-search").style.display = "none";
      document.getElementById("inout-search").style.display = "flex";
      stockProductSearch();
    }
  });


  //2. 창고명 셀렉트바 불러오기
    $(document).ready(function(){
      getStorageList(drawStorageList);
    });

    function getStorageList(callback){
      $.ajax({
        url: "/api/getStorageList",
        type: "GET",
        success : function (res){
          console.log(res);
          callback(res);
        }, error: function(){
          console.log("storage list ajax 요청 실패");
        }
      })
    }

    function drawStorageList(res){
      //창고 셀렉트 바
      const storageSelectBar = document.getElementById("storage-select-bar")
      storageSelectBar.innerHTML = "";

      //placeholder 역할 기본 옵션
      const placeholderOption = document.createElement("option");
      placeholderOption.value = "";
      placeholderOption.innerText = "전체창고";
      storageSelectBar.appendChild(placeholderOption);

      const sessionStoreId = ${sessionScope.storeId};

      // //data(res) option에 추가
      // res.forEach(storage => {
      //   const option = document.createElement("option");
      //   option.value = storage.storageNo;
      //   option.innerText = storage.storageLocation;
      //   storageSelectBar.appendChild(option);
      // });

      // res 중에서 storeId가 sessionStoreId와 같은 애들만 옵션으로 추가
      res.forEach(storage => {
        if (storage.storeId === sessionStoreId) {
          console.log("세션 아이디 : " + sessionStoreId);
          console.log("스토리지 세션 아이디" + storage.storeId);
          const option = document.createElement("option");
          option.value = storage.storageNo;
          option.innerText = storage.storageLocation;
          storageSelectBar.appendChild(option);
        }
      });

    }


  let currentPage = 1;
  const pageSize = 10;

    //3. 재고 조회
  $(document).ready(function () {
    // 조회 버튼 클릭 시 재고 검색
    $('#inventory-search-btn').on('click', function (e) {
      e.preventDefault();
      inventorySearch();
    });

    //재고 검색창에서 엔터 눌렀을 때
    $('#product-search-bar').on('keydown', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        inventorySearch();
      }
    });

    //입출고 검색창에서 엔터 눌렀을 때
    $('#stockProduct-search-bar').on('keydown', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        stockProductSearch();
      }
    });

    // 페이지 로드시 자동 조회
    inventorySearch();
  });


  // 재고 검색/조회 함수
  function inventorySearch(page=1) {
    currentPage = page;
    const storageNo = $('#storage-select-bar').val();
    const keyword = $('#product-search-bar').val().trim();

    $.ajax({
      url: '/api/searchInventoryList',
      method: 'GET',
      data: {
        selectedStorageNo: storageNo,
        searchedKeyword: keyword,
        page: page,
        pageSize: pageSize
      },
      success: function (res) {

        const data = res.list;
        const totalCount = res.totalCount;
        const pageInfo = res.pageInfo;

        console.log(totalCount);

        let tbodyContent = "";

        if (data.length === 0) {
          tbodyContent = '<tr><td colspan="9" class="text-center">조회 결과가 없습니다.</td></tr>';
        } else {
          data.forEach(function (i) {
            tbodyContent +=
                    "<tr class='inventory-tr'>" +
                    "<td class='td-storageName'>" + i.storageLocation + "</td>" +
                    "<td class='td-productNo'>" + i.productNo + "</td>" +
                    "<td class='td-productName'>" + i.productName + "</td>" +
                    "<td class='td-categoryName'>" + i.categoryName + "</td>" +
                    "<td class='td-color'>" + i.color + "</td>" +
                    "<td class='td-productSize'>" + i.productSize + "</td>" +
                    "<td class='td-quantity'>" + i.quantity + "</td>" +
                    "</tr>";
          });
        }

        $('#inventory-list').html(tbodyContent);
        drawPagebar(pageInfo, '#inventory-pagebar', 'inventorySearch');

        // 검색 조건 유지
        $('#storage-select-bar').val(storageNo);
        $('#product-search-bar').val(keyword);
      },
      error: function (error) {
        console.error('재고를 검색하는데 실패했습니다:', error);
        alert('재고를 검색하는데 실패했습니다');
      }
    });
  }

  const startDateInput = document.getElementById("start-date");
  const endDateInput = document.getElementById("end-date");

  startDateInput.addEventListener("change", function () {
    const startDate = startDateInput.value;
    endDateInput.min = startDate;

    // 만약 end-date가 start-date보다 이전이면 비워버리기
    if (endDateInput.value < startDate) {
      endDateInput.value = "";
    }
  });


    //입출고리스트 불러오기

  function stockProductSearch(page=1){
    currentPage = page;
    const startDate = document.getElementById('start-date').value;
    const endDate = document.getElementById('end-date').value;
    const keyword = document.getElementById('stockProduct-search-bar').value.trim();

    $.ajax({
      url: '/api/searchStockProductList',
      method: 'GET',
      data: {
        selectedStartDate: startDate,
        selectedEndDate: endDate,
        searchedKeyword: keyword,
        page: page,
        pageSize: pageSize
      },
      success: function (res){


        const data = res.list;
        const totalCount = res.totalCount;
        const pageInfo = res.pageInfo;

        let tbodyContent = "";

        if(!data || data.length === 0){
          tbodyContent = '<tr><td colspan="9" class="text-center">조회 결과가 없습니다.</td></tr>';
        } else {
          data.forEach(function(sp){
            let badgeClass = "";
            let badgeText = "";

            if (sp.stockStatus === 'STOCK_IN_COMPLETED'){
              badgeClass = 'bg-primary';
              badgeText = '입고';
            } else if (sp.stockStatus === 'STOCK_OUT_COMPLETED') {
              badgeClass = 'bg-danger';
              badgeText = '출고';
            } else {
              badgeClass = 'bg-secondary';
              badgeText = '기타';
            }

            tbodyContent +=
                    "<tr>" +
                    "<td><span class='badge " + badgeClass + "'>" + badgeText + "</span></td>" +
                    "<td>" + sp.productNo + "</td>" +
                    "<td>" + sp.productName + "</td>" +
                    "<td>" + sp.color + "</td>" +
                    "<td>" + sp.productSize + "</td>" +
                    "<td>" + sp.stockNo + "</td>" +
                    "<td>" + sp.stockDate + "</td>" +
                    "<td>" + sp.amount + "</td>" +
                    "</tr>";

          });
        }
        $('#inout-list').html(tbodyContent);
        drawPagebar(pageInfo, '#stockProduct-pagebar', 'stockProductSearch');

        $('#start-date').val(startDate);
        $('#end-date').val(endDate);
      },
      error: function (error) {
        console.error('입출고 리스트 불러오기에 실패했습니다:', error);
        alert('입출고 리스트 불러오기에 실패했습니다');
      }
    });
  }

  //
  // function drawPagebar(pageInfo, containerId, searchFunctionName){
  //   const totalPages = pageInfo.maxPage; // PageInfo에서 총 페이지 수 가져오기
  //   const currentPage = pageInfo.currentPage;
  //   const pagebar = $(containerId);
  //   pagebar.empty();
  //
  //
  //   let pageHTML = "<div class='pagination'>";
  //
  //   // 이전 버튼
  //   if (currentPage > 1) {
  //     pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + (currentPage - 1) + ")'>이전</a>";
  //   } else {
  //     pageHTML += "<a class='disabled'>이전</a>";
  //   }
  //
  //   // 숫자 버튼
  //   for (let i = 1; i <= totalPages; i++) {
  //     if (i === currentPage) {
  //       pageHTML += "<a class='active'>" + i + "</a>";
  //     } else {
  //       pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + i + ")'>" + i + "</a>";
  //     }
  //   }
  //
  //   // 다음 버튼
  //   if (currentPage < totalPages) {
  //     pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + (currentPage + 1) + ")'>다음</a>";
  //   } else {
  //     pageHTML += "<a class='disabled'>다음</a>";
  //   }
  //
  //   pageHTML += "</div>";
  //
  //   pagebar.html(pageHTML);
  // }

  function drawPagebar(pageInfo, containerId, searchFunctionName) {
    const totalPages = pageInfo.maxPage;
    const currentPage = pageInfo.currentPage;
    const pagebar = $(containerId);
    pagebar.empty();

    let pageHTML = "<div class='pagination'>";

    const pageLimit = 10; // 한번에 보여줄 페이징 버튼 개수
    const currentGroup = Math.floor((currentPage - 1) / pageLimit);
    const startPage = currentGroup * pageLimit + 1;
    let endPage = startPage + pageLimit - 1;
    if (endPage > totalPages) endPage = totalPages;

    // 이전 그룹 버튼
    if (startPage > 1) {
      pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + (startPage - 1) + ")'>이전</a>";
    } else {
      pageHTML += "<a class='disabled'>이전</a>";
    }

    // 페이징 숫자 버튼
    for (let i = startPage; i <= endPage; i++) {
      if (i === currentPage) {
        pageHTML += "<a class='active'>" + i + "</a>";
      } else {
        pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + i + ")'>" + i + "</a>";
      }
    }

    // 다음 그룹 버튼
    if (endPage < totalPages) {
      pageHTML += "<a href='javascript:void(0);' onclick='" + searchFunctionName + "(" + (endPage + 1) + ")'>다음</a>";
    } else {
      pageHTML += "<a class='disabled'>다음</a>";
    }

    pageHTML += "</div>";
    pagebar.html(pageHTML);
  }

</script>
</body>
</html>
