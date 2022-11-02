package org.example.controller;

import org.example.entity.Board;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/board")
@RestController
// RestController annotaion을 붙이면 @ResponseBody를 생략할 수 있음
// RestController는 기본적으로 ajax 통신 할 때 쓰는 controller
public class BoardRestController {

    @Autowired
    private BoardMapper boardMapper;


    @GetMapping("/all")
    public //@ResponseBody
    List<Board> boardList() {
        /*return을 String으로 안하고 객체로 한다*/
        System.out.println("BoardController.boardList");
        List<Board> lists = boardMapper.getLists();
        return lists; // JSON 데이터 형식으로 변환해서 return
    }
    //@PostMapping("/boardInsert.do")
    @PostMapping("/new")
    public //@ResponseBody
    void boardInsert(Board vo) {
        boardMapper.boardInsert(vo);
        /*insert가 끝나면 @ResponseBody annotation으로 제어권을 넘겨줘야 함*/
    }

    @DeleteMapping("/{idx}}")
    public //@ResponseBody
    void boardDelete(@PathVariable("idx") int idx) {
        boardMapper.boardDelete(idx);
    }

    @PutMapping("/update")
    // update 할 때는 putMapping 사용한다
    public //@ResponseBody
    void boardUpdate(@RequestBody Board vo) {
        boardMapper.boardUpdate(vo);
    }

    @GetMapping("/{idx}")
    public //@ResponseBody
    Board boardContent(@PathVariable("idx") int idx) {
        Board board = boardMapper.boardContent(idx);

        return board;
    }

    @PutMapping("/count/{idx}")
    public //@ResponseBody
    Board boardCount(@PathVariable("idx") int idx) {
        boardMapper.boardCount(idx);
        Board board =  boardMapper.boardContent(idx);
        /*리턴 값을 못 받아 오는 듯*/
        /*annotation 으로 쿼리를 적으면, 리턴 값을 어떻게 설정 하는지 찾아보자*/
        return board;
    }
}
