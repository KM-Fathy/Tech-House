import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techhouse/pages/profilePage.dart';
import '../bloc/homeBloc/homeLogic.dart';
import '../bloc/homeBloc/homeState.dart';
import '../components/customTile.dart';
import 'adminPage.dart';
import 'cartPage.dart';
import 'detailsPage.dart';
import 'loginPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLogic()..getLaptops(),
      child: BlocConsumer<HomeLogic, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              actions: (obj.user?.email != "admin@gmail.com")
                  ? null
                  : [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (c) {
                              return AdminPage();
                            }));
                          },
                          icon: const Icon(
                            Icons.admin_panel_settings,
                            color: Color(0xff48bde9),
                            size: 30,
                          )),
                    ],
              backgroundColor: const Color(0xff121418),
              title: const Text(
                "Tech House",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Color(0xff48bde9)),
            ),
            drawer: Drawer(
              backgroundColor: const Color(0xff181a20),
              child: Padding(
                padding: const EdgeInsets.only(),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color(0xff121418),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              height: 135,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Logo.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTile("Cart", CupertinoIcons.cart_fill, () {
                        if(obj.user?.email==null)
                        {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                backgroundColor: const Color(0xff121418),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (c) {
                                              return LoginPage();
                                            }));
                                      },
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(
                                            color: Color(0xff48bde9)),
                                      ))
                                ],
                                title: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Please login to your account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ));
                        }
                        else{
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (c) {
                            return CartPage();
                          }));
                        }
                      }),
                      CustomTile("Your Profile", Icons.person, () {
                        if(obj.user?.email==null)
                        {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                backgroundColor: const Color(0xff121418),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (c) {
                                              return LoginPage();
                                            }));
                                      },
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(
                                            color: Color(0xff48bde9)),
                                      ))
                                ],
                                title: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Please login to your account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ));
                        }
                        else{
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (c) {
                            return ProfilePage();
                          }));
                        }

                      }),
                      CustomTile("Logout", Icons.logout, () async {
                        if(obj.user?.email==null)
                        {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                backgroundColor: const Color(0xff121418),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (c) {
                                              return LoginPage();
                                            }));
                                      },
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(
                                            color: Color(0xff48bde9)),
                                      ))
                                ],
                                title: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  "Please login to your account",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ));
                        }
                        else{
                          await obj.logOut(context);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: const Color(0xff181a20),
            body: ListView.builder(
                itemCount: obj.laptops.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(1),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (c) {
                          return DetailsPage(l: obj.laptops[i]);
                        }));
                      },
                      child: Card(
                        color: const Color(0xff242832),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  obj.laptops[i].image,
                                  fit: BoxFit.fill,
                                  width: 160,
                                  height: 175,
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                width: 175,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      obj.laptops[i].model,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      obj.laptops[i].description,
                                      style: const TextStyle(
                                        color: Color(0xffDEDEDE),
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "EGP ${obj.laptops[i].price}",
                                      style: const TextStyle(
                                        color: Color(0xff878787),
                                        fontSize: 20,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff48bde9),
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      onPressed: () {
                                        if (obj.user?.email == null) {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                    backgroundColor:
                                                        const Color(0xff121418),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (c) {
                                                              return LoginPage();
                                                            }));
                                                          },
                                                          child: const Text(
                                                            "Ok",
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xff48bde9)),
                                                          ))
                                                    ],
                                                    title: const Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                    content: const Text(
                                                      "Please login to your account",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  ));
                                        } else {
                                          obj.addToCart(
                                              obj.laptops[i].price,
                                              obj.laptops[i].description,
                                              obj.laptops[i].image,
                                              context);
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          'Add to cart',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
