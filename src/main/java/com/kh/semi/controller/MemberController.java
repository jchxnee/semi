package com.kh.semi.controller;

import com.kh.semi.domain.vo.Member;
import com.kh.semi.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.autoconfigure.observation.ObservationProperties;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;



@Controller
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;

    }

    @GetMapping("enrollForm.me")
    public String enrollMemberForm() {

        return "member/memberEnrollForm";
    }

    @GetMapping("logout.me")
    public String logout() {

        return "index";
    }

    @PostMapping("login.me")
    public ModelAndView login(@ModelAttribute Member member, ModelAndView mv) {
        // Member 객체에서 memId, memPwd 추출
        String memId = member.getMemId();
        String memPwd = member.getMemPwd();

        // MemberService의 loginMember 호출
        Member loginMember = memberService.loginMember(memId, memPwd);
        System.out.println(loginMember);
        // 로그인 성공 여부 확인
        if (loginMember == null) {
            mv.addObject("errorMsg", "아이디나 비밀번호가 일치하지 않습니다.");
            mv.setViewName("common/errorPage");

        } else {
            mv.addObject("loginUser", loginMember);  // 로그인된 회원 정보 저장
            mv.setViewName("employee/companyManagement");  // 로그인 성공 시 지점생성 페이지 이동
        }
        return mv;
    }

    @PostMapping("insert.me")
    public String insertMember(@ModelAttribute Member member, ModelAndView mv, HttpSession session) {
        // Member 객체에서 memId, memPwd, memName, phone 추출
        Member m = new Member();
        m.setMemId(member.getMemId());
        m.setMemPwd(member.getMemPwd());
        m.setMemName(member.getMemName());
        m.setPhone(member.getPhone());

        // MemberService의 insertMember 호출
        int result = memberService.insertMember(m);
        // 회원가입 성공 여부 확인
        if (result > 0) {
            session.setAttribute("alertMsg", "성공적으로 회원가입을 완료하였습니다.");
            return "redirect:/";
        } else {
            mv.addObject("errorMsg", "회원가입에 실패하였습니다.");
            return "common/errorPage";
        }
    }
}


