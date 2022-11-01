package org.example.controller;

import org.example.entity.Board;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardMapper boardMapper;

    @RequestMapping("/")
    public String main() {

        return "main";
    }

    @RequestMapping("/boardList.do")
    public @ResponseBody
    List<Board> boardList() {
        /*return을 String으로 안하고 객체로 한다*/
        System.out.println("BoardController.boardList");
        List<Board> lists = boardMapper.getLists();

        return lists; // JSON 데이터 형식으로 변환해서 return

    }

    @PostMapping("/boardInsert.do")
    public @ResponseBody
    void boardInsert(Board vo) {
        boardMapper.boardInsert(vo);
        /*insert가 끝나면 @ResponseBody annotation으로 제어권을 넘겨줘야 함*/

    }

    @RequestMapping("/boardDelete.do")
    public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {

        boardMapper.boardDelete(idx);
    }

    @RequestMapping("/boardUpdate.do")
    public @ResponseBody void boardUpdate(Board vo) {
        boardMapper.boardUpdate(vo);
    }

    @RequestMapping("/boardContent.do")
    public @ResponseBody Board boardContent(int idx) {
        Board board = boardMapper.boardContent(idx);

        return board;
    }

    @RequestMapping("/boardCount.do")
    public @ResponseBody Board boardCount(int idx) {
        Board board =  boardMapper.boardCount(idx);
        /*리턴 값을 못 받아 오는 듯*/
        /*annotation 으로 쿼리를 적으면, 리턴 값을 어떻게 설정 하는지 찾아보자*/
        return board;
    }
}
