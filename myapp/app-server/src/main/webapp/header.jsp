<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style='height:50px;background-color:yellow;'>
    <img src='https://png.pngtree.com/png-vector/20220521/ourlarge/pngtree-veterinary-clinic-cat-dog-people-png-image_4653265.png' style='height:40px'>
    <a href='/protector/list.jsp'>보호자</a>
    <a href='/patient/list.jsp?category=1'>동물환자</a>

<c:choose>
    <c:when test="${empty sessionScope.loginUser}">
        <a href='/AHauth/form.jsp'>로그인</a>
    </c:when>
    <c:otherwise>
        <c:if test="${empty sessionScope.loginUser.photo}">
            <img style='height:40px' src='/images/avatar.png'>
        </c:if>
        <c:if test="${not empty sessionScope.loginUser.photo}">
            <img src='http://mvsenqskbqzl19010704.cdn.ntruss.com/protector/${loginUser.photo}?type=f&w=30&h=40&faceopt=true&ttype=jpg'>
        </c:if>
        ${loginUser.name} <a href='/AHauth/logout.jsp'>로그아웃</a>
    </c:otherwise>
</c:choose>
</div>