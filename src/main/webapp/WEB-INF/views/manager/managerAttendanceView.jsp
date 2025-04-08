<%@ page import="com.kh.semi.domain.vo.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>근태관리</title>
    <style>
        main {
            margin-left: 250px;
            width: 85.3%;
            padding-left: 24px;
            margin-top: 130px;
        }
        select {
            border-radius: 8px;
        }
        #search-bar {
            display: flex;
        }
        #name-search-bar {
            width: 120px;
            height: 35px;
            font-size: 20px;
            margin-right: 20px;
        }
        input[type="date"] {
            font-size: 20px;
            height: 35px;
            font-weight: 500;
        }
        #start-date {
            margin-right: 10px;
        }
        #wave {
            font-size: 24px;
            font-weight: 500;
        }
        #end-date {
            margin-left: 10px;
            margin-right: 10px;
        }
        #submit-btn {
            width: 80px;
            height: 35px;
            font-size: 22px;
            border-radius: 8px;
            margin: 0;
            padding: 0;
            cursor: pointer;
        }
        .table-container {
            width: 100%;
        }
        .table-container > table {
            width: 100%;
            font-size: 18px;
            color: black;
            text-align: center;
        }
        .table-container > table > thead {
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
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="container-fluid">
    <jsp:include page="../common/sidebar.jsp"/>
    <main>
        <div class="pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">근태관리</h1>
        </div>
        <form action="selectAttendance.ma" method="get">
            <div id="search-bar">
                <select id="name-search-bar" name="empName">
                    <option value="">전체</option>
                    <c:forEach var="name" items="${empNameList}">
                        <option value="${name}" <c:if test="${name == selectedEmpName}">selected</c:if>>${name}</option>
                    </c:forEach>
                </select>

                <input type="date" id="start-date" name="startDate" value="${selectedStartDate}">
                <span id="wave"> ~ </span>
                <input type="date" id="end-date" name="endDate" value="${selectedEndDate}">
                <button type="submit" id="submit-btn">조회</button>
            </div>
        </form>

        <div class="table-container">
            <table class="table table-striped table-hover align-middle">
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
                <c:choose>
                    <c:when test="${not empty listpage}">
                        <c:forEach var="l" items="${listpage}">
                            <tr>
                                <td>${l.attendanceNo}</td>
                                <td><fmt:formatDate value="${l.clockIn}" pattern="yyyy-MM-dd"/></td>
                                <td>${l.memName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${l.status == 'W'}">
                                            <span class="badge bg-success">출근</span>
                                        </c:when>
                                        <c:when test="${l.status == 'L'}">
                                            <span class="badge bg-secondary">퇴근</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${l.clockIn}" pattern="HH : mm : ss"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty l.clockOut}">
                                            <fmt:formatDate value="${l.clockOut}" pattern="HH : mm : ss"/>
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty l.workTime}">
                                            ${l.workTime}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button
                                            type="button"
                                            class="btn btn-sm btn-primary edit-btn"
                                            data-attendance-no="${l.attendanceNo}"
                                            data-clock-in="${l.clockIn}"
                                            data-clock-out="${l.clockOut}"
                                            data-status="${l.status}"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editModal">
                                        수정
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8">출퇴근 데이터가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>

            </table>

            <!-- 수정 모달 -->
            <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <form id="editForm" method="post" action="/updateAttendance.ma">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">근태 수정</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="attendanceNo" id="modalAttendanceNo" />
                                <div class="mb-3">
                                    <label for="modalClockIn" class="form-label">출근 시간</label>
                                    <input type="datetime-local" class="form-control" name="clockIn" id="modalClockIn" />
                                </div>
                                <div class="mb-3">
                                    <label for="modalClockOut" class="form-label">퇴근 시간</label>
                                    <input type="datetime-local" class="form-control" name="clockOut" id="modalClockOut" />
                                </div>
                                <div class="mb-3">
                                    <label for="modalStatus" class="form-label">상태</label>
                                    <select name="status" id="modalStatus" class="form-select">
                                        <option value="W">출근</option>
                                        <option value="L">퇴근</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">저장</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="pagination">
                <!-- 이전 버튼 -->
                <c:choose>
                    <c:when test="${pi.currentPage == 1}">
                        <a href="#" class="disabled">이전</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageUrl}?cpage=${pi.currentPage - 1}">이전</a>
                    </c:otherwise>
                </c:choose>

                <!-- 숫자 버튼 -->
                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${i == pi.currentPage}">
                            <a href="#" class="active">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageUrl}?cpage=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 다음 버튼 -->
                <c:choose>
                    <c:when test="${pi.currentPage == pi.maxPage}">
                        <a href="#" class="disabled">다음</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageUrl}?cpage=${pi.currentPage + 1}">다음</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const editButtons = document.querySelectorAll('.edit-btn');
        editButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const attendanceNo = btn.getAttribute('data-attendance-no');
                const clockIn = btn.getAttribute('data-clock-in');
                const clockOut = btn.getAttribute('data-clock-out');
                const status = btn.getAttribute('data-status');
                const formatDateTime = (dateStr) => {
                    if (!dateStr) return '';
                    const d = new Date(dateStr);
                    const year = d.getFullYear();
                    const month = (d.getMonth() + 1 < 10 ? '0' : '') + (d.getMonth() + 1);
                    const day = (d.getDate() < 10 ? '0' : '') + d.getDate();
                    const hours = (d.getHours() < 10 ? '0' : '') + d.getHours();
                    const minutes = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                    return `${year}-${month}-${day}T${hours}:${minutes}`;
                };
                document.getElementById('modalAttendanceNo').value = attendanceNo;
                document.getElementById('modalClockIn').value = formatDateTime(clockIn);
                document.getElementById('modalClockOut').value = formatDateTime(clockOut);
                document.getElementById('modalStatus').value = status;
            });
        });


        const editForm = document.getElementById('editForm');
        if (editForm) {
            editForm.addEventListener('submit', function (event) {
                event.preventDefault();

                const formData = new FormData(editForm);

                fetch(editForm.action, {
                    method: 'POST',
                    body: formData
                })
                    .then(res => {
                        if (res.ok || res.redirected) {
                            const modal = bootstrap.Modal.getInstance(document.getElementById('editModal'));
                            modal.hide(); // 모달 닫기
                            location.reload(); // 새로고침
                        } else {
                            alert("수정 실패");
                        }
                    })
                    .catch(() => alert("오류 발생"));
            });
        }
    });
</script>


</body>
</html>
