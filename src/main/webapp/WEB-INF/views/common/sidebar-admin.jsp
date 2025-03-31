<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sidebar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        .sidebar {
            background-color: #343a40;
            width: 250px;
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            padding-top: 20px;
        }

        .sidebar .nav-link {
            color: #fff;
            padding: 15px 20px;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .sidebar .nav-link i {
            margin-right: 10px;
            font-size: 18px;
        }

        .sidebar .nav-link:hover {
            background-color: #495057;
        }

        /* 본문 컨텐츠 */
        .content {
            margin-left: 250px;
            padding: 80px 20px 20px; /* 헤더 공간 확보 */
        }
    </style>
</head>
<body>

<!-- 사이드바 -->
<nav class="sidebar">
    <div class="position-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="/dash.bo">
                    <i class="fas fa-home"></i> 대시보드
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/product.bo">
                    <i class="fas fa-box-open"></i> 제품 관리
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/sales.bo">
                    <i class="fas fa-chart-line"></i> 매출 현황
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/accept.ma">
                    <i class="fas fa-user-check"></i> 지점장 승인
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/accept.me">
                    <i class="fas fa-user-plus"></i> 직원 승인
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/delivery.ma">
                    <i class="fas fa-truck"></i> 입고처 관리
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/employee.in">
                    <i class="fas fa-users"></i> 직원 정보
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/list.bo">
                    <i class="fas fa-bullhorn"></i> 공지사항
                </a>
            </li>
        </ul>
    </div>
</nav>

</body>
</html>
