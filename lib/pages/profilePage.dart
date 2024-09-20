import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profileBloc/profileLogic.dart';
import '../bloc/profileBloc/profileState.dart';
import '../components/customContainer.dart';
import '../components/customField.dart';
import 'homePage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileLogic()..getUser(),
      child: BlocConsumer<ProfileLogic, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController addressc = TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          ProfileLogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                      return HomePage();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Color(0xff48bde9),
                  )),
              title: const Text(
                "Profile",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff121418),
              centerTitle: true,
            ),
            backgroundColor: const Color(0xff181a20),
            body: ListView.builder(
              itemCount: obj.users.length,
              itemBuilder: (context, i) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          CustomContainer("Username", obj.users[i].userName),
                          CustomContainer("Email", obj.users[i].email),
                          CustomContainer("Password", obj.users[i].password),
                          CustomContainer("Address", obj.users[i].address),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: CustomField(addressc, "address", (value) {
                            if (value!.isEmpty) return "Address must be not empty";
                          }, false, null),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff48bde9),
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              obj.updateUser(addressc.text);
                            }

                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 67, right: 67, top: 14, bottom: 14),
                            child: Text(
                              'Change Address',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }
}
