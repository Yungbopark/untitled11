package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.example.entity.Board;

import java.util.List;

@Mapper
public interface BoardMapper {
    public List<Board> getLists();
    // 인터페이스 안에 추상 메서드로 정의 되어 있음

    public void boardInsert(Board vo);
}
