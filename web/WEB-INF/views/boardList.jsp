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
</head>
<body>

<div class="container">
    <h2>Sirng MVC01</h2>
    <div class="panel panel-default">
        <div class="panel-heading">BOARD</div>
        <div class="panel-body">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <c:forEach var="vo" items = "${list}">

        <tbody>
        <tr>
            <td>${vo.idx}</td>
            <td>${vo.title}</td>
            <td>${vo.writer}</td>
            <td>${vo.indate}</td>
            <td>${vo.count}</td>
            </tr>
        </tbody>
        </c:forEach>
    </table>
    <a href="boardForm.do" class="btn btn-primary btn-small">글쓰기</a>
</div>
        <div class="panel-footer">footer area</div>
    </div>
</div>
</body>
</html>
