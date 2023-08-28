<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>동물사랑병원</title>
</head>
<body>

<jsp:include page="header.jsp"/>

<h1>MyApp(JSP)</h1>
<p>실습 프로젝트 입니다</p>

<jsp:include page="footer.jsp"/>

</body>
</html>

<%-- 이미지 추가 --%>
<div class="image-container">
  <img src="/images/haru.jpeg" alt="첫 번째 이미지" width="200">
  <img src="/images/hadol.jpeg" alt="두 번째 이미지" width="200">
</div>
</body>
</html>
