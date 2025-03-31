<%--지점장 출퇴근 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>

        main{
            margin-left: 250px;  /* ms-sm-auto */
            /*margin-right: auto;*/
            width: 80%;  /* col-lg-10 (10/12 * 100%) */
            padding-left: 24px;  /* px-md-4 */
            /*padding-right: 24px;*/
            margin-top: 130px;
        }


        .pagination{
            position: absolute;
            left: 60%;
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
            height: 35px;
            font-size: 20px;
            margin-right: 20px;
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

        #submit-btn{
            width: 80px;
            height: 35px;
            font-size: 22px;
            border-radius: 8px;
            margin:0;
            padding: 0;
            cursor: pointer;
        }

        .table-container{
            width: 100%;
        }
        .table-container>table{
            width: 100%;
            font-size: 20px;
            color: black;
            text-align: center;
        }
        .table-container>table>thead{
            height: 40px;
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

        .enroll{
            width: 30px;
            height: 30px;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header-manager.jsp" />


<%--<div class="container">--%>

<jsp:include page="../common/sidebar-manager.jsp"/>



<%--  <div class="attendance-management">--%>
<main>

    <div class="pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">근태관리</h1>
    </div>


    <form action="">
        <div id="search-bar">
            <select id="name-search-bar">
                <option>전체</option>
                <option>박지민</option>
                <option>황동준</option>
                <option>김현아</option>
                <option>이주찬</option>
            </select>
            <input type="date" id="start-date"> <span id="wave"> ~ </span>
            <input type="date" id="end-date">
            <button type="submit" id="submit-btn">조회</button>
        </div>
    </form>

    <div class="table-container">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>번호</th>
                <th>날짜</th>
                <th>이름</th>
                <th>출근상태</th>
                <th>출근시각</th>
                <th>퇴근시각</th>
                <th>근무시간</th>
                <th>수정</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>4</td>
                <td>2025-03-19</td>
                <td>박지민</td>
                <td><img src="/resources/출근status.png"></td>
                <td>08 : 50 : 56</td>
                <td>             </td>
                <td>06 : 08 : 53 </td>
                <td><img src="/resources/enroll.png" class="enroll"> </td>
            </tr>
            <tr>
                <td>3</td>
                <td>2025-03-19</td>
                <td>이주찬</td>
                <td><img src="/resources/퇴근status.png"></td>
                <td>08 : 50 : 56</td>
                <td>15 : 02 : 06</td>
                <td>06 : 08 : 53</td>
                <td><img src="/resources/enroll.png" class="enroll"> </td>
            </tr>
            <tr>
                <td>2</td>
                <td>2025-03-19</td>
                <td>김현아</td>
                <td><img src="/resources/퇴근status.png"></td>
                <td>08 : 50 : 56</td>
                <td>15 : 02 : 06</td>
                <td>06 : 08 : 53</td>
                <td><img src="/resources/enroll.png" class="enroll"> </td>
            </tr>
            <tr>
                <td>2</td>
                <td>2025-03-19</td>
                <td>황동준</td>
                <td><img src="/resources/출근status.png"></td>
                <td>08 : 50 : 56</td>
                <td>15 : 02 : 06</td>
                <td>06 : 08 : 53</td>
                <td><img src="/resources/enroll.png" class="enroll"> </td>
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
</main>
<%--  </div>--%>
<%--</div>--%>

</body>
</html>