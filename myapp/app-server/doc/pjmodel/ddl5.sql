-- 보호자
DROP TABLE IF EXISTS protectors RESTRICT;

-- 동물환자
DROP TABLE IF EXISTS patients RESTRICT;

-- 동물환자유형
DROP TABLE IF EXISTS patient_category RESTRICT;

-- 동물환자첨부파일
DROP TABLE IF EXISTS patient_file RESTRICT;

-- 보호자
CREATE TABLE protectors (
  protector_no INTEGER      NOT NULL COMMENT '보호자ID', -- 보호자ID
  pt_name      VARCHAR(50)  NOT NULL COMMENT '보호자성명', -- 보호자성명
  pt_email     VARCHAR(40)  NOT NULL COMMENT '보호자이메일', -- 보호자이메일
  pt_phone     VARCHAR(255)  NOT NULL COMMENT '보호자전화', -- 보호자전화
  pt_address   VARCHAR(255) NOT NULL COMMENT '보호자주소', -- 보호자주소
  pt_postNo    VARCHAR(20)  NULL     COMMENT '우편번호', -- 우편번호
  created_date DATE         NOT NULL DEFAULT (current_date()) COMMENT '등록일', -- 등록일
  photo        VARCHAR(255) NULL     COMMENT '사진' -- 사진
)
COMMENT '보호자';

-- 보호자
ALTER TABLE protectors
  ADD CONSTRAINT PK_protectors -- 보호자 기본키
  PRIMARY KEY (
  protector_no -- 보호자ID
  );

ALTER TABLE protectors
  MODIFY COLUMN protector_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '보호자ID';

-- 동물환자
CREATE TABLE patients (
  patient_no INTEGER      NOT NULL COMMENT '동물ID', -- 동물ID
  protector_no INTEGER      NOT NULL COMMENT '보호자ID', -- 보호자ID
  name   VARCHAR(50)  NOT NULL COMMENT '동물이름', -- 동물이름
  breeds     VARCHAR(50)  NOT NULL COMMENT '품종', -- 품종
  age        INTEGER      NOT NULL COMMENT '나이', -- 나이
  gender      CHAR(1)      NOT NULL COMMENT '성별', -- 성별
  created_date DATE         NOT NULL DEFAULT (current_date()) COMMENT '등록일', -- 등록일
  category     INTEGER      NOT NULL COMMENT '환자유형' -- 환자유형
)
COMMENT '동물환자';

-- 동물환자
ALTER TABLE patients
  ADD CONSTRAINT PK_patients -- 동물 기본키
  PRIMARY KEY (
  patient_no -- 동물ID
  );

ALTER TABLE patients
  MODIFY COLUMN patient_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '동물환자ID';

 -- 환자사진첨부파일
 CREATE TABLE patient_file (
   patient_file_no INTEGER      NOT NULL COMMENT '번호', -- 번호
   filepath      VARCHAR(255) NOT NULL COMMENT '파일경로', -- 파일경로
   patient_no      INTEGER      NOT NULL COMMENT '환자사진번호' -- 환자사진번호
 )
 COMMENT '환자사진첨부파일';

 -- 환자사진첨부파일
 ALTER TABLE patient_file
   ADD CONSTRAINT PK_patient_file -- 게시글첨부파일 기본키
   PRIMARY KEY (
   patient_file_no -- 번호
   );

 ALTER TABLE patient_file
   MODIFY COLUMN patient_file_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 환자첨부파일
ALTER TABLE patient_file
  ADD CONSTRAINT FK_patients_TO_patient_file -- 게시글 -> 게시글첨부파일
  FOREIGN KEY (
  patient_no -- 환자번호
  )
  REFERENCES patients ( -- 동물환자
  patient_no -- 환자번호
  );

-- 환자유형
CREATE TABLE patient_category (
  patient_category_no INTEGER     NOT NULL COMMENT '번호', -- 번호
  name              VARCHAR(50) NOT NULL COMMENT '환자이름' -- 동물환자이름
)
COMMENT '동물환자유형';

-- 환자유형
ALTER TABLE patient_category
  ADD CONSTRAINT PK_patient_category -- 환자유형 기본키
  PRIMARY KEY (
  patient_category_no -- 번호
  );

-- 환자유형 유니크 인덱스
CREATE UNIQUE INDEX UIX_patient_category
  ON patient_category ( -- 환자유형
    name ASC -- 환자이름
  );

ALTER TABLE patient_category
  MODIFY COLUMN patient_category_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '번호';


