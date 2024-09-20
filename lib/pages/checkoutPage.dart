import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techhouse/bloc/homeBloc/homeLogic.dart';
import '../bloc/checkoutBloc/checkoutLogic.dart';
import '../bloc/checkoutBloc/checkoutState.dart';
import '../models/cart/cart.dart';
import 'cartPage.dart';
import 'homePage.dart';

class CheckoutPage extends StatelessWidget {
  List<Cart> checkout = [];

  CheckoutPage(this.checkout);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckOutLogic(),
      child: BlocConsumer<CheckOutLogic, CheckOutState>(
        listener: (context, state) {},
        builder: (context, state) {
          CheckOutLogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                      return CartPage();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Color(0xff48bde9),
                  )),
              title: const Text(
                "Checkout",
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
                      itemCount: checkout.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 14, right: 14),
                          child: Card(
                            color: const Color(0xff242832),
                            child: ListTile(
                              title: Text(
                                checkout[i].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                "${checkout[i].price}",
                                style: const TextStyle(
                                  color: Color(0xffBDBBBB),
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Text(
                                "${checkout[i].quantity}",
                                style: const TextStyle(
                                  color: Color(0xff878787),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 14, right: 14),
                      child: Card(
                        color: const Color(0xff242832),
                        child: ListTile(
                          title: const Text(
                            "Total Price",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(
                            "${obj.calculateTotal(checkout)}",
                            style: const TextStyle(
                              color: Color(0xff878787),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff48bde9),
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
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
                                            HomeLogic().deleteCartItemsFirebase();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (c) {
                                              return HomePage();
                                            }));
                                          },
                                          child: const Text(
                                            "Ok",
                                            style: TextStyle(
                                                color: Color(0xff48bde9)),
                                          ))
                                    ],
                                    title: const Text(
                                      "Success",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      "Payment successful",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 97, right: 97, top: 14, bottom: 14),
                          child: Text(
                            'Pay Now',
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
              ],
            ),
          );
        },
      ),
    );
  }
}
