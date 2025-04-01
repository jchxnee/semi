<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지점장 대시보드</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>

        main {
            width: 85.3%;  /* col-lg-10 (10/12 * 100%) */
            margin-left: 250px; /* ms-sm-auto 대체 */
            /*margin-right: auto; !* 가운데 정렬 *!*/
            padding-left: 24px;  /* px-md-4 */
            /*padding-right: 24px;*/
            /*padding-top: 130px;*/
        }

        body {
            padding-top: 150px;
        }

        .dashboard-card {
            border-radius: 10px;
            padding: 20px;
            color: white;
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .dashboard-card:hover {
            transform: scale(1.02);
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
        }

        .card-body {
            font-size: 15px;
            display: flex;
            justify-content: center;
        }
        .card-body-work {
            display: flex;
            text-align: center;
            justify-content: space-around;

        }
        .card-body span:hover{
            scale: 1.05;
            cursor: pointer;
        }

        .card-body img {
            width: 100px;
            height: 100px;
            padding: 5px;
        }
        .card-body img:hover {
            background: #007bff;
            scale: 1.05;
        }

        /* 공통 스타일 */
        .dashboard-card {
            border-radius: 10px;
            padding: 20px;
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .dashboard-card:hover {
            transform: scale(1.02);
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
        }

        .card-body {
            font-size: 15px;
            display: flex;
            justify-content: center;
        }

        .card-footer {
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }

        /* 카드별 색상 */
        .card-warning {
            background-color: #FFE5E5; /* 연한 붉은색 */
            color: #000000; /* 진한 빨강 */
        }

        .card-sales {
            background-color: #ffeede; /* 밝은 회색 */
            color: #102840; /* 진한 네이비 */
        }

        .card-popular {
            background-color: #E3F2FD; /* 밝은 하늘색 */
            color: #000000; /* 진한 파랑 */
        }

        .card-inventory {
            background-color: #FFF8E1; /* 연한 노랑 */
            color: #000000; /* 진한 오렌지 */
        }

        .card-notice {
            background-color: #E3F2FD; /* 밝은 하늘색 */
            color: #000000; /* 진한 파랑 */
        }

        .card-popular {
            background-color: #EDE7F6; /* 연한 보라색 */
            color: #000000; /* 진한 보라색 */
        }
        .card-employee {
            background-color: #e5ffdc ; /* 연한 보라색 */
            color: #000000; /* 진한 보라색 */
        }




        .card-footer {
            font-size: 14px;
            font-weight: bold;
            text-align: center;
        }

        .card-container {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr; /* 3개씩 배치 */
            gap: 20px;
            margin-top: 30px;
        }

        /* 화면 크기에 따른 반응형 처리 */
        @media (max-width: 768px) {
            .card-container {
                grid-template-columns: 1fr;
                grid-template-areas:
                    "warning"
                    "sales"
                    "popular"
                    "notice"
                    "inventory";
            }
        }
        #work{
            width: 50px;
            height: 50px;
        }
        #nowork{
            width: 45px;
            height: 45px;
            margin-bottom: 5px;
        }
        .nowork{
            margin-left: 30px;
        }
        .delivery{
            padding: 20px;
            font-size: 15px;
        }
    </style>
</head>
<body>

<jsp:include page="../common/header-manager.jsp"/>

<div class="container-fluid">

    <!-- 사이드바 -->
    <jsp:include page="../common/sidebar-manager.jsp"/>

    <!-- 메인 내용 -->
    <main>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">지점장 대시보드</h1>
        </div>

        <div class="card-container">
            <!-- 부족한 재고 카드 -->
            <div class="dashboard-card card-warning">
                <div class="card-title">⚠️ 부족한 재고</div>
                <div class="card-body">
                    <span>뉴발란스 992 재고부족수량 : 5</span>
                </div>
                <div class="card-body">
                    <span>에어포스1 07 WB 재고부족수량 : 2</span>
                </div>
                <div class="card-body">
                </div>
                <div class="card-footer">조치를 취해주세요</div>
            </div>

            <!-- 고객 피드백 카드 -->
            <div class="dashboard-card card-notice">
                <div class="card-title">📢 공지사항</div>
                <div class="card-body">
                    <span>조별상의 후 컨텐츠 결정할예정입니다.</span>
                </div>
                <div class="card-body">
                    <span>조별상의 후 컨텐츠 결정할예정입니다.</span>
                </div>
                <div class="card-footer">피드백 확인</div>
            </div>

            <!-- 매출 그래프 카드 -->
            <div class="dashboard-card card-sales">
                <div class="card-title">💰 우리지점 매출</div>
                <div class="card-body">
                    <a>목표 매출액 : 300만원</a>
                </div>
                <div class="card-body">
                    <a>현재 매출액 : 237만원</a>
                </div>
                <div class="card-body">

                </div>
                <div class="card-footer">매출 분석 필요</div>
            </div>

            <!-- 인기 제품 카드 -->
            <div class="dashboard-card card-popular">
                <div class="card-title">👟 이번주 인기 제품</div>
                <div class="card-body">
                    <img src="/resources/samba.png">
                    <img src="/resources/newbalance.png">
                    <img src="/resources/airpose.png">
                    <img src="/resources/asics.png">
                </div>
                <div class="card-footer">재고 확인 필요</div>
            </div>


            <!-- 배송 상태 카드 -->
            <div class="dashboard-card card-inventory">
                <div class="card-title">🚚 입출고 현황</div>
                <div class="card-body">
                    <span class="delivery">입고 : 12개</span>
                    <span class="delivery">출고 : 60개</span>
                </div>
                <div class="card-body">

                </div>
                <div class="card-footer">배송 현황 확인</div>
            </div>

            <!-- 직원 근무 현황 카드 -->
            <div class="dashboard-card card-employee">
                <div class="card-title">👥 직원 근무 현황</div>
                <div class="card-body">
                    <div class="card-body-work">
                        <div class="work"><img src="/resources/work.png" id="work"> <h4>3</h4></div>
                        <div class="nowork"><img src="/resources/nowork.png" id="nowork"> <h4>3</h4></div>
                    </div>
                </div>

                <div class="card-footer">근무 현황 확인</div>
            </div>



        </div>

    </main>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
