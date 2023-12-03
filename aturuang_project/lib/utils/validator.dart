class Validator {
  static String? validateUsername({required String? username}) {
    if (username == null) {
      return null;
    }

    RegExp noSpasiRegExp = RegExp(r'^[^\s]+$');
    RegExp noKapitalRegExp = RegExp(r'[A-Z]');

    if (username.isEmpty) {
      return 'Username tidak boleh kosong';
    } else if (username.length < 8) {
      return 'Username kurang dari 8 karakter';
    } else if (noKapitalRegExp.hasMatch(username)) {
      return 'Username tidak boleh huruf kapital';
    } else if (!noSpasiRegExp.hasMatch(username)) {
      return 'Username tidak boleh ada spasi';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*(?:\.co(?:m)?)$");

    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Masukkan Email yang sesuai';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    RegExp kapitalRegExp = RegExp(r'[A-Z]');

    if (password.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (password.length < 8) {
      return 'Password kurang dari 8 karakter';
    } else if (!kapitalRegExp.hasMatch(password)) {
      return 'Password harus mengandung huruf kapital';
    }

    return null;
  }

  static String? isNotEmptyValidate({required String? value}) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    return null;
  }
}
