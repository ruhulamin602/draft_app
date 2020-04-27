

class ValidatorMixin {
  String emailValidator(String value) {
    if (!value.contains('@')) {
      return 'Enter valid Email';
    }
    return null;
  }

  String passwordValidator(String value){
    if (value.length<4){
      return 'Enter valid Password';
    }
    return null;
  }
}
