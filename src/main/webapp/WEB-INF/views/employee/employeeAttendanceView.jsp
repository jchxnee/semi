<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--직원 출퇴근 페이지--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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


        select{
            border-radius: 8px;
        }

        #search-bar>img{
            width: 100px;
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

    </style>
</head>
<body>

<jsp:include page="../common/header.jsp" />
<div class="container-fluid">
<jsp:include page="../common/sidebar.jsp"/>

<main>

    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">근태관리</h1>
    </div>



    <div class="table-container">
        <table class="table table-striped table align-middle">
            <thead>
            <tr>
                <th>번호</th>
                <th>날짜</th>
                <th>출근상태</th>
                <th>출근시각</th>
                <th>퇴근시각</th>
                <th>근무시간</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="att" items="${attendList}">
                <tr>
                    <td>${att.attendanceNo}</td>
                    <td><fmt:formatDate value="${att.clockIn}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${att.status == 'W'}">
                                <span class="badge bg-success">출근</span>
                            </c:when>
                            <c:when test="${att.status == 'L'}">
                                <span class="badge bg-secondary">퇴근</span>
                            </c:when>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${att.clockIn}" pattern="HH : mm : ss"/></td>
                    <td>
                        <c:if test="${not empty att.clockOut}">
                            <fmt:formatDate value="${att.clockOut}" pattern="HH : mm : ss"/>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${not empty att.workTime}">
                            ${att.workTime}
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
        <div class="pagebar-container mt-3">
            <jsp:include page="../common/pagebar.jsp"/>
        </div>
    </div>
</main>
</div>


</body>
</html>