package bitcamp.myapp_project.handler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bitcamp.myapp_project.vo.Patient;
import bitcamp.myapp_project.vo.Protector;

@WebServlet("/patient/delete")
public class AHDeleteServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    Protector loginUser = (Protector) request.getSession().getAttribute("loginUser");
    if (loginUser == null) {
      response.sendRedirect("/AHauth/form.html");
      return;
    }
    int category = Integer.parseInt(request.getParameter("category"));

    Patient p = new Patient();
    p.setPatientNo(Integer.parseInt(request.getParameter("patientNo")));
    p.setProtectorNo(loginUser);
    p.setCategory(category);

    try {
      if (AHInitServlet.patientDao.delete(p) == 0) {
        throw new Exception("해당 번호가 존재하지 않습니다.");
      } else {
        response.sendRedirect("/patient/list?category=" + category);
      }
      AHInitServlet.sqlSessionFactory.openSession(false).commit();

    } catch (Exception e) {
      AHInitServlet.sqlSessionFactory.openSession(false).rollback();
      throw new RuntimeException(e);
    }
  }
}
