<%--
  Created by IntelliJ IDEA.
  User: Jungwoo Park
  Date: 11/5/2022
  Time: 12:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            if (${!empty msgType}) {
                /*msgType이 empty가 아니라는 건 실패 했다는 의미 */
                $("#messageType").attr("class", "modal-content panel-success");
                $("#myMessage").modal("show");
            }

        });

    </script>
</head>
<body>

<div class="container">
    <jsp:include page="common/header.jsp"/>
    <c:if test="${empty mvo}">
        <h3>SpringMVC03</h3>
    </c:if>
    <c:if test="${!empty mvo}">
        <label><c:if test="${mvo.memProfile eq ''}">
            <img src="${contextPath}/static/images/person.png" style="width: 50px; height: 50px;">
               </c:if>
    <c:if test="${!mvo.memProfile eq ''}">
            <img src="${contextPath}/static/upload/${mvo.memProfile}" style="width: 50px; height: 50px;">
                </c:if>
                ${mvo.memName}님 방문을 환영합니다.</label>
    </c:if>
    <div class="panel panel-default">
        <div>
            <img src="${contextPath}" style="width: 100%; height: 400px;">
        </div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
                <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
                <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
            </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">
                    <h3>HOME</h3>
                    <p>Some content.</p>
                </div>
                <div id="menu1" class="tab-pane fade">
                    <h3>게시판</h3>
                    <p>Some content in menu 1.</p>
                </div>
                <div id="menu2" class="tab-pane fade">
                    <h3>공지사항</h3>
                    <p>Some content in menu 2.</p>
                </div>
            </div>
        </div>
        <div class="panel-footer">footer area</div>
    </div>

    <p></p>
</div>
<div id="myMessage" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div id="messageType" class="modal fade" role="dialog">
            <div class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">${msgType}</h4>
            </div>
            <div class="modal-body">
                <p>${msg}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
</body>
</html>
