<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>동물사랑병원</title>
</head>
<body>

<jsp:include page="../header.jsp"/>

<h1>보호자</h1>
<form action='/protector/add.jsp' method='post' enctype='multipart/form-data'>
<table border='1'>
<tr>
  <th>이름</th> <td style="width:200px;"><input type='text' name='name'></td>
</tr>
<tr>
  <th>이메일</th> <td><input type='email' name='email'></td>
</tr>
  <tr>
    <th>전화번호(010)</th> <td><input type='text' name='phone'></td>
  </tr>
  <tr>
    <th>주소</th> <td><input type='text' name='address'></td>
  </tr>
  <tr>
    <th>우편번호</th> <td><input type='text' name='postNo'></td>
  </tr>
<tr>
  <th>사진</th> <td><input type='file' name='photo'></td>
</tr>
</table>
<button>등록</button>
</form>

<jsp:include page="../footer.jsp"/>

</body>
</html>