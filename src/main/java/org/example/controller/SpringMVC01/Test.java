package org.example.controller.SpringMVC01;


import org.example.entity.Board;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*@Controller*/
public class Test {


    @Autowired
    private BoardMapper boardMapper;

    @RequestMapping("/")
    public String home() {
        System.out.println("Test.home");

        return "index";
    }


    @RequestMapping("/boardList.do")
    public String boardList(Model model) {

        List<Board> list = boardMapper.getLists();
        model.addAttribute("list", list);
        return "SrpingMVC01/boardList";


        /*mybatis mapper  인식 불가 해결
         * mapper xml 파일을 interface class의 package경로랑 똑같이,
         * resource 폴더의 하위 폴더 구조로 동일하게 구성해 줌
         * 그리고 나서 applicationContext.xml에서 dataSource를 인식 못하는 문제 발생
         *
         * 설정에서
         *
         * <bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource" destroy-method="close">

         * dataSource를 bean에 넣어주는 과정에서 초기화 필요
         *
         * <constructor-arg ref="hikariConfig"/>
         *  */
    }

    @RequestMapping("/boardForm.do")
    public String boardForm() {
        return "SrpingMVC01/boardForm";
    }

    @PostMapping("/boardInsert.do")
    public String boardInsert(Board vo) { // 파라메터를 수집(board), 바로 VO를 파라메터로 걸면 됨
        boardMapper.boardInsert(vo);
        return "redirect:boardList.do";

    }

    @RequestMapping("/boardContent.do")
    public String boardContent(/*@RequestParam("idx")*/
                                /*annotation 생략도 가능 */int idx, Model model) {
        Board board = boardMapper.boardContent(idx);
        model.addAttribute("board", board);
        //조회수 증가
        boardMapper.boardCount(idx);
        return "SrpingMVC01/boardContent";
    }

    @RequestMapping("/boardDelete.do/{idx}")
    /*뒤에 / 하고 받아올 변수 지정
     * @PathVariable
     * 장점은 client (jsp) 에서 변수를 지정 할 필요가 없음
     * */
    public String boardDelete(@PathVariable("idx") int idx) {
        System.out.println("idx = " + idx);
        boardMapper.boardDelete(idx);


        return "redirect:/boardList.do";
    }


    @GetMapping("/boardUpdateForm.do/{idx}")
    public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {

        Board board = boardMapper.boardContent(idx);

        model.addAttribute("board", board);

        return "SrpingMVC01/boardUpdate";
    }

    @PostMapping("/boardUpdate.do")
    public String boardUpdate(Board board) { // idx, title, contents 넘어오는데 세개를 VO로 가져오면 됨
        System.out.println("Test.boardUpdate");
        boardMapper.boardUpdate(board); // 수정 성공

        return "redirect:/boardList.do";
    }

}
