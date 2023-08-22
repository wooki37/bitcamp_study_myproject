package bitcamp.myapp_project.util;

import java.lang.reflect.Array;

public class ArrayList<E> extends AbstractList<E> { // List로 넘김
  private static final int DEFAULT_SIZE = 3;

  private Object[] list = new Object[DEFAULT_SIZE]; // 제네릭은 배열에는 사용할 수 없다.

  @Override
  // 컴파일러에게 다음 메서드가 수퍼클래스의 메서드를 재정의한 것인지?
  // 또는 인터페이스의 메서드를 구현한 것인지?
  // 검사해달라는 표시다.
  public boolean add(E obj) {
    if (this.size == list.length) {
      increase();
    }
    this.list[this.size++] = obj;
    return true;
  }

  private void increase() {
    Object[] arr = new Object[list.length + (list.length >> 1)];
    for (int i = 0; i < list.length; i++) {
      arr[i] = list[i];
    }
    list = arr;
    // System.out.println("배열 확장: " + list.length);
  }

  @Override
  public Object[] toArray() {
    Object[] arr = new Object[this.size];
    for (int i = 0; i < this.size; i++) {
      arr[i] = this.list[i];
    }
    return arr;
  }

  @SuppressWarnings("unchecked")
  @Override
  public <T> T[] toArray(T[] arr) {
    T[] values = null;
    if (arr.length == this.size) {
      // 파라미터로 받은 배열이 목록의 개수 보다 작다면,
      // 새 배열을 만들어 저장한다.
      values = (T[]) Array.newInstance(arr.getClass().getComponentType(), this.size);
    } else {
      // 파라미터로 받은 배열이 목록에 저장된 개수와 같다면,
      // 파라미터로 받은 배열을 그대로 사용한다.
      values = arr;
    }
    // 디자인 패턴 : 팩토리 메서드 패턴
    // 배열을 항목으로 받아야 한다!
    // T[] values = (T[]) Array.newInstance(arr.getClass().getComponentType(),
    // this.length);

    for (int i = 0; i < this.size; i++) {
      values[i] = (T) list[i];
    }
    return values;
  }

  @SuppressWarnings("unchecked") // 검사하지 않았다는 에러 띄우지 마!
  @Override
  public E get(int index) {
    if (!isValid(index)) {
      return null;
    }
    return (E) this.list[index];
  }

  @Override
  public boolean remove(E obj) {
    int deletedIndex = indexOf(obj);
    if (deletedIndex == -1) {
      return false;
    }

    for (int i = deletedIndex; i < this.size - 1; i++) {
      this.list[i] = this.list[i + 1];
    }
    this.list[--this.size] = null;
    return true;
  }

  @SuppressWarnings("unchecked")
  @Override
  public E remove(int index) {
    if (!isValid(index)) {
      return null;
    }

    Object old = this.list[index];

    for (int i = index; i < this.size - 1; i++) {
      this.list[i] = this.list[i + 1];
    }
    this.list[--this.size] = null;

    return (E) old;
  }

  private int indexOf(E obj) {
    for (int i = 0; i < this.size; i++) {
      Object item = this.list[i];
      if (item.equals(obj)) {
        return i;
      }
    }
    return -1;
  }
}
