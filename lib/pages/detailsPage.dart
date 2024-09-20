import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/detailsBloc/detailsLogic.dart';
import '../bloc/detailsBloc/detailsState.dart';
import '../models/laptop/laptop.dart';
import 'homePage.dart';

class DetailsPage extends StatelessWidget {
  Laptop l;

  DetailsPage({required this.l});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsLogic(),
      child: BlocConsumer<DetailsLogic, DetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff121418),
              title: Text(
                l.model,
                style: const TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
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
            ),
            backgroundColor: const Color(0xff181a20),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff242832),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l.description,
                          style: const TextStyle(
                            color: Color(0xffBDBBBB),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          l.image,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 300
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "EGP ${l.price}",
                          style: const TextStyle(
                            color: Color(0xffDEDEDE),
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xffDEDEDE),
                        indent: 7,
                        endIndent: 7,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Laptop Details",
                          style: TextStyle(
                            color: Color(0xffDEDEDE),
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xffDEDEDE),
                        indent: 7,
                        endIndent: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l.details,
                          style: const TextStyle(
                            color: Color(0xffBDBBBB),
                            fontSize: 21,
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
