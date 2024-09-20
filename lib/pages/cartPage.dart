import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cartBloc/cartLogic.dart';
import '../bloc/cartBloc/cartState.dart';
import 'checkoutPage.dart';
import 'homePage.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartLogic()..getCartItems(),
      child: BlocConsumer<CartLogic, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          CartLogic obj = BlocProvider.of(context);
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
                "Cart",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff121418),
              centerTitle: true,
            ),
            backgroundColor: const Color(0xff181a20),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: obj.cartitems.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: Card(
                            color: const Color(0xff242832),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      obj.cartitems[i].image,
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
                                          obj.cartitems[i].description,
                                          style: const TextStyle(
                                            color: Color(0xffDEDEDE),
                                            fontSize: 20,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "EGP ${obj.cartitems[i].price}",
                                          style: const TextStyle(
                                            color: Color(0xff878787),
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xffF65252),
                                                alignment: Alignment.center,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15))),
                                            onPressed: () {
                                              obj.removeItemFromCart(i);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25,
                                                  right: 25,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xffffffff),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                    const Color(0xff48bde9),
                                                    alignment: Alignment.center,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(15))),
                                                onPressed: () {
                                                  obj.incQuantity(i);
                                                },
                                                child: const Icon(CupertinoIcons.plus, color: Colors.white,),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                child: Text("${obj.cartitems[i].quantity}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
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
                                                  obj.decQuantity(i);
                                                },
                                                child: const Icon(CupertinoIcons.minus, color: Colors.white,),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff48bde9),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                        return CheckoutPage(obj.cartitems);
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 97, right: 97, top: 14, bottom: 14),
                      child: Text(
                        'Check Out',
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
          );
        },
      ),
    );
  }
}
