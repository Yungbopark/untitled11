package org.example.controller;

import org.example.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {

    @Autowired
    private BoardMapper boardMapper;

    @RequestMapping("/boardMain.do")
    public String boardMain() {

        return "board/main";
    }

}
