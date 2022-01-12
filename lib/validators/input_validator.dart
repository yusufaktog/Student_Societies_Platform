class InputValidator {
  static isValidStudentId(String studentId) {
    bool flag = true;
    if (studentId.length != 9) {
      flag = false;
    }

    if (studentId.startsWith('-')) {
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
