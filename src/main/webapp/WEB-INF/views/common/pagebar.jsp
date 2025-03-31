<%--
  Created by IntelliJ IDEA.
  User: hyeij
  Date: 25. 3. 27.
  Time: 오후 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        /* 페이지 바 style 부분 */
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

        /* 페이지 바가 최하단으로 밀리도록 설정 */
        .table-container .pagination {
            margin-top: auto;
        }
    </style>
</head>
<body>
<!-- 페이지 바 html부분 -->
<div class="pagination">
    <a href="#" class="disabled">이전</a>
    <a href="#" class="active">1</a>
    <a href="#">2</a>
    <a href="#">3</a>
    <a href="#">4</a>
    <a href="#">5</a>
    <a href="#">다음</a>
</div>
</body>
</html>
