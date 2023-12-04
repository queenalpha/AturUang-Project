class Validator {
  static String? validateUsername({required String? username}) {
    if (username == null) {
      return null;
    }

    RegExp noSpasiRegExp = RegExp(r'^[^\s]+$');
    RegExp noKapitalRegExp = RegExp(r'[A-Z]');

    if (username.isEmpty) {
      return 'Username cannot be empty';
    } else if (username.length < 8) {
      return 'Username less than 8 characters';
    } else if (noKapitalRegExp.hasMatch(username)) {
      return 'Username must be lowercase';
    } else if (!noSpasiRegExp.hasMatch(username)) {
      return 'Username cannot contain spaces';
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
      return 'Email cannot be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter the correct Email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    RegExp kapitalRegExp = RegExp(r'[A-Z]');

    if (password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 8) {
      return 'Password less than 8 characters';
    } else if (!kapitalRegExp.hasMatch(password)) {
      return 'Password must contain capital letters';
    }

    return null;
  }

  static String? isNotEmptyValidate({required String? value}) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Password cannot be empty';
    }

    return null;
  }
}
