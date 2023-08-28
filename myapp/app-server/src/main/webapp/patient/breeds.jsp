<%@ page language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ page import="bitcamp.myapp_project.vo.Patient"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="1;url=/patient/list">
    <title>품종 선택</title>
</head>
<body>
    <h1>품종 선택</h1>
    <form method="post" action="/getBreed">
        <label>품종을 선택해주세요:</label>
        <select name="breedType" onchange="handleBreedTypeChange(this)">
            <option value="강아지">강아지</option>
            <option value="고양이">고양이</option>
            <option value="직접입력">직접입력</option>
        </select>
        <input type="text" name="customBreed" id="customBreed" style="display:none;" placeholder="품종을 직접 입력하세요">
        <input type="submit" value="확인">
    </form>
    <script>
        function handleBreedTypeChange(selectElement) {
            var customBreedInput = document.getElementById('customBreed');
            if (selectElement.value === '직접입력') {
                customBreedInput.style.display = 'block';
                customBreedInput.setAttribute('required', 'required');
            } else {
                customBreedInput.style.display = 'none';
                customBreedInput.removeAttribute('required');
            }
        }
    </script>
    <%
    request.setAttribute("refresh", "2;url=list.jsp?category=" + request.getParameter("category"));

            Patient p = new Patient();
            p.setPatientNo(Integer.parseInt(request.getParameter("patientNo")));
            p.setName(request.getParameter("name"));
            p.setBreeds(request.getParameter("breeds"));
            p.setAge(Integer.parseInt(request.getParameter("age")));
            p.setGender(request.getParameter("gender").charAt(0));

        sqlSessionFactory.openSession(false).commit();
        response.sendRedirect("list.jsp?category=" + request.getParameter("category"));
    %>
</body>
</html>
