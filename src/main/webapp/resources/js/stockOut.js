// date1이 변경되면 date2는 date1 + 1일 이상부터 선택 가능
document.getElementById("date1").addEventListener("change", function () {
    const date1 = this;
    const date2 = document.getElementById("date2");

    if (date1.value) {
        const selectedDate1 = new Date(date1.value);
        selectedDate1.setDate(selectedDate1.getDate() + 1);

        const minDate = selectedDate1.toISOString().split("T")[0];
        date2.min = minDate;
        date2.removeAttribute("max"); // 최대 제한 없앰

        // date2가 조건 안 맞으면 초기화
        if (!date2.value || date2.value < minDate) {
            date2.value = "";
        }
    } else {
        date2.min = "2020-01-01";
        date2.value = "";
    }
});

window.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("statusForm");
    const date1 = document.getElementById("date1");
    const date2 = document.getElementById("date2");

    form.addEventListener("submit", function (e) {
        const start = date1.value;
        const end = date2.value;

        if ((start && !end) || (!start && end)) {
            alert("날짜를 모두 선택해주세요.");
            e.preventDefault(); // 제출 막기
        }
    });
});

document.addEventListener("DOMContentLoaded", updateSummary);

// 출고 예정 일자 계산
function setExpectedDate() {
    const dateInput = document.getElementById("expected-date");

    if (!dateInput) return;

    const today = new Date();
    today.setDate(today.getDate() + 2); // 2일 뒤

    const yyyy = today.getFullYear();
    const mm = String(today.getMonth() + 1).padStart(2, '0');
    const dd = String(today.getDate()).padStart(2, '0');

    dateInput.value = `${yyyy}-${mm}-${dd}`;
}

//stockProduct 가격 테이블 변경 시마다 바뀌기
function updateSummary() {
    const rows = document.querySelectorAll(".table2 tbody tr");
    let totalItemCount = 0;
    let totalAmount = 0;
    let totalPrice = 0;
    let totalTax = 0;

    rows.forEach(row => {
        const amount = parseInt(row.querySelector("td:nth-child(3)").textContent.replace(/,/g, '')) || 0;
        const price = parseInt(row.querySelector("td:nth-child(4)").textContent.replace(/,/g, '')) || 0;
        const taxPrice = parseInt(row.querySelector("td:nth-child(6)").textContent.replace(/,/g, '')) || 0;

        totalItemCount++;
        totalAmount += amount;
        totalPrice += (amount * price);
        totalTax += taxPrice;
    });

    const totalSum = totalPrice + totalTax;

    document.getElementById("item-count").textContent = `${totalItemCount} 품목`;
    document.getElementById("total-amount").textContent = `총 수량 ${totalAmount}`;
    document.getElementById("total-summary").textContent =
        `총 공급가액 ${totalPrice.toLocaleString()}원 + 총 부가세 ${totalTax.toLocaleString()}원 = 총 합계금액 ${totalSum.toLocaleString()}원`;
}


//조회한 정보들로 출고 리스트 테이블 그리기
function updateStockTable(data) {
    let tableBody = $("#stock-table tbody");
    tableBody.empty(); // 기존 tbody 비우기

    if (data.length === 0) {
        tableBody.append("<tr><td colspan='8'>검색 결과가 없습니다.</td></tr>");
        return;
    }

    data.forEach(dto => {
        const stock = dto.stock;
        const products = dto.stockProductList;

        let statusBtn = "";
        const removeBtn = `<button type="button" class="btn btn-outline-danger btn-sm">삭제</button>`;

        switch (stock.stockStatus) {
            case "STOCK_OUT_REGISTERED":
                statusBtn = `<span class="badge bg-secondary">출고 등록</span>`;
                break;
            case "STOCK_OUT_PROGRESS":
                statusBtn = `<span class="badge bg-warning">출고중</span>`;
                break;
            case "STOCK_OUT_COMPLETED":
                statusBtn = `<span class="badge bg-success">출고 완료</span>`;
                break;
        }

        const stockTr = document.createElement("tr");
        stockTr.setAttribute("data-storage-no", stock.stockNo);

        // 출고번호
        const tdNo = document.createElement("td");
        tdNo.innerText = stock.stockNo;
        stockTr.appendChild(tdNo);

        // 상태
        const tdStatus = document.createElement("td");
        tdStatus.innerHTML = statusBtn;
        stockTr.appendChild(tdStatus);

        // 작성일
        const tdDate = document.createElement("td");
        tdDate.innerText = stock.stockDate;
        stockTr.appendChild(tdDate);

        // 출고예정일
        const tdExp = document.createElement("td");
        tdExp.innerText = stock.expDate;
        stockTr.appendChild(tdExp);

        // 출고금액 계산
        const tdMoney = document.createElement("td");
        let totalAmount = 0;
        products.forEach(p => {
            if (p.stockNo === stock.stockNo) {
                totalAmount += (p.amount * p.price + p.taxPrice);
            }
        });
        tdMoney.innerText = totalAmount.toLocaleString(); // 천 단위 콤마
        stockTr.appendChild(tdMoney);

        // 요청자
        const tdEmp = document.createElement("td");
        tdEmp.innerText = stock.memName;
        stockTr.appendChild(tdEmp);

        // 삭제 버튼
        const tdCancel = document.createElement("td");
        tdCancel.innerHTML = removeBtn;
        stockTr.appendChild(tdCancel);

        tableBody.append(stockTr);
    });
}

