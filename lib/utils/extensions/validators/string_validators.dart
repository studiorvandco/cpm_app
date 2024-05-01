extension StringValidators on String {
  bool get validEmail {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get validPhone {
    return RegExp(
      r'^(?:[+0][1-9])?[0-9]{10,12}$',
    ).hasMatch(this);
  }

  bool get validUrl {
    return isNotEmpty && Uri.tryParse(this)!.isAbsolute;
  }
}
