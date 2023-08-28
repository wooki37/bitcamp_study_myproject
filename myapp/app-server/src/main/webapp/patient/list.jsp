<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="refresh" value="2;url=list.jsp?category=${param.category}" scope="request"/>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>동물환자</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>환자 목록</h1>
<div style='margin:5px;'>
<a href='/patient/form.jsp?category=${param.category}'>새 환자 등록</a>
</div>
<table border='1'>
<thead>
  <tr><th>환자번호</th> <th>보호자번호</th> <th>이름</th> <th>품종</th> <th>나이</th> <th>성별</th> <th>등록일</th></tr>
</thead>

<jsp:useBean id="patientDao" type="bitcamp.myapp_project.dao.PatientDao" scope="application"/>
<c:set var="list" value="${patientDao.findAll(param.category)}" scope="page"/>

<tbody>
<c:forEach items="${list}" var="patient">
    <tr>
      <td>${patient.patientNo}</td>
      <td><a href='/patient/detail.jsp?category=${patient.category}&no=${patient.patientNo}'>
        ${patient.name.length() > 0 ? patient.name : "환자없음"}
        </a>
      </td>
      <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></td>
    </tr>
</c:forEach>
</tbody>
</table>
<a href='/'>메인</a>

<jsp:include page="../footer.jsp"/>

</body>
</html>