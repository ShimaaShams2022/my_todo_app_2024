bool isValidEmail (String userEmail){
  return   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(userEmail);
}
bool isValidPassword(String password){
  if (password.length<6){
    return false;
  }
  return true;
}

bool isValidPhoneNumber(String phoneNumber){
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (phoneNumber.length == 0) {
    return false;
  }
  else if (!regExp.hasMatch(phoneNumber)) {
    return false;
  }
  return true;
}