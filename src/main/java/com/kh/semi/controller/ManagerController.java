package com.kh.semi.controller;

import com.kh.semi.domain.vo.*;

import com.kh.semi.domain.vo.Attendance;
import com.kh.semi.domain.vo.Member;
import com.kh.semi.domain.vo.Stock;
import com.kh.semi.domain.vo.Storage;

import com.kh.semi.service.AttendanceService;
import com.kh.semi.service.StockService;
import com.kh.semi.service.StorageService;
import com.kh.semi.domain.vo.*;
import com.kh.semi.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;


@RequiredArgsConstructor
@Controller
public class ManagerController {
    private final StorageService storageService;
    private final StockService stockService;
    private final AttendanceService attendanceService;
    private final ProductService productService;
    private final BoardService boardService;
    private final InventoryService inventoryService;
    private final StoresalesService storesalesService;


    @GetMapping("manager.bo")
    public String managerBoardList() {
        return "admin/boardListView";
    }


    @GetMapping("managerenroll.bo")
    public String managerEnrollForm() {
        return "manager/boardEnrollForm-manager";
    }

    @GetMapping("dash-manager.bo")
    public String dashManager(Model model, HttpSession session) {
        //부족한 재고 카드
        int storeId = (int)session.getAttribute("storeId");
        int empNo = (int) session.getAttribute("empNo");
        List<Inventory> lowInventoryTop4 = inventoryService.selectLowInventoryTop4(storeId);
        model.addAttribute("lowInventoryTop4", lowInventoryTop4);


        ArrayList<Board> noticeList = boardService.selectBoardListTop3();
        // 공지사항 리스트를 모델에 추가
        model.addAttribute("noticeList", noticeList);


        //직원 현황 카드
        int countWork = attendanceService.countWork(storeId);
        int countNoWork = attendanceService.countEmp(storeId) - countWork; //(출근안한직원수 = 전체 직원수 - 출근한 직원수)
        model.addAttribute("countWork", countWork);
        model.addAttribute("countNoWork", countNoWork);

        //인기 제품 카드
        List<Product> top4product = productService.top4product(storeId);
        model.addAttribute("top4product", top4product);

        //입출고 현황
        int countStockIn = stockService.countStockIn(empNo);
        int countStockOut = stockService.countStockOut(empNo);
        model.addAttribute("countStockIn", countStockIn);
        model.addAttribute("countStockOut", countStockOut);

        //  오늘 매출 조회 추가
        int todaySales = storesalesService.getTodayTotalSales(storeId) / 10000;
        model.addAttribute("todaySales", todaySales);

        return "manager/dashBoard-manager";
    }

    @GetMapping("attendance.ma")
    public String attendanceManagement(@RequestParam(defaultValue = "1") int cpage,
                                       Model model,
                                       HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int storeId = loginMember.getStoreId();

        // 직원명 목록 select용
        ArrayList<Attendance> allList = attendanceService.getMyAttendanceList(storeId);
        Set<String> empNameList = allList.stream()
                .map(Attendance::getEmpName)
                .collect(Collectors.toSet());
        model.addAttribute("empNameList", empNameList);

        // ✅ paramMap 생성
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("storeId", storeId);

        // ✅ 페이징 처리
        int listCount = attendanceService.getAttendanceCount(paramMap);
        int pageLimit = 5;
        int boardLimit = 10;
        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);
        paramMap.put("pi", pi); // ✅ 꼭 넣기

        // ✅ 수정된 서비스 호출
        ArrayList<Attendance> listpage = attendanceService.selectAttendanceListPage(paramMap);
        model.addAttribute("listpage", listpage);
        model.addAttribute("pi", pi);

