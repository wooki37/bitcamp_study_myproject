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

    // 오류가 발생했을 때 refresh 할 URL을 미리 지정한다.
    request.setAttribute("refresh", "2;url=list.jsp?category=" + request.getParameter("category"));

       Patient p = new Patient();
       p.setProtectorNo(loginUser);
       p.setName(request.getParameter("name"));
       p.setBreeds(request.getParameter("breeds"));
       p.setAge(Integer.parseInt(request.getParameter("age")));
       p.setGender(request.getParameter("gender").charAt(0));
       p.setCategory(Integer.parseInt(request.getParameter("category")));

           // 직접입력인 경우에는 breeds_custom 값을 사용
             String selectedBreeds = request.getParameter("breeds");
             if ("직접입력".equals(selectedBreeds)) {
               p.setBreeds(request.getParameter("breeds_custom"));
             } else {
               p.setBreeds(selectedBreeds);
             }

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

    patientDao.insert(p);
    if (attachedFiles.size() > 0) {
        patientDao.insertFiles(p);
    }

    sqlSessionFactory.openSession(false).commit();
    response.sendRedirect("list.jsp?category=" + request.getParameter("category"));
%>