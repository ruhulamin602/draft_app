import 'dart:async';

import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final _password = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<List<String>> get submitValid =>
      Rx.combineLatest2(email, password,(e,p)=> [e,p] );

  Function(String) get changEmail => _email.sink.add;
  Function(String) get changedPassword => _password.sink.add;
  

  submit() {
    final vemail = _email.value;
    final vpassword = _password.value;
    print('$vemail $vpassword');
  }
  

  dispose() {
    _email.close();
    _password.close();
  }
}
