package org.example.controller;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.example.entity.Member;
import org.example.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;

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
                member.getMemAge() == 0 || member.getAuthList().size() == 0 ||
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
        // 추가 : 비밀번호 암호화하기 (
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
    public @ResponseBody
    int memRegisterCheck(@RequestParam("memId") String memId) {
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
    @RequestMapping("/memUpdateForm.do")
    public String memUpdateForm() {


        return "member/memUpdateForm";
    }

    @RequestMapping("/memUpdate.do") //회원정보수정
    public String memUpdate(Member member, RedirectAttributes rttr, String memPassword1, String memPassword2, HttpSession session) {

        System.out.println("member = " + member);
        System.out.println("memPassword1 = " + memPassword1);
        System.out.println("memPassword2 = " + memPassword2);
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

    @RequestMapping("/memImageForm.do")
    public String memImageForm() {

        return "member/memImageForm";
    }

    // 회원사진 이미지 업로드 (upload, DB저장)
    @RequestMapping("/memImageUpdate.do")
    public String memImageUpdate(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
        // 파일업로드 API (cos.jar, 3가지)
        MultipartRequest multi = null;
        int fileMaxSize = 10 * 1024 * 1024; // 10MB
        //업로드 할 경로 지정 // 실제 업로드 할 path 를 가져온다
        String path = "C:\\DEV\\untitled11\\web\\static\\upload";
        //request.getRealPath("resources/upload");
        try {
            // 이미지 업로드
            multi = new MultipartRequest(request, path, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msgType", "실패 메시지");
            rttr.addFlashAttribute("msg", "파일 용량 초과");
            return "redirect:/memImageForm.do";
        }

        //데이터 베이스 테이블에 회원 이미지를 업데이트
        String memID = multi.getParameter("memID");
        String newFileName = null;
        File file = multi.getFile("memProfile");
        if (file != null) { // 업로드가 된 상태
             //이미지 파일인지 여부 체크
            String name = file.getName().substring(file.getName().lastIndexOf(".") + 1);
            System.out.println("name = " + name);
            name =  name.toUpperCase();

            if (name.equals("PNG") || name.equals("GIF") || name.equals("JPG")) {
                // 새로 업로드된 이미지(new), 현재 DB에 있는 이미지(old)
                String oldFileName = memberMapper.getMember(memID).getMemProfile();
                System.out.println("oldFileName = " + oldFileName);
                File oldFile = new File(path + "/" + oldFileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
               newFileName = file.getName();
            } else {
                if (file.exists()) {
                    file.delete();
                }
                rttr.addFlashAttribute("msgType", "실패 메시지");
                rttr.addFlashAttribute("msg", "이미지파일만 업로드 가능");
                return "redirect:/memImageForm.do";
            }
        }
        //새로운 이미지를 테이블에 업데이트

        Member member = new Member();
        member.setMemID(memID);
        member.setMemProfile(newFileName);

        memberMapper.memProfileUpdate(member); //이미지 업데이트
        Member member1 = memberMapper.getMember(memID);
        //세션을 새롭게 생셩한다.
        session.setAttribute("mvo", member1);
        rttr.addFlashAttribute("msgType", "성공 메시지");
        rttr.addFlashAttribute("msg", "이미지 변경 완료");
        return "redirect:/";
    }
}

