import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/accountBloc/accountLogic.dart';
import '../bloc/accountBloc/accountState.dart';
import '../components/customField.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountLogic(),
      child:
          BlocConsumer<AccountLogic, AccountState>(listener: (context, state) {
      }, builder: (context, state) {
        TextEditingController namec = new TextEditingController();
        TextEditingController emailc = new TextEditingController();
        TextEditingController passwordc = new TextEditingController();
        TextEditingController confirmPasswordc = new TextEditingController();
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        AccountLogic obj = BlocProvider.of(context);
        return Scaffold(
          backgroundColor: const Color(0xff181a20),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 110),
                    child: Text(
                      "Hey there,",
                      style: TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const Text(
                    "Create new account",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Text(
                      "Please fill in the form to continue",
                      style: TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                  ),
                  CustomField(namec, "Name", (value) {
                    if (value!.isEmpty) return "Name must be not empty";
                  }, false, 1),
                  CustomField(emailc, "Email", (value) {
                    if (value!.isEmpty) return "Email must be not empty";
                    if (value != value.toLowerCase()) return "Email must be in lowercase";
                  }, false, 1),
                  CustomField(passwordc, "Password", (value) {
                    if (value!.isEmpty) {
                      return "Password must be not empty";
                    } else if (value.length < 6)
                      return "Password must be at least 6 characters";
                  }, true, 1),
                  CustomField(confirmPasswordc, "Confirm Password", (value) {
                    if (value!.isEmpty) {
                      return "Confirm Password must be not empty";
                    } else if (value != passwordc.text)
                      return "Password not match";
                  }, true, 1),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff48bde9),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () async {
                        await obj.register(formKey, context, namec.text,
                            emailc.text, passwordc.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 101, right: 101, top: 14, bottom: 14),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
