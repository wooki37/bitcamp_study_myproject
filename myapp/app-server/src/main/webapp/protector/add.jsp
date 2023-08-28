<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ page import="bitcamp.myapp_project.vo.Protector"%>

<jsp:useBean id="protectorDao" type="bitcamp.myapp_project.dao.ProtectorDao" scope="application"/>
<jsp:useBean id="sqlSessionFactory" type="org.apache.ibatis.session.SqlSessionFactory" scope="application"/>
<jsp:useBean id="ncpObjectStorageService" type="bitcamp.util.NcpObjectStorageService" scope="application"/>
<%
    request.setAttribute("refresh", "2;url=list.jsp");

    Protector pt = new Protector();
    pt.setName(request.getParameter("name"));
    pt.setEmail(request.getParameter("email"));
    pt.setPhone(request.getParameter("phone"));
    pt.setAddress(request.getParameter("address"));
    pt.setPostNo(request.getParameter("postNo"));

    Part photoPart = request.getPart("photo");
    if (photoPart.getSize() > 0) {
      String uploadFileUrl = ncpObjectStorageService.uploadFile(
          "bitcamp-nc7-bucket-12", "protector/", photoPart);
      pt.setPhoto(uploadFileUrl);
    }

    protectorDao.insert(pt);
    sqlSessionFactory.openSession(false).commit();
    response.sendRedirect("list.jsp");

%>