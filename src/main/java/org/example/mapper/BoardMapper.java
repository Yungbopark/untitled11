package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;
import org.example.entity.Board;

import java.util.List;

@Mapper
public interface BoardMapper {
    public List<Board> getLists();
    // 인터페이스 안에 추상 메서드로 정의 되어 있음
    public void boardInsert(Board vo);
    public Board boardContent(int idx);
    public void boardDelete(int idx);
    public void boardUpdate(Board board);
    @Update("update tb_board set count=count+1 where idx=#{idx}")
    // Mybatis 제공 annotation
    // Mapper interface와 mapper.xml파일을 이용하는 방식과 동시 사용 할 수 있음
    public void boardCount(int idx);
}