        return "manager/managerAttendanceView";
    }

    @GetMapping("salesManager.bo")
    public String saleManagerBoard() {
        return "manager/managerSalesView";
    }

    @GetMapping("storage.lo")
    public String storageManagement(@RequestParam(defaultValue = "1") int cpage, Model model, HttpSession session) {
        int storeId = (int) session.getAttribute("storeId");

        // 페이징바 처리 코드
        int listCount = storageService.StorageCount(storeId);
        int pageLimit = 5;     // 하단에 보여질 페이징 바 수
        int boardLimit = 10;   // 한 페이지에 보여질 입고처 수
        model.addAttribute("pageUrl", "storage.lo");
        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);

        ArrayList<Storage> listpage = storageService.selectStorageList(pi, storeId);
        model.addAttribute("storage", listpage); // jsp el 태그에서 db 값 불러올 때 client 변수로 불러옴 << 확인 부탁
        model.addAttribute("pi", pi);

        return "manager/storageManagementView";
    }

    @PostMapping("insert.sto")
    public String insertStorage(Storage storage, HttpSession session, ModelAndView mv) {
        int storeId = (int) session.getAttribute("storeId");
        Storage s = new Storage();
        s.setStoreId(storeId);
        s.setStorageLocation(storage.getStorageLocation());
        s.setAbleAmount(storage.getAbleAmount());
        int result = storageService.insertStorage(s);
        if (result > 0) {
            return "redirect:/storage.lo";
        } else {
            mv.addObject("errorMsg", "창고 등록에 실패하였습니다.");
            return "common/errorPage";
        }
    }

    @GetMapping("stockManage.bo")
    public String stockManagement() {
        return "manager/stockManageView";
    }

    @GetMapping("stockIn.sto")
    public String stockInManagement(@RequestParam(defaultValue = "1") int cpage,
                                    @RequestParam(required = false, defaultValue = "전체") String status,
                                    @RequestParam(required = false) String startDate,
                                    @RequestParam(required = false) String endDate,
                                    Model model,
                                    HttpSession session) {
        int empNo = (int) session.getAttribute("empNo");
        int storeId = (int)session.getAttribute("storeId");

        ArrayList<Storage> list2 = storageService.selectStorage(storeId);
        ArrayList<Client> list3 = productService.selectClientList();
        ArrayList<StockProduct> list4 = stockService.selectStockProductList(empNo);
        ArrayList<Product> list5 = productService.selectImageUrl();

        model.addAttribute("storage", list2);
        model.addAttribute("client", list3);
        model.addAttribute("stockProduct", list4);
        model.addAttribute("image", list5);

        // 페이징 처리
        int listCount = stockService.selectStockInListforPaging(empNo, status, startDate, endDate);
        int pageLimit = 5;
        int boardLimit = 8;
        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);
        ArrayList<Stock> listpage = stockService.selectStockInListByPage(pi, empNo, status, startDate, endDate);

        model.addAttribute("stock", listpage);
        model.addAttribute("pi", pi);
        model.addAttribute("pageUrl", "stockIn.sto");
        model.addAttribute("selectedStatus", status);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "manager/stockInView";
    }

    @GetMapping("stockOut.sto")
    public String stockOutManagement(@RequestParam(defaultValue = "1") int cpage,
                                     @RequestParam(required = false, defaultValue = "전체") String status,
                                     @RequestParam(required = false) String startDate,
                                     @RequestParam(required = false) String endDate,
                                     Model model,
                                     HttpSession session) {
        int empNo = (int) session.getAttribute("empNo");
        int storeId = (int) session.getAttribute("storeId");

        ArrayList<Storage> list2 = storageService.selectStorage(storeId);
        ArrayList<Client> list3 = productService.selectClientList();
        ArrayList<StockProduct> list4 = stockService.selectStockProductList(empNo);
        ArrayList<Product> list5 = productService.selectImageUrl();
        model.addAttribute("storage", list2);
        model.addAttribute("client", list3);
        model.addAttribute("stockProduct", list4);
        model.addAttribute("image", list5);

        // 페이징 처리
        int listCount = stockService.selectStockOutListforPaging(empNo, status, startDate, endDate);
        int pageLimit = 5;
        int boardLimit = 8;
        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);
        ArrayList<Stock> listpage = stockService.selectStockOutListByPage(pi, empNo, status, startDate, endDate);

        model.addAttribute("stock", listpage);
        model.addAttribute("pi", pi);
        model.addAttribute("pageUrl", "stockOut.sto");
        model.addAttribute("selectedStatus", status);

        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "manager/stockOutView";
    }


    @PostMapping("updateAttendance.ma")
    public String updateAttendance(Attendance attendance, HttpSession session) {

        int result = attendanceService.updateAttendance(attendance);
        if(result > 0){
            session.setAttribute("alertMsg", "근태 관리 수정 성공");
        } else {
            session.setAttribute("alertMsg", "근태 관리 수정 실패");
        }
        return "redirect:/attendance.ma";
    }

    @GetMapping("selectAttendance.ma")
    public String selectAttendance(@RequestParam(defaultValue = "1") int cpage,
                                   @RequestParam(required = false) String empName,
                                   @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                   @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                   HttpSession session, Model model) {

        int storeId = ((Member) session.getAttribute("loginUser")).getStoreId();

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("storeId", storeId);
        paramMap.put("empName", empName);
        paramMap.put("startDate", startDate);
        paramMap.put("endDate", endDate);


        // ✅ 페이징 처리
        int listCount = attendanceService.getAttendanceCount(paramMap);
        int pageLimit = 5;
        int boardLimit = 10;
        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);
        paramMap.put("pi", pi); // ✅ PageInfo를 paramMap에 넣어야 ServiceImpl에서 꺼낼 수 있음


        ArrayList<Attendance> listpage = attendanceService.selectAttendanceListPage(paramMap); // 페이징된 목록 조회
        model.addAttribute("listpage", listpage);
        model.addAttribute("pi", pi);

        // 직원 선택용 드롭다운용 전체 목록
        ArrayList<Attendance> allList = attendanceService.getMyAttendanceList(storeId);
        Set<String> empNameList = allList.stream()
                .map(Attendance::getEmpName)
                .collect(Collectors.toSet());
        model.addAttribute("empNameList", empNameList);

        model.addAttribute("selectedEmpName", empName);
        model.addAttribute("selectedStartDate", startDate);
        model.addAttribute("selectedEndDate", endDate);

        return "manager/managerAttendanceView";
    }


}
