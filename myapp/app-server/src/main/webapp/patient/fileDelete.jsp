<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ page import="bitcamp.myapp_project.vo.AHAttachedFile"%>
<%@ page import="bitcamp.myapp_project.vo.Patient"%>

<jsp:useBean id="patientDao" type="bitcamp.myapp_project.dao.PatientDao" scope="application"/>
<jsp:useBean id="sqlSessionFactory" type="org.apache.ibatis.session.SqlSessionFactory" scope="application"/>
<jsp:useBean id="loginUser" class="bitcamp.myapp_project.vo.Protector" scope="session"/>
<%
    if (loginUser.getNo() == 0) {
      response.sendRedirect("/AHauth/form.jsp");
      return;
    }

    int category = Integer.parseInt(request.getParameter("category"));
    int fileNo = Integer.parseInt(request.getParameter("no"));

    AHAttachedFile attachedFile = patientDao.findFileBy(fileNo);
    Patient p = AHInitServlet.patientDao.findBy(category, attachedFile.getPatientNo());

    request.setAttribute("refresh", "2;url=detail.jsp?category=" + category
        + "&no=" + board.getNo());

     if (p.getProtectorNo().getNo() != loginUser.getNo()) {
          throw new ServletException("환자정보 변경 권한이 없습니다!");
        }

    if (patientDao.deleteFile(fileNo) == 0) {
        throw new Exception("해당 번호의 첨부파일이 없거나 삭제 권한이 없습니다.");
    } else {
        response.sendRedirect("/patient/detail.jsp?category=" + category + "&no=" + p.getPatientNo());
    }
    sqlSessionFactory.openSession(false).commit();

%>
