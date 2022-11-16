<%--
  Created by IntelliJ IDEA.
  User: Jungwoo Park
  Date: 11/5/2022
  Time: 1:23 PM
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
          $("#messageType").attr("class", "modal-content panel-warning");
          $("#myMessage").modal("show");
      }



    });
    function passwordCheck() {
      /*첫번 쨰와 두번 쨰 패스워드를 가져와 체크*/
        var memPassword1 = $("#memPassword1").val();
        var memPassword2 = $("#memPassword2").val();

      if (memPassword1 != memPassword2) {
        $("#passMessage").attr("style", "color: red");
        $("#passMessage").html("비밀번호가 일치하지 않습니다.");

      } else {
        $("#passMessage").attr("style", "color: green");
        $("#passMessage").html("비밀번호가 일치합니다.");
        $("#memPassword").val(memPassword1);
      }

    }
    function ageCheck() {
      var memAge = $("#memAge").val();
      if(memAge == null || memAge=="" || memAge==0) {
        alert("나이를 입력하세요.");
        return false;
      }
      document.form.submit();
    }
  </script>
</head>
<body>

<div class="container">

  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원정보수정양식</div>
    <div class="panel-body">

      <form name="form" action="${contextPath}/memUpdate.do" method="post">
        <input type="hidden" name="memID" id = "memID" value="${mvo.memID}"/>
        <input type="hidden" name="memPassword" id ="memPassword" value=""/>
        <table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">
          <tr>
            <td style="width: 110px; vertical-align: middle" >아이디</td>
            <td>${mvo.memID}</td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle" >비밀번호</td>
            <td colspan="2"><input class="form-control" type="password" name="memPassword1" id="memPassword1" maxlength="20" placeholder="비밀번호를 입력 하세요."/></td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle" >비밀번호 확인</td>
            <td colspan="2"><input class="form-control" type="password" name="memPassword2" onkeyup="passwordCheck()" id="memPassword2" maxlength="20" placeholder="비밀번호를 재 입력 하세요."/></td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle" >사용자 이름</td>
            <td colspan="2"><input class="form-control" type="text" name="memName" id="memName" maxlength="20" placeholder="사용자 이름을 입력 하세요." value="${mvo.memName}"/></td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle" >나이</td>
            <td colspan="2"><input class="form-control" type="number" name="memAge" id="memAge" maxlength="20" placeholder="나이를 입력 하세요." value="${mvo.memAge}" /></td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle" >성별</td>
            <td colspan="2">
              <div class="form-group" style="text-align: center; margin: 0 auto;">
                <div class="btn-group" data-toggle="buttons">
                  <label class="btn btn-primary
                     <c:if test="${mvo.memGender eq '남자'}">
                     active
                     </c:if>
                    ">
                    <input type="radio" autocomplete="off" value="남자" name="memGender"
                            <c:if test="${mvo.memGender eq '남자'}">
                              checked
                            </c:if>

                    />남자
                  </label>
                  <label class="btn btn-primary
                    <c:if test="${mvo.memGender eq '여자'}">
                      active
                      </c:if>
                      ">
                    <input type="radio" autocomplete="off" value="여자" name="memGender"
                            <c:if test="${mvo.memGender eq '여자'}">
                              checked
                            </c:if>
                    />여자
                  </label>
                </div>

              </div>
            </td>
          </tr>
          <tr>
            <td style="width: 110px; vertical-align: middle">이메일</td>
            <td colspan="2"><input class="form-control" type="text" name="memEmail" id="memEmail" maxlength="20" placeholder="이메일을 입력하세요." value="${mvo.memEmail}" /></td>
          </tr>
          <tr>
            <td colspan="3" style="text-align: left;">
              <span id="passMessage"></span>
              <input type="button" class="btn btn-primary btn-sm pull-right" value="수정" onclick="ageCheck()"/>
            </td>
          </tr>
        </table>
      </form>
    </div>

    <%--실패 메시지 출력하는 부분--%>
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
    <div class="panel-footer">footer area</div>
  </div>
</div>

</body>
</html>
