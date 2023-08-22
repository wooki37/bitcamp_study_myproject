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

@WebServlet("/patient/add")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class AHAddServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    Protector loginUser = (Protector) request.getSession().getAttribute("loginUser");
    if (loginUser == null) {
      response.sendRedirect("/AHauth/form.html");
      return;
    }

    try {
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
          String uploadFileUrl = AHInitServlet.ncpObjectStorageService
              .uploadFile("bitcamp-nc7-bucket-12", "patient/", part);
          AHAttachedFile attachedFile = new AHAttachedFile();
          attachedFile.setFilePath(uploadFileUrl);
          attachedFiles.add(attachedFile);
        }
      }
      p.setAttachedFiles(attachedFiles);

      response.setContentType("text/html;charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<!DOCTYPE html>");
      out.println("<html>");
      out.println("<head>");
      out.println("<meta charset='UTF-8'>");
      out.printf("<meta http-equiv='refresh' content='1;url=/patient/list?category=%d'>\n",
          p.getCategory());
      out.println("<title>환자 등록</title>");
      out.println("</head>");
      out.println("<body>");
      out.println("<h1>환자 등록</h1>");

      try {
        AHInitServlet.patientDao.insert(p);

        if (attachedFiles.size() > 0) {
          int count = AHInitServlet.patientDao.insertFiles(p);
        System.out.println(count);
      }
        AHInitServlet.sqlSessionFactory.openSession(false).commit();
        out.println("<p>등록 성공입니다!</p>");

      } catch (Exception e) {
        AHInitServlet.sqlSessionFactory.openSession(false).rollback();
        out.println("<p>등록 실패입니다!</p>");
        e.printStackTrace();
      }
      out.println("</body>");
      out.println("</html>");

    } catch (Exception e) {
      throw new ServletException(e);
    }
  }
}

