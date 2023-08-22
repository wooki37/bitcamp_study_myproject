package bitcamp.myapp_project.handler;

import bitcamp.myapp_project.vo.AHAttachedFile;
import bitcamp.myapp_project.vo.Patient;
import bitcamp.myapp_project.vo.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/patient/file/delete")
public class AHFileDeleteServlet extends HttpServlet {

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
    int fileNo = Integer.parseInt(request.getParameter("no"));

    // 첨부파일 번호로 첨부파일 데이터를 가져온다.
    AHAttachedFile attachedFile = AHInitServlet.patientDao.findFileBy(fileNo);

    // 첨부파일 데이터에 있는 게시글 번호로 게시글 데이터를 가져온다.
    Patient p = AHInitServlet.patientDao.findBy(category, attachedFile.getPatientNo());

    // 게시글 데이터의 작성자와 로그인 한 작성자가 일치하는지 검사한다.
    if (p.getProtectorNo().getNo() != loginUser.getNo()) {
      throw new ServletException("환자정보 변경 권한이 없습니다!");
    }

    try {
      if (AHInitServlet.patientDao.deleteFile(fileNo) == 0) {
        throw new Exception("해당 번호의 첨부파일이 없거나 삭제 권한이 없습니다.");
      } else {
        response.sendRedirect("/patient/list?category=" + category + "&no=" + p.getPatientNo());
      }
      AHInitServlet.sqlSessionFactory.openSession(false).commit();

    } catch (Exception e) {
      AHInitServlet.sqlSessionFactory.openSession(false).rollback();
      throw new RuntimeException(e);
    }
  }
}
