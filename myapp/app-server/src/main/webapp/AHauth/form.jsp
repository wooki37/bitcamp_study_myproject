<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>우리동물사랑병원</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>로그인</h1>
<form action='/AHauth/login,jsp' method="post">
<table border="1">
<tr>
  <th>보호자번호</th> <td><input type='no' name='no' value='${cookie.no.value}'></td>
</tr>
<tr>
  <th>전화번호</th> <td><input type='phone' name='phone'></td>
</tr>
</table>
<button>로그인</button>
 <input type='checkbox' name='saveNo' ${cookie.no != null ? "checked" : ""}> 보호자번호 저장
</form>
<jsp:include page="../footer.jsp"/>
</body>
</html>