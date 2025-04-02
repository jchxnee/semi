<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품관리,수정</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        main{
            margin-left: 250px;  /* ms-sm-auto */
            /*margin-right: auto;*/
            width: 85.3%;  /* col-lg-10 (10/12 * 100%) */
            padding-left: 24px;  /* px-md-4 */
            /*padding-right: 24px;*/
            margin-top: 130px;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .table {
            margin-top: 10px;
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            font-size: 18px;
        }

        th {
            background-color: #FFC9A5;
            font-weight: bold;
        }

        td {
            border-bottom: 1px solid #ccc;
        }

        .action-buttons button {
            margin: 0 5px;
            padding: 5px 10px;
            font-size: 16px;
        }

        .modal-body form .form-control {
            font-size: 16px;
        }

        .modal-footer button {
            font-size: 16px;
        }
        #modalCategory, #enrollmodalCategory, #입고처 {
            width: 100px;  /* 원하는 너비로 조정 */
        }
        #enrollImage{
            width: 100px;
        }

        .main-content {
            padding-left: 2rem;
            padding-right: 2rem;
        }

        .mb-3 {
            display: flex;
            gap: 20px; /* 요소들 간 간격을 20px로 설정 */
            align-items: center; /* 세로 중앙 정렬 */
            margin-bottom: 10px;
        }

        .form-select, input[type="text"], button {
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 220px; /* 너비를 동일하게 설정 */
            box-sizing: border-box;
        }

        .form-select:focus, input[type="text"]:focus {
            border-color: #00A69F;
            outline: none;
        }


        button {
            background-color: #00A69F;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 220px; /* 버튼도 동일한 너비로 설정 */
        }

        button:hover {
            background-color: #008F8B;
        }
        .bottom{
            display: flex;
            justify-content: center; /* 버튼을 가운데 정렬 */
            gap: 15px; /* 버튼 사이 간격 */
            margin-top: 30px;
            padding: 15px;
        }


    </style>
