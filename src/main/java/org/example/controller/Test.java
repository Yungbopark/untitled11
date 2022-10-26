package org.example.controller;


import org.example.entity.Board;
import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
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
        return "boardList";


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
        return "boardForm";
    }

    @PostMapping("/boardInsert.do")
    public String boardInsert(Board vo) { // 파라메터를 수집(board), 바로 VO를 파라메터로 걸면 됨
        return "redirect:boardList.do";
    }

}
