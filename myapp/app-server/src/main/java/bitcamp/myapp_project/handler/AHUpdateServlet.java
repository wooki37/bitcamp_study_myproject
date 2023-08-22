package bitcamp.myapp_project.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import bitcamp.myapp_project.vo.AHAttachedFile;
import bitcamp.myapp_project.vo.Patient;
import bitcamp.myapp_project.vo.Protector;

@WebServlet("/patient/update")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class AHUpdateServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    Protector loginUser = (Protector) request.getSession().getAttribute("loginUser");
    if (loginUser == null) {
      response.sendRedirect("/AHauth/form/html");
      return;
    }

    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<!DOCTYPE html>");
    out.println("<html>");
    out.println("<head>");
    out.println("<meta charset='UTF-8'>");
    out.println("<title>환자정보</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("<h1>환자 정보 변경</h1>");

    try {
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
          String uploadFileUrl = AHInitServlet.ncpObjectStorageService.uploadFile(
                  "bitcamp-nc7-bucket-12", "patient/", part);
          AHAttachedFile attachedFile = new AHAttachedFile();
          attachedFile.setFilePath(uploadFileUrl);
          attachedFiles.add(attachedFile);
        }
      }
      p.setAttachedFiles(attachedFiles);

      if (AHInitServlet.patientDao.update(p) == 0) {
        out.println("<p>등록된 환자정보가 없습니다.</p>");
      } else {
        if (attachedFiles.size() > 0) {
          int count = AHInitServlet.patientDao.insertFiles(p);
          System.out.println(count);
        }
        out.println("<p>변경 완료 했습니다!</p>");
        response.setHeader("refresh", "1;url=/patient/list?category=" + p.getCategory());
      }
      AHInitServlet.sqlSessionFactory.openSession(false).commit();
    } catch (Exception e) {
      AHInitServlet.sqlSessionFactory.openSession(false).rollback();
      out.println("<p>변경 실패입니다!</p>");
      e.printStackTrace();
    }
    out.println("</body>");
    out.println("</html>");
  }
}
