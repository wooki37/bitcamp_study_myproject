package bitcamp.myapp_project.dao;

import java.util.List;
import bitcamp.myapp_project.vo.AHAttachedFile;
import bitcamp.myapp_project.vo.Patient;

public interface PatientDao {
  void insert(Patient patient);
  List<Patient> findAll(int category);
  Patient findBy(int category, int no);
  int update(Patient patient);
  int delete(Patient patient);

  int insertFiles(Patient patient);
  AHAttachedFile findFileBy(int no);
  int deleteFile(int fileNo);
  int deleteFiles(int patientNo);
}
