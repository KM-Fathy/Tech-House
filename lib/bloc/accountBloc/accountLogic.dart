import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/adminPage.dart';
import '../../pages/homePage.dart';
import 'accountState.dart';

class AccountLogic extends Cubit<AccountState> {
  AccountLogic() : super(InitAccount());

  Future<void> login(
    GlobalKey<FormState> formKey,
    BuildContext context,
    String email,
    String password,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            if (email == "admin@gmail.com" && password == "admin123") {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (c) {
                return AdminPage();
              }));
            } else {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (c) {
                return HomePage();
              }));
            }
          }
          emit(LoginAccount());
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(ErrorAccount());
      }
    }
  }

  Future<void> register(
    GlobalKey<FormState> formKey,
    BuildContext context,
    String name,
    String email,
    String password,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            saveUserData(name, email, password, value.user!.uid, context).then((value) {
              if (email == "admin@gmail.com" &&
                  password == "admin123" &&
                  name == "Admin") {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (c) {
                  return AdminPage();
                }));
              } else {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (c) {
                  return HomePage();
                }));
              }
            });
            emit(SaveAccount());
          }
          emit(RegisterAccount());
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        emit(ErrorAccount());
      }
    }
  }

  Future<void> saveUserData(
    String name,
    String email,
    String password,
    String uid,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'email': email,
          'password': password,
          'name': name,
          'uid': uid,
          'address': '',
        },
      );
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      emit(ErrorAccount());
    }
  }
}
