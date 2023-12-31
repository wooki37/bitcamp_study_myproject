package bitcamp.myapp.handler;

import java.io.IOException;
import org.apache.ibatis.session.SqlSessionFactory;
import bitcamp.myapp.dao.MemberDao;
import bitcamp.util.ActionListener;
import bitcamp.util.BreadcrumbPrompt;
import bitcamp.util.Component;

@Component("/member/delete")
public class MemberDeleteListener implements ActionListener {

  MemberDao memberDao;
  SqlSessionFactory sqlSessionFactory;

  public MemberDeleteListener(MemberDao memberDao, SqlSessionFactory sqlSessionFactory) {
    this.memberDao = memberDao;
    this.sqlSessionFactory = sqlSessionFactory;
  }

  @Override
  public void service(BreadcrumbPrompt prompt) throws IOException {
    try {
      if (memberDao.delete(prompt.inputInt("번호? ")) == 0) {
        prompt.println("해당 번호의 회원이 없습니다!");
        return;
      }
      prompt.println("삭제했습니다!");
      sqlSessionFactory.openSession().commit();

    } catch (Exception e) {
      try {
        sqlSessionFactory.openSession().rollback();
      } catch (Exception e2) {
      }
      throw new RuntimeException(e);
    }
  }

}
