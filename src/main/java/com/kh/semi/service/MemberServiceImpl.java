package com.kh.semi.service;

import com.kh.semi.domain.vo.Member;
import com.kh.semi.mappers.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Override
    public Member loginMember(String memId, String memPwd) {
        return memberMapper.loginMember(memId, memPwd);
    }

    @Override
    public ArrayList<Member> selectMemberList() {
        return memberMapper.selectMemberList();
    }

    @Override
    public ArrayList<Member> acceptMemberList() {
        return memberMapper.acceptMemberList();
    }

    @Override
    public int approveMember(String memId, String storeSelect) {
        return memberMapper.approveMember(memId,storeSelect);
    }


}
