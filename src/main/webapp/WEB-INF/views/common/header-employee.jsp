<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Bootstrap & Font Awesome 적용 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/nanumsquareneo@0.0.5/nanumsquareneo.min.css" rel="stylesheet">
<style>
    * {
        font-family: "NanumSquareNeo", sans-serif;
    }
    #header {
        background: white !important;
        padding: 10px 20px;
        position: fixed;
        top: 0;
        left: 250px;
        width: calc(100% - 250px);
        z-index: 1000;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        height: 130px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .logo-container {
        display: flex;
        align-items: center;
    }

    .logo-container img {
        width: 150px;
        height: auto;
    }

    .header-right {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .header-right div {
        text-align: center;
    }

    .header-right a {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-decoration: none;
        color: black;
    }

    .admin-info {
        text-align: right;
    }

    /* 버튼 기본 스타일 */
    button {
        padding: 8px 16px;
        font-size: 14px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        color: white;
    }

    /* 출근 버튼 (초록색) */
    .start-btn {
        background-color: green;
    }
    /* 근무 중 버튼 (주황색) */
    .working-btn {
        background-color: orange;
    }

    /* 퇴근 버튼 (빨간색) */
    .leave-btn {
        background-color: red;
    }
    #realTimeClock{
        width: 200px;
    }
</style>

<div class="container-fluid bg-light py-3" id="header">
    <div class="logo-container">
        <img src="/resources/logo.png" alt="로고">
    </div>

    <div class="header-right">
        <div>
            <a href="adminmypage.bo" class="text-dark text-decoration-none">
                <i class="fas fa-user fa-2x"></i>
                <div>마이페이지</div>
            </a>
        </div>
        <div>
            <a href="logout.me" class="text-dark text-decoration-none">
                <i class="fas fa-sign-out-alt fa-2x"></i>
                <div>로그아웃</div>
            </a>
        </div>
        <div class="admin-info">
            <div class="fw-bold fs-5">직원1 님</div>
            <div class="text-muted">환영합니다.</div>
        </div>
        <div style="margin-top: 20px">
            <button id="workButton" class="start-btn" onclick="출근()">출근</button>
            <button id="leaveButton" class="leave-btn" onclick="퇴근()">퇴근</button>
            <p id="realTimeClock"></p>
        </div>

    </div>
    <script>
        function 출근() {
            const now = new Date();
            const formattedTime = now.getFullYear() + "-" +
                String(now.getMonth() + 1).padStart(2, '0') + "-" +
                String(now.getDate()).padStart(2, '0') + " " +
                String(now.getHours()).padStart(2, '0') + ":" +
                String(now.getMinutes()).padStart(2, '0') + ":" +
                String(now.getSeconds()).padStart(2, '0');

            alert("출근 시간이 기록되었습니다: " + formattedTime);

            // 버튼 텍스트 변경 + 색상 변경
            let workButton = document.getElementById("workButton");
            workButton.innerText = "근무중";
            workButton.classList.remove("start-btn");
            workButton.classList.add("working-btn");
        }

        function 퇴근() {
            const now = new Date();
            const formattedTime = now.getFullYear() + "-" +
                String(now.getMonth() + 1).padStart(2, '0') + "-" +
                String(now.getDate()).padStart(2, '0') + " " +
                String(now.getHours()).padStart(2, '0') + ":" +
                String(now.getMinutes()).padStart(2, '0') + ":" +
                String(now.getSeconds()).padStart(2, '0');

            alert("퇴근 시간이 기록되었습니다: " + formattedTime);

            // 버튼 텍스트 원래대로 변경 + 색상 원래대로 변경
            let workButton = document.getElementById("workButton");
            workButton.innerText = "출근";
            workButton.classList.remove("working-btn");
            workButton.classList.add("start-btn");
        }

        function updateClock() {
            let now = new Date();
            let formattedDate = now.toISOString().slice(0, 19).replace("T", " ");
            document.getElementById("realTimeClock").innerText = formattedDate;
        }

        setInterval(updateClock, 1000);
        window.onload = updateClock;
    </script>
</div>

