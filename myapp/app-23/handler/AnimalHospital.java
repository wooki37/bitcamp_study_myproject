package bitcamp.myapp_project.handler;

import bitcamp.myapp_project.vo.Member;
import bitcamp.util.List;
import bitcamp.util.BreadcrumbPrompt;
import bitcamp.util.Prompt;

public class AnimalHospital implements Handler {

  // 범용으로 만들어진 ArrayList
  private List list;
  private BreadcrumbPrompt prompt;
  private String title;

  public AnimalHospital(BreadcrumbPrompt prompt, String title, List list) {
    this.prompt = prompt;
    this.title = title;
    this.list = list;
  }

  // Handler 인터페이스에 선언된 대로 정의했다.
  // => "Handler 인터페이스를 구현했다." 라고 표현한다.
  public void execute() {
    prompt.appendBreadcrumb(this.title, getMenu());
    prompt.printMenu();

    while (true) {
      String menuNo = prompt.inputMenu();
      switch (menuNo) {
        case "0":
          prompt.removeBreadcrumb();
          return;
        case "1":
          this.inputMember();
          break;
        case "2":
          this.printMembers();
          break;
        case "3":
          this.viewMember();
          break;
        case "4":
          this.updateMember();
          break;
        case "5":
          this.deleteMember();
          break;
      }
    }
  }

  private static String getMenu() {
    StringBuilder menu = new StringBuilder();
    menu.append("1. 등록\n");
    menu.append("2. 목록\n");
    menu.append("3. 조회\n");
    menu.append("4. 변경\n");
    menu.append("5. 삭제\n");
    menu.append("0. 메인\n");
    return menu.toString();
  }

  private void inputMember() {
    Member m = new Member();
    m.setNo(Integer.parseInt(this.prompt.inputString("보호자ID? ")));
    m.setNo(Integer.parseInt(this.prompt.inputString("환자ID? ")));
    m.setName(this.prompt.inputString("환자명? "));
    m.setBreeds(getMemberBreed());
    m.setAge(Integer.parseInt(this.prompt.inputString("나이? ")));
    m.setAddress(this.prompt.inputString("주소? "));
    m.setPhone(Integer.parseInt(this.prompt.inputString("연락처?(010) ")));
    m.setGender(inputGender((char) 0));

    this.list.add(m);
  }

  private String getMemberBreed() {
    boolean isValidNum = true; // 입력된 번호가 유효한지 여부
    String num = null;
    String breedType = null;
    while (isValidNum) {

      num = this.prompt.inputString("품종? 1. 강아지, 2.고양이. 3.직접입력").trim(); // trim() : 입력된 문자열의 양쪽 공백
                                                                         // 제거
      if ("1".equals(num)) {
        breedType = "강아지";
        isValidNum = false;
      } else if ("2".equals(num)) {
        breedType = "고양이";
        isValidNum = false;
      } else if ("3".equals(num)) {
        breedType = this.prompt.inputString("품종 타입을 직접 입력해주세요 > ");
        isValidNum = false;
      } else { // isValidNum 변수는 여전히 true이므로 루프가 반복됩니다.
        System.out.println("입력에 없는 번호입니다. 다시 입력해주세요");
      }
    }
    return breedType;
  }

  private void printMembers() {
    System.out.println("-----------------------------------------------------------------------");
    System.out.println("보호자ID/환자ID/  환자명/ 품종/ 나이/ 주소/ 연락처/ 성별");
    System.out.println("-----------------------------------------------------------------------");

    for (int i = 0; i < this.list.size(); i++) {
      Member m = (Member) this.list.get(i);
      System.out.printf("%d/,    %d/,%s/,  %s/,  %d/, %s/,(010)%d/, %s\n", m.getNo(), m.getNo(),
          m.getName(), m.getBreeds(), m.getAge(), m.getAddress(), m.getPhone(),
          toGenderString(m.getGender()));
    }
  }

  private void viewMember() {
    int memberNo = this.prompt.inputInt("번호? ");

    Member m = this.findBy(memberNo);
    if (m == null) {
      System.out.println("해당 번호의 환자가 없습니다!");
      return;
    }
    System.out.printf("보호자ID: %d\n", m.getNo());
    System.out.printf("환자ID: %d\n", m.getNo());
    System.out.printf("환자명: %s\n", m.getName());
    System.out.printf("품종: %s\n", m.getBreeds());
    System.out.printf("나이: %d\n", m.getAge());
    System.out.printf("주소: %s\n", m.getAddress());
    System.out.printf("연락처: %d\n", m.getPhone());
    System.out.printf("성별: %s\n", toGenderString(m.getGender()));
  }

  private static String toGenderString(char gender) {
    return gender == 'M' ? "수컷" : "암컷";
  }

  private void updateMember() {
    int memberNo = this.prompt.inputInt("보호자ID 번호? ");

    Member m = this.findBy(memberNo);
    if (m == null) {
      System.out.println("해당 번호의 ID가 없습니다.");
      return;
    }
    m.setNo(this.prompt.inputInt("환자ID(%d)? ", m.getNo()));
    m.setName(this.prompt.inputString("환자명(%s)? ", m.getName()));
    m.setBreeds(this.prompt.inputString("품종(%s)? ", m.getBreeds()));
    m.setAge(this.prompt.inputInt("나이(%d)? ", m.getAge()));
    m.setAddress(this.prompt.inputString("주소(%s)? ", m.getAddress()));
    m.setPhone(this.prompt.inputInt("연락처(%d)? ", m.getPhone()));
    m.setGender(inputGender(m.getGender()));
  }

  private char inputGender(char gender) {
    String label;
    if (gender == 0) {
      label = "성별?\n";
    } else {
      label = String.format("성별(%s)?\n", toGenderString(gender));
    }
    while (true) {
      String menuNo = this.prompt.inputString(label + " 1. 수컷\n" + " 2. 암컷\n" + "> ");

      switch (menuNo) {
        case "1":
          return Member.MALE;
        case "2":
          return Member.FEMALE;
        default:
          System.out.println("무효한 번호입니다.");
      }
    }
  }

  private void deleteMember() {
    if (!this.list.remove(new Member(this.prompt.inputInt("번호? ")))) {
      System.out.println("해당 번호가 존재하지 않습니다.");
    }
  }

  private Member findBy(int no) {
    for (int i = 0; i < this.list.size(); i++) {
      Member m = (Member) this.list.get(i);
      if (m.getNo() == no) {
        return m;
      }
    }
    return null;
  }
}
