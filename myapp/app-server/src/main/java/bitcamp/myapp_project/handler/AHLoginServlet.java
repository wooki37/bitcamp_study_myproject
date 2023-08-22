package bitcamp.myapp_project.handler;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bitcamp.myapp_project.vo.Patient;
import bitcamp.myapp_project.vo.Protector;

@WebServlet("/AHauth/login")
public class AHLoginServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    Protector pt = new Protector();
    pt.setNo(Integer.parseInt(request.getParameter("no")));
    pt.setPhone(request.getParameter("phone"));

    Protector loginUser = AHInitServlet.protectorDao.findByNoAndPhone(pt);
    if (loginUser != null) {
      // 로그인 정보를 다른 요청에서도 사용할 있도록 세션 보관소에 담아 둔다.
      request.getSession().setAttribute("loginUser", loginUser);
      response.sendRedirect("/");
      return;
    }

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<!DOCTYPE html>");
    out.println("<html>");
    out.println("<head>");
    out.println("<meta charset='UTF-8'>");
    out.println("<meta http-equiv='refresh' content='1;url=/AHauth/form.html'>");
    out.println("<title>로그인</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<h1>로그인</h1>");
    out.println("<p>보호자 정보가 일치하지 않습니다.</p>");
    out.println("</body>");
    out.println("</html>");
  }
}