// 품목 추가에서 추가 후 출고서에 금액 표시
function updateProductInfo() {
    const tableBody = document.querySelector("#stockOut-table tbody");
    const allProductInfo = document.getElementById("allProductInfo");

    let totalItems = 0;
    let totalQuantity = 0;
    let totalPrice = 0;
    let totalTax = 0;

    tableBody.querySelectorAll("tr").forEach(row => {
        const quantityInput = row.querySelector(".input-quantity");
        const unitPrice = parseFloat(row.querySelector("td:nth-child(4)").innerText.replace(/,/g, "")) || 0;
        const taxation = row.querySelector(".select-tax").value;

        let quantity = parseInt(quantityInput.value) || 0;
        totalQuantity += quantity;
        totalItems++;

        let itemTotalPrice = quantity * unitPrice;
        totalPrice += itemTotalPrice;

        if (taxation === "0") {
            totalTax += itemTotalPrice * 0.1;
        }
    });

    let totalAmount = totalPrice + totalTax;

    allProductInfo.innerText = `${totalItems}품목 총 수량 ${totalQuantity} 합계금액 ${totalPrice.toLocaleString()}원 + 부가세 ${totalTax.toLocaleString()}원 = 총 ${totalAmount.toLocaleString()}원`;
}

//수량, 과세, 삭제 클릭 시 allProductInfo 수정
document.addEventListener("input", function (event) {
    if (event.target.classList.contains("input-quantity")) {
        updateProductInfo();
    }
});

document.addEventListener("change", function (event) {
    if (event.target.classList.contains("select-tax")) {
        updateProductInfo();
    }
});

document.addEventListener("click", function (event) {
    if (event.target.classList.contains("btn-delete-row")) {
        event.target.closest("tr").remove();
        updateProductInfo();
    }
});

// 출고서 등록 모달
function showModal() {
    setExpectedDate();
    var modalElement = document.getElementById('modal1');

    if (!modalElement) {
        console.error("모달 요소를 찾을 수 없습니다!");
        return;
    }

    var modal = new bootstrap.Modal(modalElement);
    modal.show();
}

// 물품 추가 모달
function showModal2() {
    var modalElement = document.getElementById('modal2');

    if (!modalElement) {
        console.error("모달 요소를 찾을 수 없습니다!");
        return;
    }


    $.ajax({
        url: "/api/selectProductList",
        type: "GET",
        data: { clientId: 0 },
        dataType: "json",
        success: function (response) {
            var modal = new bootstrap.Modal(modalElement);
            modal.show();
            createProductTable(response); // 테이블 그리기
        },
        error: function () {
            console.error("제품 리스트 로딩 실패");
        }
    });
}

//물품 이름으로 물품 검색
function searchProduct() {
    const input = document.getElementById("product-search-input");
    const productName = input.value.trim();

    if (productName === "") {
        alert("품목명을 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/api/searchProductName",
        method: "GET",
        data: { productName: productName,
            clientId: 0
        },
        success: function (data) {
            createProductTable(data);
            input.value = "";
        },
        error: function () {
            alert("조회에 실패했습니다.");
        }
    });
}

