package org.example.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.example.entity.Member;

@Mapper
public interface MemberMapper {

    public Member registerCheck(String memId) ;

    public int memberRegister(Member member);

    public Member memberLogin(Member member); //로그인체크

    public int memUpdate(Member member);

    public Member getMember(String memberID);

    public void memProfileUpdate(Member member);
}
