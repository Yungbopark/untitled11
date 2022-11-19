
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
    function goInsert() {
            /*parameter 세개 가져와서 서버로 전달 */
            /*
                        let title = $("#title").val();
                        let contents = $("#contents").val();
                        let writer = $("#writer").val();
            */
            let fData = $("#frm").serialize();
            /*form에 있는 모든 parameter를 가져옴*/
            $.ajax({
                url: "board/new",
                type: "post",
                data: fData,
                success: loadList,
                error: function () {
                    alert("error");
                }
            });
            // form 초기화
        /*$("#title").val("");
        $("#contents").val("");
        $("#writer").val("");*/
        $("#formClear").trigger("click");
        }

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
                listHtml += "<td id='t"+obj.idx+"'><a href='javascript:goContents("+obj.idx+")'>"+obj.title+"</a></td>";
                listHtml += "<td>"+obj.writer+"</td>";
                listHtml += "<td>"+obj.indate+"</td>";
                listHtml += "<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
                listHtml += "</tr>";

                listHtml += "<tr id='c"+obj.idx+"' style='display: none'>";
                listHtml += "<td>내용</td>";
                listHtml += "<td colspan='4'>";
                listHtml += "<textarea rows='7' id='ta"+obj.idx+"' class='form-control' readonly></textarea>";
                if("${mvo.memID}" == obj.memID) {
                listHtml += "<br/>";
                listHtml += "<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
                listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
            } else {
                    listHtml += "<br/>";
                    listHtml += "<span id='ub"+obj.idx+"'><button disabled class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
                    listHtml += "<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
                }
                listHtml += "</td>";
                listHtml += "</tr>";

            });
                /*로그인을 해야 보이는 부분*/
                if(${!empty mvo}) {

                    listHtml += "<tr>";
                    listHtml += "<td colspan='5'>";
                    listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
                    listHtml += "</td>";
                    listHtml += "</tr>";
                }
                listHtml += "</table>";
                $("#view").html(listHtml);

        $("#view").css("display", "block");
        $("#writeForm").css("display", "none");


        }

        function goUpdateForm(idx) { //
            $("#ta" + idx).attr("readonly", false);
            var title = $("#t"+idx).text();
            var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"'/>";

            $("#t" + idx).html(newInput);

            var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
            $("#ub" + idx).html(newButton);
                    }

        function goUpdate(idx) {

            var title = $("#nt"+idx).val();
            var contents = $("#ta" + idx).val();

            $.ajax({
                url : "board/update",
                type : "put",
                contentType:'application/json;charset=utf-8',
                data : JSON.stringify({"idx":idx, "title":title, "contents":contents}),
                success : loadList,
                error: function () {
                    alert("error");
                }
            })


        }

        function goContents(idx) {
            if ($("#c"+idx).css("display")=="none") {


                /*상세보기를 title 찍었을 때 가져오도록 구현*/
                $.ajax({
                    url : "board/"+idx,
                    type : "get",
                    data : {"idx": idx},
                    dataType: "json",
                    success : function (data) { //jason 데이터가 날아온다. 데이터 중에 "contents" 만 뽑아냄
                        $("#ta" + idx).val(data.contents);
                    },
                    error : function () {
                        alert("error!");
                    }
                });

                $("#c" + idx).css("display", "table-row");
                $("#ta" + idx).attr("readonly", true);

            } else {
                /*title 이 닫힐 때 count + 1 한다*/
                $("#c" + idx).css("display", "none");
                $.ajax({
                    url : "board/count/"+idx,
                    type : "put",
                    data : {"idx":idx},
                    dataType : "json",
                    success: function (data) {
                        $("#cnt" + idx).val(data.count);
                        loadList();

                    },
                    error: function () {
                        alert("error!");
                    }

                })
            }

            
        }
        
        function goForm() {
            $("#view").css("display", "none");
            $("#writeForm").css("display", "block");
        }
        function goList() {
            $("#view").css("display", "block");
            $("#writeForm").css("display", "none");
        }
        function loadList() {
            /*서버와의 통신
            * 게시판 리스트 가져오기*/
            $.ajax({
                url : "board/all",
                type : "get",
                dataType : "json",
                success : makeView,
                /*ajax 문법 주의 함수 호출 할때 ()붙이면 안됨*/
                error: function () {alert("error!");}});
        }

    function goDelete(idx) {

        $.ajax({
            url: "board/"+idx,
            type: "delete",
            success: loadList,
            error: function () {
                alert("error!");}
        });
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
    <jsp:include page="../common/header.jsp"/>
    <h2>Spring MVC01</h2>
    <div class="panel panel-default">
        <div class="panel-heading">BOARD</div>
        <div class="panel-body" id="view"></div>
        <div class="panel-body" id="writeForm" style="display: none">
            <form id="frm" method="post">
                <input type="hidden" name="memID" id="memID" value="${mvo.memID}">
                <table class="table">
                    <tr>
                        <td>제목</td>
                        <td><input type="text" id="title" name="title" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td><textarea rows="7" id="contents" class="form-control" name="contents"></textarea></td>
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td><input type="text" id="writer" name="writer" class="form-control" value="${mvo.memName}" readonly/></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
                            <%--등록버튼을 누르면 데이터 비동기 전송 되도록--%>
                            <button type="reset" class="btn btn-warning btn-sm" id="formClear">취소</button>
                            <button type="button" class="btn btn-warning btn-sm">취소</button>
                        </td>
                    </tr>

                </table>
            </form>
        </div>
        <%--실패 메시지--%>

        <div class="panel-footer">footer area</div>
    </div>
</div>
</body>
</html>