//제품 정보들로 물품 추가 테이블 구성
function createProductTable(data) {
    let tableBody = $("#product-table tbody");
    tableBody.empty(); // 기존 tbody 비우기

    if (data.length === 0) {
        tableBody.append("<tr><td colspan='8'>제품이 없습니다.</td></tr>");
        return;
    }

    // 현재 출고서에 추가된 제품 번호 목록 수집
    const addedProductNos = new Set();

    document.querySelectorAll("#stockOut-table tbody tr").forEach(row => {
        addedProductNos.add(row.getAttribute("data-product-no"));
    });

    data.forEach(product => {
        let isChecked = addedProductNos.has(product.productNo.toString()) ? "checked" : "";
        let checkBox = `<input type="checkbox" class="modal-product-checkbox row-checkbox" data-product-no="${product.productNo}" ${isChecked}>`;

        // 이미지가 비어있으면 기본 이미지로 대체
        let imageUrl = product.imageUrl && product.imageUrl.trim() !== "" ? product.imageUrl : "/resources/default.png";
        let imgSrc = '<img src="' + imageUrl + '" style="width: 50px; height: 50px;" alt="제품사진">';

        // 제품 정보 텍스트
        let productInfo =
            "<div class=\"product-info\">" +
            "<p style=\"font-size: 14px;\">" + product.productNo + "</p>" +
            "<p style=\"font-weight:600; font-size: 14px;\">" + product.productName + "</p>" +
            "<p style=\"font-size: 12px;\">" + product.categoryName + " " + product.color + " " + product.productSize + "</p>" +
            "</div>";

        const productTr = document.createElement("tr");
        productTr.setAttribute("data-product-no", product.productNo);

        const tdCheck = document.createElement("td");
        tdCheck.innerHTML = checkBox;
        productTr.appendChild(tdCheck);

        const tdProduct = document.createElement("td");
        tdProduct.classList.add("list-table-item");
        tdProduct.innerHTML = imgSrc + productInfo;
        productTr.appendChild(tdProduct);

        const tdInPrice = document.createElement("td");
        tdInPrice.innerText = product.stockInPrice.toLocaleString();
        productTr.appendChild(tdInPrice);

        const tdOutPrice = document.createElement("td");
        tdOutPrice.innerText = product.stockOutPrice.toLocaleString();
        productTr.appendChild(tdOutPrice);

        tableBody.append(productTr);
    });

}

//제품추가 모달에서 제품 선택 후 출고서 모달로 전달
let selectedRows = []; // 선택된 행 데이터를 저장하는 배열

document.addEventListener("click", function (event) {
    const productTable = document.querySelector("#product-table");
    if (!productTable || !productTable.contains(event.target)) return;  // modal2 내부가 아니면 return

    const row = event.target.closest("tr");
    if (!row) return;

    const targetCheckbox = row.querySelector(".row-checkbox");

    // 체크박스가 아닌 곳 클릭 시 체크박스 토글
    if (event.target.type !== "checkbox" && targetCheckbox) {
        targetCheckbox.checked = !targetCheckbox.checked;
    }

    const productInfoDiv = row.querySelector(".product-info");

    // 각 정보 추출
    const productNo = productInfoDiv?.querySelector("p:nth-child(1)")?.innerText.trim();
    const productName = productInfoDiv?.querySelector("p:nth-child(2)")?.innerText.trim();
    const etcInfo = productInfoDiv?.querySelector("p:nth-child(3)")?.innerText.trim();
    const [categoryName, color, productSize] = etcInfo ? etcInfo.split(" ") : [];

    const stockInPrice = row.querySelector("td:nth-child(3)")?.innerText.trim();
    const stockOutPrice = row.querySelector("td:nth-child(4)")?.innerText.trim();
    const imageUrl = row.querySelector("img")?.getAttribute("src");

    const rowData = {
        productNo,
        productName,
        categoryName,
        color,
        productSize,
        stockInPrice,
        stockOutPrice,
        imageUrl
    };

    if (targetCheckbox?.checked) {
        if (!selectedRows.some(item => item.productNo === rowData.productNo)) {
            selectedRows.push(rowData);
        }
    } else {
        selectedRows = selectedRows.filter(item => item.productNo !== rowData.productNo);
    }
});


// 물품 추가 모달에서 선택 버튼 클릭 시 데이터 전달
document.getElementById("product-selection-btn").addEventListener("click", function () {
    if (selectedRows.length === 0) {
        console.warn("선택된 제품이 없습니다.");
        return;
    }
    createStockOutTable(selectedRows);

    // 이미 열려 있는 모달 인스턴스를 찾아서 닫기
    var modalElement = document.getElementById('modal2');
    var modalInstance = bootstrap.Modal.getInstance(modalElement);

    if (modalInstance) {
        modalInstance.hide(); // 기존 인스턴스가 있다면 닫기
    } else {
        console.error("모달 인스턴스를 찾을 수 없습니다.");
    }
});

