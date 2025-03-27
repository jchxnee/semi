<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <style>
    .container{
      display: flex;
      width : 1440px;
      box-sizing: border-box;
      margin: auto;
    }
    .inventory-management{
      width: 1210px;
      padding: 10px;
      position: relative;
    }
    .pagination{
      position: absolute;
      bottom: 10px;
      left: 50%;
      transform: translateX(-50%);
    }
    select{
      border-radius: 8px;
    }
    #search-bar{
      display: flex;
    }
    #name-search-bar {
      width: 120px;
      height: 45px;
      font-size: 22px;
      margin-right: 20px;
    }
    #submit-btn{
      width: 80px;
      height: 45px;
      font-size: 22px;
      border-radius: 8px;
      margin:0;
      padding: 0;
      cursor: pointer;
    }

    .table-container{
      width: 100%;
      height: calc(100% - 53px);
      background-color: #FFE7D7;
      border-radius: 10px;
      overflow: hidden;
    }
    .table-container>table{
      /*background-color: #FFE7D7;*/

      width: 100%;
      font-size: 22px;
      color: black;

      border-radius: 10px;
      border-collapse: separate;
      border-spacing: 0;
      text-align: center;
    }
    .table-container>table>thead{
      background-color: #FFC9A5;
      height: 50px;
      border-radius: 10px;
    }
    .table-container>table>tbody>tr>td{
      border-bottom: 1px solid black;
      padding: 10px;
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
      color: #005F5B;
      padding: 10px 15px;
      margin: 0 5px;
      border-radius: 5px;
      border: 1px solid #ddd;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }

    .pagination a:hover {
      background-color: #FFC9A5;
    }

    .pagination .active {
      background-color: #00A69F;
      color: white;
      border: 1px solid #00A69F;
    }

    .pagination .disabled {
      color: #ccc;
      cursor: not-allowed;
    }


  </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />


<div class="container">

  <jsp:include page="../common/sidebar.jsp"/>

  <div class="inventory-management">
    <form action="">
      <div id="search-bar">
        <select id="name-search-bar">
          <option>전체</option>
          <option>역삼점</option>
          <option>한남점</option>
          <option>잠실점</option>
          <option>강남점</option>
          <option>송파점</option>
        </select>
        <button type="submit" id="submit-btn">조회</button>
      </div>
    </form>

    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>번호</th>
          <th>입사 날짜</th>
          <th>이름</th>
          <th>지점명</th>
          <th>직급</th>
          <th>연락처</th>
          <th>연봉</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td>4</td>
          <td>2025-03-19</td>
          <td>황동준</td>
          <td>역삼점</td>
          <td>지점장</td>
          <td>010-1111-2222</td>
          <td>30,152,152</td>
        </tr>
        <tr>
          <td>4</td>
          <td>2025-03-19</td>
          <td>김현아</td>
          <td>역삼점</td>
          <td>직원</td>
          <td>010-1111-2222</td>
          <td>30,152,152</td>
        </tr>
        <tr>
          <td>4</td>
          <td>2025-03-19</td>
          <td>이주찬</td>
          <td>역삼점</td>
          <td>직원</td>
          <td>010-1111-2222</td>
          <td>30,152,152</td>
        </tr>
        <tr>
          <td>4</td>
          <td>2025-03-19</td>
          <td>박지민</td>
          <td>역삼점</td>
          <td>직원</td>
          <td>010-1111-2222</td>
          <td>30,152,152</td>
        </tr>

        </tbody>
      </table>
      <div class="pagination">
        <a href="#" class="disabled">이전</a>
        <a href="#" class="active">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">다음</a>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../common/footer.jsp"/>

</body>
</html>