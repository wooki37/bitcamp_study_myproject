<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bitcamp.myapp_project.vo.AHAttachedFile"%>
<%@ page import="bitcamp.myapp_project.vo.Patient"%>

<jsp:useBean id="patientDao" type="bitcamp.myapp_project.dao.PatientDao" scope="application"/>
<jsp:useBean id="sqlSessionFactory" type="org.apache.ibatis.session.SqlSessionFactory" scope="application"/>
<jsp:useBean id="ncpObjectStorageService" type="bitcamp.util.NcpObjectStorageService" scope="application"/>
<jsp:useBean id="loginUser" class="bitcamp.myapp_project.vo.Protector" scope="session"/>
<%
    if (loginUser.getNo() == 0) {
      response.sendRedirect("/AHauth/form.jsp");
      return;
    }

    request.setAttribute("refresh", "2;url=list.jsp?category=" + request.getParameter("category"));

      Patient p = new Patient();
      p.setProtectorNo(loginUser);
      p.setPatientNo(Integer.parseInt(request.getParameter("patientNo")));
      p.setName(request.getParameter("name"));
      p.setBreeds(request.getParameter("breeds"));
      p.setAge(Integer.parseInt(request.getParameter("age")));
      p.setGender(request.getParameter("gender").charAt(0));
      p.setCategory(Integer.parseInt(request.getParameter("category")));

    ArrayList<AHAttachedFile> attachedFiles = new ArrayList<>();
    for (Part part : request.getParts()) {
        if (part.getName().equals("files") && part.getSize() > 0) {
          String uploadFileUrl = ncpObjectStorageService.uploadFile(
                  "bitcamp-nc7-bucket-12", "patient/", part);
          AHAttachedFile attachedFile = new AHAttachedFile();
          attachedFile.setFilePath(uploadFileUrl);
          attachedFiles.add(attachedFile);
        }
    }
    p.setAttachedFiles(attachedFiles);

    if (patientDao.update(p) == 0) {
        throw new Exception("등록된 환자가 없거나 변경 권한이 없습니다.");
    } else {
        if (attachedFiles.size() > 0) {
          int count = patientDao.insertFiles(p);
          System.out.println(count);
        }

        sqlSessionFactory.openSession(false).commit();
        response.sendRedirect("list.jsp?category=" + request.getParameter("category"));
    }
%>