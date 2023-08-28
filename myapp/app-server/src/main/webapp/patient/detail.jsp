<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="refresh" value="2;url=list.jsp?category=${param.category}" scope="request"/>
<jsp:useBean id="patientDao" type="bitcamp.myapp_project.dao.PatientDao" scope="application"/>
<jsp:useBean id="sqlSessionFactory" type="org.apache.ibatis.session.SqlSessionFactory" scope="application"/>
<c:set var="patient" value="${patientDao.findBy(param.category,param.patientNo)}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>환자 상세 정보</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>환자</h1>

<c:if test="${empty patient}">
    <p>해당 번호의 환자가 없습니다!</p>
</c:if>

<c:if test="${not empty patient}">
<form action="/patient/update" method="post" enctype="multipart/form-data">
  <input type="hidden" name="category" value='${patient.category}'>
  <table border="1">
    <tr>
      <th style="width:120px;">환자번호</th>
      <td style="width:300px;"><input type="text" name="patientNo" value='${patient.patientNo}' readonly></td>
    </tr>
    <tr>
      <th style="width:120px;">보호자번호</th>
      <td style="width:300px;"><input type="text" name="protectorNo" value='${protector.protectorNo}' readonly></td>
    </tr>
    <tr>
      <th>이름</th>
      <td><input type="text" name="name" value='${patient.name}'</td>
    </tr>
    <tr>
      <th>품종</th>
      <td><input type="text" name="breeds" value='${patient.breeds}'></td>
    </tr>
    <tr>
      <th>나이</th>
      <td><input type="text" name="age" value='${patient.age}'></td>
    </tr>
    <tr>
      <th>성별</th>
      <td>
        <select name="gender">
          <option value="M" <%= (p.getGender() == 'M' ? "selected" : "") %>>수컷</option>
          <option value="W" <%= (p.getGender() == 'W' ? "selected" : "") %>>암컷</option>
        </select>
      </td>
    </tr>
  <tr><th>등록일</th> <td>${simpleDateFormatter.format(patient.createdDate)}</td></tr>
    <tr>
      <th>첨부파일</th>
    <c:forEach items="${patient.attachedFiles}" var="file">
        <a href='https://kr.object.ncloudstorage.com/bitcamp-nc7-bucket-12/patient/${file.filePath}'>${file.filePath}</a>
        [<a href='/patient/fileDelete.jsp?category=${param.category}&no=${file.no}'>삭제</a>]<br>
    </c:forEach>
        <input type='file' name='files' multiple>
    </td></tr>
    </table>

    <div>
    <button>변경</button>
    <button type='reset'>초기화</button>
    <a href='/patient/delete.jsp?category=${param.category}&no=${param.no}'>삭제</a>
    <a href='/patient/list.jsp?category=${param.category}'>목록</a>
    </div>
    </form>
    <% sqlSessionFactory.openSession(false).commit(); %>
</c:if>

<jsp:include page="../footer.jsp"/>

</body>
</html>