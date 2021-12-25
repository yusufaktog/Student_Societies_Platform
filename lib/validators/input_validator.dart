class InputValidator {
  static isValidStudentId(String studentId) {
    bool flag = true;
    if (studentId.length != 9) {
      print("student id length must be exactly 9");
      flag = false;
    }

    if (studentId.startsWith('-')) {
      print("student id length most be positive!");

      flag = false;
    }

    try {
      int.parse(studentId);
    } catch (e) {
      flag = false;
    }

    return flag;
  }
}