</head>
<body>
<jsp:include page="../common/header-admin.jsp"/>
<div class="container-fluid">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar-admin.jsp"/>
    <!-- Main content -->
    <main>
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">제품관리</h1>
        </div>
        <div class="mb-3">
            <select class="form-select" id="sellSelect" aria-label="판매상품">
                <option value="2025-02">판매상품</option>
                <option value="2025-03">판매 중지 상품</option>
                <option value="2025-04">판매 삭제 상품</option>
            </select>
            <select class="form-select" id="categorySelect" aria-label="카테고리">
                <option value="">전체</option>
            </select>
            <input type="text" id="searchProduct" placeholder="검색할 상품명을 입력하세요.">
            <button>조회</button>
            <button onclick="enrollShoes()">등록</button>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-hover" id="productTable">
                <thead>
                <tr>
                    <th></th>
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>색상</th>
                    <th>사이즈</th>
                    <th>입고(구매)가격</th>
                    <th>출고(판매)가격</th>
                    <th>수정</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${product}">
                    <tr class="product-row" data-category="${p.categoryNo}">
                        <td><input type="checkbox" name=""></td>
                        <td>${p.productNo}</td>
                        <td>${p.productName}</td>
                        <td>${p.categoryName}</td>
                        <td>${p.color}</td>
                        <td>${p.productSize}</td>
                        <td>${p.stockInPrice}</td>
                        <td>${p.stockOutPrice}</td>
                        <td style="width: 100px;"><button class="approve-btn btn btn-success" onclick="showModal(this)"><i class="fas fa-edit"></i></button></td>
                    </tr>
                </c:forEach>


                <script>
                    console.log(p);
                </script>
                </tbody>
            </table>
        </div>

        <div class="bottom">
            <button>중지</button>
            <button>삭제</button>
        </div>

        <div class="pagebar-container mt-3">
            <jsp:include page="../common/pagebar.jsp"/>
        </div>

        <!-- 수정 버튼 누를 시 나오는 모달 창 -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- 모달 헤더 -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">제품 수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- 모달 본문 -->
                    <div class="modal-body">
                        <form id="editForm">
                            <div class="mb-3">
                                <label for="modalShoeName" class="form-label">상품명</label>
                                <input type="text" class="form-control" id="modalShoeName">
                            </div>
                            <div class="mb-3">
                                <label for="modalCategory" class="form-label">카테고리</label>
                                <select class="form-select" id="modalCategory">
                                    <option value="구두">구두</option>
                                    <option value="운동화">운동화</option>
                                    <option value="슬리퍼">슬리퍼</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="modalColor" class="form-label">색상</label>
                                <input type="text" class="form-control" id="modalColor">
                            </div>
                            <div class="mb-3">
                                <label for="modalSize" class="form-label">사이즈</label>
                                <input type="text" class="form-control" id="modalSize">
                            </div>
                            <div class="mb-3">
                                <label for="modalPrice" class="form-label">가격</label>
                                <input type="text" class="form-control" id="modalPrice">
                            </div>
                        </form>
                    </div>

                    <!-- 모달 푸터 -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="saveChanges()">확인</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 등록버튼 누를 시 나오는 모달 창 -->
        <div class="modal fade" id="enrollModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <!-- 모달 헤더 -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="enrollmodalTitle">제품 등록</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <!-- 모달 본문 -->
                    <div class="modal-body">
                        <form id="enrolleditForm">
                            <div class="mb-3">
                                <label for="modalShoeName" class="form-label">상품번호</label>
                                <input type="text" class="form-control" id="enrollmodalShoenum">
                            </div>
                            <div class="mb-3">
                                <label for="modalShoeName" class="form-label">상품명</label>
                                <input type="text" class="form-control" id="enrollmodalShoeName">
                            </div>
                            <div class="mb-3">
                                <label for="modalCategory" class="form-label">카테고리</label>
                                <select class="form-select" id="enrollmodalCategory">
                                    <option value="구두">구두</option>
                                    <option value="운동화">운동화</option>
                                    <option value="슬리퍼">슬리퍼</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="modalColor" class="form-label">색상</label>
                                <input type="text" class="form-control" id="enrollmodalColor">
                            </div>
                            <div class="mb-3">
                                <label for="modalSize" class="form-label">사이즈</label>
                                <input type="text" class="form-control" id="enrollmodalSize">
                            </div>
                            <div class="mb-3">
                                <label for="modalPrice" class="form-label">입고가격</label>
                                <input type="text" class="form-control" id="enrollmodalbuyPrice">
                            </div>
                            <div class="mb-3">
                                <label for="modalPrice" class="form-label">판매가격</label>
                                <input type="text" class="form-control" id="enrollmodalsellPrice">
                            </div>
                            <div class="mb-3">
                                <label for="modalPrice" class="form-label">입고처</label>
                                <select class="form-select" id="입고처">
                                    <option value="supplier1">나이키</option>
                                    <option value="supplier2">아디다스</option>
                                    <option value="supplier3">뉴발란스</option>
                                    <option value="supplier4">아식스</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="modalPrice" class="form-label" id="enrollImage">이미지 삽입</label>
                                <input type="file" class="form-control" id="enrollmodalImage" accept="image/*">
                            </div>

                        </form>
                    </div>

                    <!-- 모달 푸터 -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="enrollSave()">등록</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

    </main>
</div>


