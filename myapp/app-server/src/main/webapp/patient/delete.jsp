<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ page import="bitcamp.myapp_project.vo.Patient"%>

<jsp:useBean id="patientDao" type="bitcamp.myapp_project.dao.PatientDao" scope="application"/>
<jsp:useBean id="sqlSessionFactory" type="org.apache.ibatis.session.SqlSessionFactory" scope="application"/>
<jsp:useBean id="loginUser" class="bitcamp.myapp_project.vo.Protector" scope="session"/>
<%
    if (loginUser.getNo() == 0) {
      response.sendRedirect("/AHauth/form.jsp");
      return;
    }

    request.setAttribute("refresh", "2;url=list.jsp?category=" + request.getParameter("category"));
    int category = Integer.parseInt(request.getParameter("category"));

    Patient p = new Patient();
    p.setPatientNo(Integer.parseInt(request.getParameter("patientNo")));
    p.setProtectorNo(loginUser);
    p.setCategory(category);

    patientDao.deleteFiles(p.getPatientNo());

    if (patientDao.delete(p) == 0) {
        throw new Exception("해당 번호의 환자가 없거나 삭제 권한이 없습니다.");
    } else {
        sqlSessionFactory.openSession(false).commit();
        response.sendRedirect("list.jsp?category=" + request.getParameter("category"));
    }
%>