import 'dart:async';

import 'package:flutter/material.dart';

class Validators {
  // final pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    // if (RegExp(
    //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
    //     .hasMatch(email)) {
      sink.add(email);
    // } else {
    //   sink.addError("Enter Valid Email");
    // }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink) {
      // if (RegExp(r'^(?=.*?[a-z]).{0,}$').hasMatch(pass)) {
      //   if (RegExp(r'^(?=.*?[A-Z]).{0,}$').hasMatch(pass)) {
      //     if (RegExp(r'^(?=.*?[0-9]).{0,}$').hasMatch(pass)) {
      //       if (RegExp(r'^(?=.*?[!@#\$&*~]).{0,}$').hasMatch(pass)) {
              if (pass.length > 3) {
                sink.add(pass);
              } else {
                sink.addError('Enter  password at least 8 characters ');
              }
      //       } else {
      //         sink.addError('Enter at least one special character');
      //       }
      //     } else {
      //       sink.addError('Enter at least num,special character');
      //     }
      //   } else {
      //     sink.addError(
      //         'Enter at least Capital latter,number,special character');
      //   }
      // } else {
      //   sink.addError(
      //       'Enter at least one capital letter ,small letter ,number,special character');
      // }
    },
  );
}
