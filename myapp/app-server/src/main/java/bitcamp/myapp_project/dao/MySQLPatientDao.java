package bitcamp.myapp_project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bitcamp.myapp_project.vo.AHAttachedFile;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import bitcamp.myapp_project.vo.Patient;

public class MySQLPatientDao implements PatientDao {

  SqlSessionFactory sqlSessionFactory;

  public MySQLPatientDao(SqlSessionFactory sqlSessionFactory) {
    this.sqlSessionFactory = sqlSessionFactory;
  }

  @Override
  public void insert(Patient patient) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    sqlSession.insert("bitcamp.myapp_project.dao.PatientDao.insert", patient);
  }

  @Override
  public List<Patient> findAll(int category) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.selectList("bitcamp.myapp_project.dao.PatientDao.findAll", category);
  }

  @Override
  public Patient findBy(int category, int no) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);

    Map<String,Object> paramMap = new HashMap<>();
    paramMap.put("categoryNo", category);
    paramMap.put("patientNo", no);

    return sqlSession.selectOne("bitcamp.myapp_project.dao.PatientDao.findBy", paramMap);
  }

  @Override
  public int update(Patient patient) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.update("bitcamp.myapp_project.dao.PatientDao.update", patient);
  }

  @Override
  public int delete(Patient patient) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.delete("bitcamp.myapp_project.dao.PatientDao.delete", patient);
  }

  @Override
  public int insertFiles(Patient patient) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.insert("bitcamp.myapp_project.dao.PatientdDao.insertFiles", patient);
  }
  @Override
  public AHAttachedFile findFileBy(int no) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.selectOne("bitcamp.myapp_project.dao.patientDao.findFileBy", no);
  }
  @Override
  public int deleteFile(int no) {
    SqlSession sqlSession = sqlSessionFactory.openSession(false);
    return sqlSession.delete("bitcamp.myapp_project.dao.PatientDao.deleteFile", no);
  }
}
