import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techhouse/pages/registerPage.dart';
import '../bloc/accountBloc/accountLogic.dart';
import '../bloc/accountBloc/accountState.dart';
import '../components/customField.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountLogic(),
      child: BlocConsumer<AccountLogic, AccountState>(
          listener: (context, state) {},
          builder: (context, state) {
            TextEditingController emailc = new TextEditingController();
            TextEditingController passwordc = new TextEditingController();
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
                        padding: EdgeInsets.only(top: 140),
                        child: Text(
                          "Hey there,",
                          style: TextStyle(
                              color: Color(0xffA6A6A6),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Text(
                          "Please sign in to your account",
                          style: TextStyle(
                              color: Color(0xffA6A6A6),
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                      ),
                      CustomField(emailc, "Email", (value) {
                        if (value!.isEmpty) return "Email must be no empty";
                      }, false, 1),
                      CustomField(passwordc, "Password", (value) {
                        if (value!.isEmpty) {
                          return "Password must be no empty";
                        } else if (value.length < 6)
                          return "Password must be at least 6 characters";
                      }, true, 1),
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff48bde9),
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () async {
                            await obj.login(
                                formKey, context, emailc.text, passwordc.text);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 112, right: 112, top: 14, bottom: 14),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account?",
                            style: TextStyle(
                                color: Color(0xffA6A6A6),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (c) {
                                  return RegisterPage();
                                }));
                              },
                              child: const Text(
                                "Register Now",
                                style: TextStyle(
                                    color: Color(0xff48bde9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                        ],
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
