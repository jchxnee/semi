package com.kh.semi.controller;

import com.kh.semi.domain.vo.Board;
import com.kh.semi.domain.vo.Client;
import com.kh.semi.domain.vo.Member;
import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Product;
import com.kh.semi.service.BoardService;
import com.kh.semi.service.MemberService;
import com.kh.semi.service.ProductService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.ArrayList;
import java.util.List;


@RequiredArgsConstructor
@Controller
public class AdminController {
    private final MemberService memberService;
    private final ProductService productService;
    private final BoardService boardService;

    @GetMapping("accept.ma")
    public String acceptManager(Model model) {
        ArrayList<Member> list = memberService.acceptManagerList();
        model.addAttribute("acceptManager", list);
        System.out.println("지점장 승인 : " + list);
        return "admin/managerManagement";
    }

    @GetMapping("accept.me")
    public String acceptMember(Model model) {
        ArrayList<Member> list = memberService.acceptMemberList();
        model.addAttribute("acceptMember", list);
        System.out.println("직원 승인 : " + list);
        return "admin/memberManagement";
    }


    @GetMapping("list.bo")
    public String selectBoardList(@RequestParam(defaultValue = "1") int cpage, Model model) {

        // 페이징바 처리 코드
        int listCount = boardService.countAllBoard(); // 전체 게시글 수
        int pageLimit = 5;     // 하단에 보여질 페이징 바 수
        int boardLimit = 10;   // 한 페이지에 보여질 게시글 수

        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);

        ArrayList<Board> listpage = boardService.selectBoardListByPage(pi);
        model.addAttribute("listpage", listpage);  // 변경: listpage로 모델에 추가
        model.addAttribute("pi", pi);
        model.addAttribute("pageUrl", "list.bo");
        System.out.println("공지사항 리스트 : " + listpage);
        System.out.println("PageInfo: " + pi);

