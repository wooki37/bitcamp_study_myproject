package bitcamp.myapp_project.handler;

import bitcamp.myapp_project.vo.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/index.html")
public class AHHomeServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<!DOCTYPE html>");
    out.println("<!DOCTYPE html>");
    out.println("<html>");
    out.println("<head>");
    out.println("<meta charset='UTF-8'>");
    out.println("<title>동물사랑병원</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<h1>MyApp1</h1>");
    out.println("<ul>");
    out.println("  <li><a href='/protector/list'>보호자</a></li>");
    out.println("  <li><a href='/patient/list?category=1'>환자</a></li>");

    Protector loginUser = (Protector) request.getSession().getAttribute("loginUser");
    if (loginUser == null) {
      out.println("  <li><a href='/AHauth/form.html'>로그인</a></li>");
    } else {
      out.printf("  <li>%s <a href='/AHauth/logout'>로그아웃</a></li>", loginUser.getName());
    }
    out.println("</ul>");
    out.println("</body>");
    out.println("</html>");

  }
}