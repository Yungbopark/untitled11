<!DOCTYPE html>
<html lang="en">
<head>
    <title>boardList</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function makeView(data) { // data=[{},{},{},,,,]
            var listHtml = "<table class='table table-bordered'>";
                listHtml += "<tr>";
                listHtml += "<td>번호</td>";
                listHtml += "<td>제목</td>";
                listHtml += "<td>작성자</td>";
                listHtml += "<td>작성일</td>";
                listHtml += "<td>조회수</td>";
                listHtml += "</tr>";
            $.each(data, function (index,obj) {
                listHtml += "<tr>";
                listHtml += "<td>"+obj.idx+"</td>";
                listHtml += "<td>"+obj.title+"</td>";
                listHtml += "<td>"+obj.writer+"</td>";
                listHtml += "<td>"+obj.indate+"</td>";
                listHtml += "<td>"+obj.count+"</td>";
                listHtml += "</tr>";
            });
            listHtml += "</table>";
            $("#view").html(listHtml);
        }

        function loadList() {
            /*서버와의 통신
            * 게시판 리스트 가져오기*/
            $.ajax({
                url : "boardList.do",
                type : "get",
                dataType : "json",
                success : makeView,
                /*ajax 문법 주의 함수 호출 할때 ()붙이면 안됨*/
                error: function () {alert("error!");}});
        }

        $(document).ready(function () {
            loadList();

        });
    </script>

    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
</head>
<body>

<div class="container">
    <h2>Spring MVC01</h2>
    <div class="panel panel-default">
        <div class="panel-heading">BOARD</div>
        <div class="panel-body" id="view"></div>
        <div class="panel-footer">footer area</div>
    </div>
</div>
</body>
</html>