//출고서 테이블 구성
function createStockOutTable(data) {
    let tableBody = $("#stockOut-table tbody");
    tableBody.empty(); // 기존 tbody 비우기

    if (data.length === 0) {
        tableBody.append("<tr><td colspan='8'>제품이 없습니다.</td></tr>");
        return;
    }

    data.forEach(product => {
        // 이미지가 비어있으면 기본 이미지로 대체
        let imageUrl = product.imageUrl && product.imageUrl.trim() !== "" ? product.imageUrl : "/resources/default.png";
        let imgSrc = '<img src="' + imageUrl + '" style="width: 50px; height: 50px;" alt="제품사진">';
        let inputAmount = `<input type="number" min="1" value="1" class="input-quantity" style="width:50px;">`;

        let selectTax = `<select class="select-tax">
                    <option value="0">과세</option>
                    <option value="1">비과세</option>
                 </select>`;

        let cancelBtn = `<button type="button" class="btn-delete-row btn btn-outline-danger btn-sm">삭제</button>`;

        // 제품 정보 텍스트
        let productInfo =
            "<div class=\"product-info\">" +
            "<p style=\"font-size: 14px;\">" + product.productNo + "</p>" +
            "<p style=\"font-weight:600; font-size: 14px;\">" + product.productName + "</p>" +
            "<p style=\"font-size: 12px;\">" + product.categoryName + " " + product.color + " " + product.productSize + "</p>" +
            "</div>";

        const productTr = document.createElement("tr");
        productTr.setAttribute("data-product-no", product.productNo);

        const tdProduct = document.createElement("td");
        tdProduct.classList.add("list-table-item");
        tdProduct.innerHTML = imgSrc + productInfo;
        productTr.appendChild(tdProduct);

        const tdNone = document.createElement("td");
        productTr.appendChild(tdNone);

        const tdInput = document.createElement("td");
        tdInput.innerHTML = inputAmount;
        productTr.appendChild(tdInput);

        const tdOutPrice = document.createElement("td");
        tdOutPrice.classList.add("td-unit-price");
        tdOutPrice.innerText = product.stockOutPrice;
        productTr.appendChild(tdOutPrice);

        const tdselect = document.createElement("td");
        tdselect.innerHTML = selectTax;
        productTr.appendChild(tdselect);

        const tdBtn = document.createElement("td");
        tdBtn.innerHTML = cancelBtn;
        productTr.appendChild(tdBtn);

        tableBody.append(productTr);

        updateProductInfo();
    });
}

//출고서에서 확인 버튼 클릭시 입출고 제품 테이블과 입출고 테이블에 등록
document.getElementById("stock-submit-btn").addEventListener("click", function () {
    const stockProducts = [];
    const stockEmp = document.getElementById("empNo").value;
    const expDate = document.getElementById("expected-date").value;
    const storageNo = document.getElementById("storage-search-bar").value;

    // 테이블 행 존재 여부 검사
    const tableRows = document.querySelectorAll("#stockOut-table tbody tr");
    if (tableRows.length === 0) {
        alert("상품을 선택해주세요.");
        return;
    }

    // 테이블 행들 가져오기
    document.querySelectorAll("#stockOut-table tbody tr").forEach(row => {
        const productNo = row.getAttribute("data-product-no");
        const amount = parseInt(row.querySelector(".input-quantity").value) || 0;
        const price = parseInt(row.querySelector("td:nth-child(4)").textContent.replace(/,/g, '')) || 0;
        const tax = row.querySelector(".select-tax").value; //0이면 Y 1이면 N
        const taxPrice = tax === "0" ? Math.floor(price * amount * 0.1) : 0;

        stockProducts.push({
            productNo,
            storageNo,
            amount,
            price,
            taxPrice,
            tax
        });
    });

    // stock 테이블 데이터
    const stockData = {
        stockEmp,
        expDate,
    };

    $.ajax({
        url: "/api/insertStockOut",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            stock: stockData,
            stockProductList: stockProducts
        }),
        success: function (response) {
            alert("출고서가 성공적으로 저장되었습니다.");
            // 이미 열려 있는 모달 인스턴스를 찾아서 닫기
            var modalElement = document.getElementById('modal1');
            var modalInstance = bootstrap.Modal.getInstance(modalElement);

            if (modalInstance) {
                modalInstance.hide(); // 기존 인스턴스가 있다면 닫기
                location.reload();
            } else {
                console.error("모달 인스턴스를 찾을 수 없습니다.");
            }
        },
        error: function (xhr, status, error) {
            console.error("저장 실패:", error);
            alert("출고서 저장 중 오류가 발생했습니다.");
        }
    });
    updateSummary();
});