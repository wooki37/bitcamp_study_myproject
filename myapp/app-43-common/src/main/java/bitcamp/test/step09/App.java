package bitcamp.test.step09;

import java.net.Socket;

// 9) 객체 생성이 번거롭고 복잡한 경우 메서드로 분리하는 것이 낫다. (디자인패턴; 팩토리 메서드)
public class App {

  static class Score {
    String name;
    int kor;
    int eng;
    int math;
    int sum;
    float aver;

    void compute() {
      this.sum = this.kor + this.eng + this.math;
      this.aver = this.sum / 3f;
    }
  }

  public static void main(String[] args) {

    final int MAX_SIZE = 10;
    Score[] scores = new Score[MAX_SIZE];
    int length = 0;

    scores[length++] = createScore("홍길동", 100, 100, 100);
    scores[length++] = createScore("임꺽정", 80, 95, 30);
    scores[length++] = createScore("유관순", 30, 100, 95);

    for (int i = 0; i < length; i++) {
      printScore(scores[i]);
    }
  }

  // 팩토리 메서드
  static Score createScore(String name, int kor, int eng, int math) {
    Score s = new Score();
    s.name = name;
    s.kor = kor;
    s.eng = eng;
    s.math = math;
    s.compute();
    return s;
  }

  static void printScore(Score s) {
    System.out.printf("%s: 합계= %d, 평균= %.1f\n", s.name, s.sum, s.aver);
  }
}