</body>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
    //카테고리 셀렉트바 출력하기

    $(document).ready(function() {
        getCategoryList(drawCategorySelect);
    });


    function getCategoryList(callback){
        $.ajax({
            url: "/api/categoryList",
            type: "get",
            success: function (res){
                callback(res);
            }, error: function(){
                console.log("category list ajax 요청 실패");
            }
        })
    }

    function drawCategorySelect(res) {
        //selectbar가져오기
        const categorySelectBar = document.querySelector("#categorySelect");
        //기존select option제거
        categorySelectBar.innerHTML="";
        //기본 선택 option추가
        const defaultOption = document.createElement("option");
        defaultOption.value="";
        defaultOption.innerText="전체";
        categorySelectBar.appendChild(defaultOption);
        //데이터 받아와서 option 추가
        for(const category of res){
            const option = document.createElement("option");
            option.value= category.categoryNo;
            option.innerText= category.categoryName;
            categorySelectBar.appendChild(option);
        }
    }






    //검색
    $(document).ready(function () {
        $("button:contains('조회')").on("click", function () {
            const selectedCategory = $("#categorySelect").val(); // 선택한 카테고리 값
            const selectedStatus = $("#sellSelect").val(); // 선택한 판매 상태 값
            const searchKeyword = $("input[type='text']").val().trim().toLowerCase(); // 입력된 검색어 (공백 제거, 소문자로 변환)

            $(".product-row").each(function () {
                const productCategory = $(this).attr("data-category"); // 상품의 카테고리
                const productStatus = $(this).attr("data-status"); // 상품의 판매 상태 (HTML에서 추가 필요)
                const productName = $(this).find("td:nth-child(3)").text().trim().toLowerCase(); // 상품명 가져오기

                // 필터 조건 확인
                const categoryMatch = selectedCategory === "" || productCategory === selectedCategory;
                const statusMatch = selectedStatus === "" || productStatus === selectedStatus;
                const keywordMatch = searchKeyword === "" || productName.includes(searchKeyword);

                // 모든 조건이 만족하면 보이기, 하나라도 다르면 숨기기
                if (categoryMatch && statusMatch && keywordMatch) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    });

</script>

<script>
    function showModal(button) {
        var row = button.closest("tr");
        // 기존에 "editing-row"가 있던 행에서 제거
        document.querySelectorAll(".editing-row").forEach(r => r.classList.remove("editing-row"));

        // 현재 클릭한 행에 "editing-row" 추가
        row.classList.add("editing-row");
        // tr에서 각 셀 값 가져오기
        var shoeName = row.cells[1].textContent.trim();
        var category = row.cells[2].textContent.trim();
        var color = row.cells[3].textContent.trim();
        var size = row.cells[4].textContent.trim();
        var price = row.cells[5].textContent.trim();

        // 모달 입력 필드에 값 설정
        document.getElementById("modalShoeName").value = shoeName;
        document.getElementById("modalCategory").value = category;
        document.getElementById("modalColor").value = color;
        document.getElementById("modalSize").value = size;
        document.getElementById("modalPrice").value = price;

        // 모달 띄우기
        var modal = new bootstrap.Modal(document.getElementById("editModal"));
        modal.show();
    }
    function saveChanges() {
        // 현재 열린 모달에서 수정된 데이터 가져오기
        var updatedShoeName = document.getElementById("modalShoeName").value;
        var updatedCategory = document.getElementById("modalCategory").value;
        var updatedColor = document.getElementById("modalColor").value;
        var updatedSize = document.getElementById("modalSize").value;
        var updatedPrice = document.getElementById("modalPrice").value;

        // 현재 수정 중인 행(tr) 찾기
        var row = document.querySelector(".editing-row");

        if (row) {
            row.cells[1].textContent = updatedShoeName;
            row.cells[2].textContent = updatedCategory;
            row.cells[3].textContent = updatedColor;
            row.cells[4].textContent = updatedSize;
            row.cells[5].textContent = updatedPrice;

            // 수정 완료 후 클래스 제거
            row.classList.remove("editing-row");
        }

        // 모달 닫기
        var modalElement = document.getElementById("editModal");
        var modalInstance = bootstrap.Modal.getInstance(modalElement);
        modalInstance.hide();
    }
    function enrollShoes(){
        // 모달 띄우기
        var modal = new bootstrap.Modal(document.getElementById("enrollModal"));
        modal.show();
    }
    function enrollSave(){
        // 모달에서 입력된 값 가져오기
        var shoeNum = document.getElementById("enrollmodalShoenum").value.trim();
        var shoeName = document.getElementById("enrollmodalShoeName").value.trim();
        var category = document.getElementById("enrollmodalCategory").value;
        var color = document.getElementById("enrollmodalColor").value.trim();
        var size = document.getElementById("enrollmodalSize").value.trim();
        var buyPrice = document.getElementById("enrollmodalbuyPrice").value.trim();
        var sellPrice = document.getElementById("enrollmodalsellPrice").value.trim();
        var supplier = document.getElementById("입고처").value;

        // 입력값이 비어 있는지 확인
        if (!shoeNum || !shoeName || !category || !color || !size || !buyPrice || !sellPrice || !supplier) {
            alert("모든 필드를 채워주세요.");
            return; // 비어 있으면 함수 종료
        }

        var tableBody = document.querySelector("table tbody"); // tbody를 선택

        // 새로운 tr 생성
        var newRow = document.createElement("tr");

        // 새 행에 데이터 추가
        newRow.innerHTML = `
        <td><input type="checkbox" name=""> ${shoeNum}</td>
       <td>${shoeName}</td>
        <td>${category}</td>
        <td>${color}</td>
        <td>${size}</td>
        <td>${buyPrice}</td>
        <td>${sellPrice}</td>
        <td>${supplier}</td>
        <td class="action-buttons">
            <button class="approve-btn btn btn-success" onclick="showModal(this)">
                <i class="fas fa-edit"></i>
            </button>
        </td>
    `;
        tableBody.appendChild(newRow);
        // 모달 닫기
        var modalElement = document.getElementById("enrollModal");
        var modalInstance = bootstrap.Modal.getInstance(modalElement);
        modalInstance.hide();

        // 폼 초기화
        document.getElementById("enrolleditForm").reset();
    }
</script>
</html>