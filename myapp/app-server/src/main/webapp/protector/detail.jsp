<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="protectorDao" type="bitcamp.myapp_project.dao.ProtectorDao" scope="application"/>
<c:set var="protector" value="${protectorDao.findBy(param.no)}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>보호자</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>보호자</h1>
<c:if test="${empty protector}">
    <p>해당 번호의 보호자가 없습니다!</p>
</c:if>
<c:if test="${not empty protector}">
  <form action='/protector/update.jsp' method='post' enctype='multipart/form-data'>
  <table border='1'>
  <tr>
      <th style='width:120px;'>사진</th>
      <td style='width:300px;'>
        <c:if test="${empty protector.photo}">
          <img style='height:80px' src='/images/avatar.png'>
        </c:if>
        <c:if test="${not empty protector.photo}">
          <a href='https://kr.object.ncloudstorage.com/bitcamp-nc7-bucket-12/protector/${protector.photo}'>
            <img src='http://mvsenqskbqzl19010704.cdn.ntruss.com/protector/${protector.photo}?type=f&w=60&h=80&faceopt=true&ttype=jpg'>
          </a>
        </c:if>
          <input type='file' name='photo'></td></tr>
  <tr>
      <th style='width:120px;'>번호</th>
      <td style='width:300px;'><input type='text' name='no' value='${protector.no}' readonly></td></tr>
  <tr>
      <th>이름</th>
      <td><input type='text' name='name' value='${protector.name}'></td></tr>
  <tr>
      <th>이메일</th>
      <td><input type='email' name='email' value='${protector.email}'></td></tr>
  <tr>
    <th>전화번호</th>
    <td><input type="text" name="phone" value='${protector.phone}'></td>
  </tr>
  <tr>
    <th>주소</th>
    <td><input type="text" name="address" value='${protector.address}'></td>
  </tr>
  <tr>
    <th>우편번호</th>
    <td><input type="text" name="postNo" value='${protector.postNo}'></td>
  </tr>
</table>
  </table>
  <div>
  <button>변경</button>
  <button type='reset'>초기화</button>
      <a href='/protector/delete.jsp?no=${protector.no}'>삭제</a>
  <a href='/protector/list.jsp'>목록</a>
  </div>
  </form>
</c:if>
<jsp:include page="../footer.jsp"/>

</body>
</html>