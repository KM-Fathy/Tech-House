import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/adminBloc/adminLogic.dart';
import '../bloc/adminBloc/adminState.dart';
import '../components/customField.dart';
import 'homePage.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLogic(),
      child: BlocConsumer<AdminLogic, AdminState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController modelc = new TextEditingController();
          TextEditingController pricec = new TextEditingController();
          TextEditingController descriptionc = new TextEditingController();
          TextEditingController detailsc = new TextEditingController();
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          AdminLogic obj = BlocProvider.of(context);
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
              centerTitle: true,
              title: const Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff121418),
            ),
            backgroundColor: const Color(0xff181a20),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomField(modelc, "Model", (value) {
                        if (value!.isEmpty) return "Model must be not empty";
                      }, false, null),
                      CustomField(pricec, "Price", (value) {
                        if (value!.isEmpty) return "Price must be not empty";
                      }, false, null),
                      CustomField(descriptionc, "Description", (value) {
                        if (value!.isEmpty) {
                          return "Description must be not empty";
                        }
                      }, false, null),
                      CustomField(detailsc, "Details", (value) {
                        if (value!.isEmpty) return "Details must be not empty";
                      }, false, null),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff48bde9),
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: ()  {
                            obj.pickImage();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 78, right: 78, top: 14, bottom: 14),
                            child: Text(
                              'Upload Image',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff48bde9),
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await obj.saveData(
                                  modelc.text,
                                  int.parse(pricec.text),
                                  descriptionc.text,
                                  detailsc.text,
                                  context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 97, right: 97, top: 14, bottom: 14),
                            child: Text(
                              'Save data',
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
            ),
          );
        },
      ),
    );
  }
}
