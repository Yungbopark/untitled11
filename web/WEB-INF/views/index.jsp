<%--
  Created by IntelliJ IDEA.
  User: Jungwoo Park
  Date: 11/5/2022
  Time: 12:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <h3>${mvo.memName}님 방문을 환영합니다.</h3>
    </c:if>

    <%--톰캣을 최초 실행했을 때도 mvo가 비어있지 않은 것으로 나옴--%>
    <%--어디선가 mvo를 한 번 비워줘야 될듯--%>

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
