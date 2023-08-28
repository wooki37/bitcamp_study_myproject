<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"%> <%-- directive element --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>보호자</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>보호자 목록</h1>
<div style='margin:5px;'>
<a href='/protector/form.jsp'>새 보호자 등록</a>
</div>
<table border='1'>
<thead>
  <tr><th>번호</th> <th>이름</th> <th>이메일</th> <th>전화번호</th> <th>주소</th> <th>우편번호</th></tr>
</thead>
<tbody>
<jsp:useBean id="protectorDao" type="bitcamp.myapp_project.dao.ProtectorDao" scope="application"/>
<c:set var="list" value="${protectorDao.findAll()}" scope="page"/>
<c:forEach items="${list}" var="protector">
    <tr>
        <td>${protector.no}</td>
        <td>
            <img src='http://mvsenqskbqzl19010704.cdn.ntruss.com/member/${protector.photo}?type=f&w=30&h=40&faceopt=true&ttype=jpg'>
            <a href='/protector/detail.jsp?no=${protector.no}'>${protector.name}</a></td>
        <td>${protector.email}</td>
    </tr>
</c:forEach>
</tbody>
</table>
<a href='/'>메인</a>

<jsp:include page="../footer.jsp"/>
</body>
</html>