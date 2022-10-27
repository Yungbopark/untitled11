<!DOCTYPE html>
<html lang="en">
<head>
    <title>boardList</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <% pageContext.setAttribute("newLineChar", "\n"); %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

</head>
<body>

<div class="container">
    <h2>Spring MVC01</h2>
    <div class="panel panel-default">
        <div class="panel-heading">BOARD</div>
        <div class="panel-body">
            <form action="" method="post">
            <table class="table">
                <tr>
                    <td>제목</td>
                    <td>${board.title}</td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>${fn:replace(board.contents,newLineChar ,"<br/>" )}</td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td>${board.writer}</td>
                </tr>
                <tr>
                    <td>작성일</td>
                    <td>${fn:split(board.indate," ")[0]}</td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <a href="boardUpdateForm.do/${board.idx}" class="btn btn-primary btn-sm">수정화면</a>
                        <a href="boardDelete.do/${board.idx}" class="btn btn-warning btn-sm">삭제</a>
                        <%--뒤에 파라미터 담아서 보낼 때는 보통 ?idx=${board.idx}이런 식으로 보내는데,
                        뒤에 바로 경로 처럼 지정 할 수도 있음--%>
                        <a href="boardList.do" class="btn btn-info btn-sm">목록</a>
                    </td>
                    </tr>

            </table>
            </form>
        </div>
        <div class="panel-footer">footer area</div>
    </div>
</div>
</body>
</html>