        return "admin/boardListView";
    }


    @PostMapping("insertlist.bo")
    public String boardList(Board board, HttpSession session, Model model) {
        board.setEmpNo(1);
        System.out.println("게시글 정보 : " + board);

        int result = boardService.insertBoard(board);
        if(result > 0){
            session.setAttribute("alertMsg", "게시글 작성 성공");
            return "redirect:/list.bo";
        } else {
            model.addAttribute("errorMsg", "게시글 작성 실패");
            return "common/errorPage";
        }

    }

    @PostMapping("delete.bo")
    public String deleteBoard(int boardNo, Model model, HttpSession session) {
        int result = boardService.deleteBoard(boardNo);

        if (result > 0) {
            session.setAttribute("alertMsg", "게시글을 삭제하였습니다.");
            return "redirect:/list.bo";
        } else {
            model.addAttribute("errorMsg", "게시글 삭제 실패");
            return "redirect:/list.bo";
        }
    }

    @GetMapping("enroll.bo")
    public String enrollForm() {
        return "admin/boardEnrollForm-admin";
    }

    @GetMapping("update.bo")
    public String updateForm() {
        return "admin/boardUpdate-admin";
    }

    @PostMapping("noticeupdate.bo")
    public String noticeUpdate(@RequestParam("boardNo") int boardNo, Board board,  HttpSession session) {
        int result = boardService.noticeUpdate(board);

        if(result > 0){
            session.setAttribute("alertMsg", "게시글 수정 성공");
        } else {
            session.setAttribute("alertMsg", "게시글 수정 실패 관리자에게 문의");
        }
        return "redirect:/list.bo";
    }

    @GetMapping("dash.bo")
    public String dashBoard(Model model) {

        ArrayList<Board> noticeList = boardService.selectBoardListTop3();

        // 공지사항 리스트를 모델에 추가
        model.addAttribute("noticeList", noticeList);

        return "admin/dashBoard-admin";
    }

    @GetMapping("sales.bo")
    public String saleBoard() {
        return "admin/salesBoard";
    }

    @GetMapping("product.bo")
    public String productManagement() {return "admin/productManagement";}

    @GetMapping("delivery.ma")
    public String deliveryManagement(Model model) {
        ArrayList<Client> list = productService.selectClientList();
        model.addAttribute("client", list);
        return "admin/deliveryManagement";
    }

    @PostMapping("insert.cl")
    public String insertClient(Client client, RedirectAttributes redirectAttributes, ModelAndView mv) {
        Client c = new Client();
        c.setClientName(client.getClientName());
        c.setClientCeo(client.getClientCeo());
        c.setClientPhone(client.getClientPhone());
        c.setClientAddress(client.getClientAddress());

        int result = productService.insertClient(c);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 거래처를 등록하였습니다.");
            return "redirect:/delivery.ma";
        } else {
            mv.addObject("errorMsg", "거래처 등록에 실패하였습니다.");
            return "common/errorPage";
        }
    }

    @GetMapping("employee.in")
    public String employeeInfoView(@RequestParam(defaultValue = "1") int cpage, Model model) {

        // DB에서 중복 없는 지점 목록 가져오기
        ArrayList<String> storeList = memberService.getStoreList();
        model.addAttribute("storeList", storeList);

        // 페이징바 처리 코드
        int listCount = memberService.countAllMembers(); // 전체 직원 수
        int pageLimit = 5;     // 하단에 보여질 페이징 바 수
        int boardLimit = 10;   // 한 페이지에 보여질 직원 수
        model.addAttribute("pageUrl", "employee.in");

        PageInfo pi = new PageInfo(listCount, cpage, pageLimit, boardLimit);

        ArrayList<Member> listpage = memberService.selectMemberListByPage(pi);
        model.addAttribute("member", listpage);
        model.addAttribute("pi", pi);

        return "admin/employeeInfoView";
    }

    @GetMapping("employeeList")
    @ResponseBody // JSON 형태로 반환
    public List<Member> getFilteredEmployees(@RequestParam(value = "store", required = false) String store) {
        System.out.println("선택된 지점: " + store); // 디버깅용 출력

        List<Member> filteredList;
        if (store == null || store.equals("전체")) {
            filteredList = memberService.selectMemberList(); // 전체 직원 조회
        } else {
            filteredList = memberService.getEmployeesByStore(store); // 특정 지점 직원 조회
        }

        System.out.println("조회된 직원 목록: " + filteredList); // 디버깅용 출력
        return filteredList;
    }


    @GetMapping("adminmypage.bo")
    public String adminPage() {return "admin/adminMypage";}




    @PostMapping("/approveMember")
    public String approveMember(@RequestParam String memId, @RequestParam String storeSelect, HttpSession session, Model model) {
        System.out.println(storeSelect);
        int result = memberService.approveMember(memId,storeSelect);
        if(result > 0){
            session.setAttribute("alertMsg","직원 승인 완료");
            return "admin/memberManagement";
        } else{
            model.addAttribute("errorMsg", "직원 승인 실패");
            return "common/errorPage";
        }
    }

    @PostMapping("/rejectMember")
    public String rejectMember(@RequestParam String memId,HttpSession session, Model model) {
        System.out.println(memId);
        int result = memberService.rejectMember(memId);
        if(result > 0){
            session.setAttribute("alertMsg","직원 승인거부 완료");
            return "admin/memberManagement";
        } else{
            model.addAttribute("errorMsg", "직원 승인거부 실패");
            return "common/errorPage";
        }
    }

    @PostMapping("/approveManager")
    public String approveManager(@RequestParam String storeId, @RequestParam String memId ,HttpSession session, Model model) {
        int result = memberService.approveManager(storeId, memId);
        if(result > 1){
            session.setAttribute("alertMsg","지점장 승인 완료");
            return "admin/managerManagement";
        } else{
            model.addAttribute("errorMsg", "지점장 승인 실패");
            return "common/errorPage";
        }

    }

    @PostMapping("/rejectManager")
    public String rejectManager(@RequestParam String storeId,HttpSession session, Model model) {
        System.out.println(storeId);
        int result = memberService.rejectManager(storeId);
        if(result > 0){
            session.setAttribute("alertMsg","지점장 승인거부 완료");
            return "admin/memberManagement";
        } else{
            model.addAttribute("errorMsg", "지점장 승인거부 실패");
            return "common/errorPage";
        }
    }


}
