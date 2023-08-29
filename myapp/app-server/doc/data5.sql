
-- patients 테이블 예제 데이터
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(1, 1, '하루', '고양이', 3, 'M', 1);
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(2, 2, '하돌', '고양이', 4, 'W', 1);
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(3, 3, '초코', '사자', 7, 'M', 1);
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(4, 4, '여름', '팬더', 1, 'W', 1);
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(5, 5, '개똥이', '강아지', 10, 'W', 1);
insert into patients(patient_no, protector_no, name, breeds, age, gender, category)
  values(6, 6, '앵무', '조류', 12, 'M', 1);


  -- protectors 테이블 예제 데이터
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(1, '해바라기', 'aaa@aaa.com', sha1(11111111), '서울시 동작구', 111222);
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(2, '장미', 'bbb@bbb.com', sha1(22222222), '서울시 동작구', 222333);
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(3, '국화', 'ccc@ccc.com', sha1(33333333), '서울시 강남구', 333444);
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(4, '벚꽃', 'ddd@ddd.com', sha1(44444444), '서울시 중랑구', 444555);
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(5, '튤립', 'eee@eee.com', sha1(55555555), '서울시 양천구', 555666);
  insert into protectors(protector_no, pt_name, pt_email, pt_phone, pt_address, pt_postNo)
    values(6, '진달래', 'fff@fff.com', sha1(66666666), '서울시 강서구', 666777);

  


  
  
  
  
  
  
  