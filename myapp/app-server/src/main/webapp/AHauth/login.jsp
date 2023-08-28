<%@ page
    language="java"
    pageEncoding="UTF-8"
    contentType="text/html;charset=UTF-8"
    trimDirectiveWhitespaces="true"
    errorPage="/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="refresh" value="2;url=/AHauth/form.jsp" scope="request"/>

<jsp:useBean id="pt" class="bitcamp.myapp_project.vo.Protector" scope="page"/>
<c:set target="${pageScope.pt}" property="no" value="${param.no}"/>
<c:set target="${pageScope.pt}" property="phone" value="${param.phone}"/>

<c:if test="${not empty param.saveNo}">
  <%
    Cookie cookie = new Cookie("no", pt.getNo());
    response.addCookie(cookie);
  %>
</c:if>

<c:if test="${empty param.saveNo}">
  <%
    Cookie cookie = new Cookie("no", "no");
    cookie.setMaxAge(0);
    response.addCookie(cookie);
  %>
</c:if>

<jsp:useBean id="protectorDao" type="bitcamp.myapp_project.dao.protectorDao" scope="application"/>
<c:set var="loginUser" value="${protectorDao.findByNoAndPhone(pt)}" scope="session"/>

<jsp:useBean id="loginUser" type="bitcamp.myapp_project.vo.Protector" scope="session"/>
<c:redirect url="/"/>