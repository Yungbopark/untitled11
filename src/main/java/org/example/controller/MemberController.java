package org.example.controller;

import org.example.entity.Member;
import org.example.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class MemberController {


    @Autowired
    private MemberMapper memberMapper;

    @RequestMapping("/memJoin.do")
    public String memberJoin() {

        return "member/join";
    }

    @PostMapping("/memRegister.do")
    public String memberRegister(Member member, RedirectAttributes rttr,
                                 String memPassword1, String memPassword2,
                                 HttpSession session) {

        if (member.getMemID() == null || member.getMemID().equals("") ||
                memPassword1 == null || memPassword1.equals("") ||
                memPassword2 == null || memPassword2.equals("") ||
                member.getMemEmail() == null || member.getMemEmail().equals("") ||
                member.getMemName() == null || member.getMemName().equals("") ||
                member.getMemAge() == 0 ||
                member.getMemGender() == null || member.getMemGender().equals("") ||
                member.getMemEmail() == null || member.getMemEmail().equals("")) {

            // 누락 메시지를 가지고 가야 함 객체바인딩 (Model, httpServletRequest, HttpSession)
            rttr.addFlashAttribute("msgType", "누락 메시지");
            rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
            // FlashAttribute -> 객체를 한 번만 바인딩 한다
            return "redirect:/memJoin.do";

        }
        if (!memPassword1.equals(memPassword2)) {
            rttr.addFlashAttribute("msgType", "비밀번호 오류 메시지");
            rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
            return "redirect:/memJoin.do";
        }
        member.setMemProfile(""); // 사진 이미지
        // 회원을 테이블에 저장
        int result = memberMapper.memberRegister(member);
        // 성공 실패 여부에 따라 메시지를 다르게 보내기 위해서 결과 값을 받음
        System.out.println("result = " + result);


        if (result == 1) { //회원가입 성공 메시지
            rttr.addFlashAttribute("msgType", "성공 메시지");
            rttr.addFlashAttribute("msg", "회원 가입에 성공했습니다.");
            // 되돌아가기 전에 회원가입이 성공하면, 로그인 처리하기
            // session을 만들고 그 session 에 setAttribute 함
            session.setAttribute("mvo", member);
            return "redirect:/"; // root ("/") 첫페이지로 감
        } else {
            rttr.addFlashAttribute("msgType", "실패 메시지");
            rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
            return "redirect:/memJoin.do";
        }
    }

    @RequestMapping("/memRegisterCheck.do")
    public @ResponseBody int memRegisterCheck(@RequestParam("memId") String memId) {
        Member member = memberMapper.registerCheck(memId);
        if (member != null || memId.equals("")) {
            return 0; //이미 존재하는 회원 || 입력 불가 (공백)
        } else {
            return 1; // 사용가능한 id
        }
    }

    @RequestMapping("/memLogout.do")
    public String memLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/memLoginForm.do")
    public String memLoginForm() {

        return "member/memLoginForm";
    }

    @RequestMapping("/memLogin.do")
    public String memLogin(Member member, RedirectAttributes rttr, HttpSession session) {
        if (member.getMemID() == null || member.getMemID().equals("") ||
                member.getMemPassword() == null || member.getMemPassword().equals("")
        ) {
            rttr.addFlashAttribute("msgType", "실패 메시지");
            rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요.");
            return "redirect:/memLoginForm.do";
        }

        Member mvo = memberMapper.memberLogin(member);
        if (mvo != null) { //   로그인 성공
            rttr.addFlashAttribute("msgType", "성공 메시지");
            rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
            session.setAttribute("mvo", mvo);
            return "redirect:/";
        } else { // 로그인 실패
            rttr.addFlashAttribute("msgType", "실패 메시지");
            rttr.addFlashAttribute("msg", "로그인에 실패했습니다.");

            return "redirect:/memLoginForm.do";
        }
    }

    // 회원정보수정화면
    @RequestMapping("/memUpdateFrom.do")
    public String memUpdateFrom() {


        return "member/memUpdateForm";
    }

    @RequestMapping("/memUpdate.do") //회원정보수정
    public String memUpdate(Member member, RedirectAttributes rttr, String memPassword1, String memPassword2, HttpSession session) {
            /*이쪽 검증 하는 부분 다시 봐야 됨
            * 비밀번호를 안 누르고 수정 눌러도 페이지 넘어감
            * 원래는 msgType :  누락 메시지 나와야 하는데....*/
        if (member.getMemID() == null || member.getMemID().equals("") ||
                memPassword1 == null || memPassword1.equals("") ||
                memPassword2 == null || memPassword2.equals("") ||
                member.getMemEmail() == null || member.getMemEmail().equals("") ||
                member.getMemName() == null || member.getMemName().equals("") ||
                member.getMemAge() == 0 ||
                member.getMemGender() == null || member.getMemGender().equals("")) {

            // 누락 메시지를 가지고 가야 함 객체바인딩 (Model, httpServletRequest, HttpSession)
            rttr.addFlashAttribute("msgType", "누락 메시지");
            rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
            // FlashAttribute -> 객체를 한 번만 바인딩 한다
            return "redirect:/memUpdateForm.do";

        }
        if (!memPassword1.equals(memPassword2)) {
            rttr.addFlashAttribute("msgType", "비밀번호 오류 메시지");
            rttr.addFlashAttribute("msg", "비밀번호가 서로 다릅니다.");
            return "redirect:/memUpdateForm.do";
        }
        int result = memberMapper.memUpdate(member);
        // 성공 실패 여부에 따라 메시지를 다르게 보내기 위해서 결과 값을 받음

        if (result == 1) { //수정 성공 메시지
            rttr.addFlashAttribute("msgType", "성공 메시지");
            rttr.addFlashAttribute("msg", "회원 정보 수정에 성공했습니다.");
            // 되돌아가기 전에 회원가입이 성공하면, 로그인 처리하기
            // session을 만들고 그 session 에 setAttribute 함
            session.setAttribute("mvo", member);
            return "redirect:/"; // root ("/") 첫페이지로 감
        } else {
            rttr.addFlashAttribute("msgType", "실패 메시지");
            rttr.addFlashAttribute("msg", "회원 정보 수정에 실패 했습니다.");
            return "redirect:/memUpdateForm.do";
        }
    }
    }

