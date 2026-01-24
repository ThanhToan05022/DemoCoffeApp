class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Email không hợp lệ";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập mật khẩu";
    }
    if (value.length < 6) {
      return "Mật khẩu phải có ít nhất 6 ký tự";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Mật khẩu phải có ít nhất 1 số";
    }
    return null;
  }
}

class NameValidator {
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Vui lòng nhập tên của bạn";
    }

    if (value.trim().length < 2) {
      return "Tên phải có ít nhất 2 ký tự";
    }

    // // Kiểm tra ký tự đặc biệt hoặc số
    // if (!RegExp(r"^[a-zA-ZÀ-ỹ\s]+$").hasMatch(value.trim())) {
    //   return "Tên không được chứa số hoặc ký tự đặc biệt";
    // }

    return null; // ✅ Hợp lệ
  }
}
