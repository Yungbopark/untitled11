<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <%--data-target : bootStrap attribute , 데이터가 열리고 닫힘 기능을 만들어 줌--%>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${contextPath}/">Spring1</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="${contextPath}/">Home</a></li>
                <li><a href="boardMain.do">board</a></li>
                <li><a href="#">Page 2</a></li>
            </ul>

            <c:if test="${empty mvo}">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">접속하기 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${contextPath}/memLoginForm.do">sign in</a></li>
                            <li><a href="${contextPath}/memJoin.do">sing up</a></li>
                        </ul>
                    </li>
                </ul>
            </c:if>

            <c:if test="${!empty mvo}">
                <%--MemberController 에서 session에 member 객채를 담음--%>
                <ul class="nav navbar-nav navbar-right">

                            <li><a href="${contextPath}/memUpdateForm.do">회원정보수정</a></li>
                            <li><a href="${contextPath}/memImageForm.do">프로필 사진등록</a></li>
                            <li><a href="${contextPath}/memLogout.do">로그아웃</a></li>
                            <c:if test="${!empty mvo}">
                                <label><c:if test="${mvo.memProfile eq ''}">
                                    <li><img src="${contextPath}/static/images/person.png" style="width: 50px; height: 50px;"/>${mvo.memName}님 방문을 환영합니다.</li>
                                </c:if>
                                    <c:if test="${mvo.memProfile ne ''}">
                                        <li><img src="${contextPath}/static/upload/${mvo.memProfile}" style="width: 50px; height: 50px;"/>${mvo.memName}님 방문을 환영합니다.</li>
                                    </c:if>
                                        </label>
                                C:\DEV\untitled11\
                            </c:if>
            </c:if>
                </ul>
        </div>
    </div>

</nav>
