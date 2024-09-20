import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/laptop/laptop.dart';
import '../../pages/loginPage.dart';
import 'homeState.dart';

class HomeLogic extends Cubit<HomeState> {
  HomeLogic() : super(InitHome());

  User? user = FirebaseAuth.instance.currentUser;

  List<Laptop> laptops = [];

  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  Future<void> addToCart(
      int price, String description, String url, BuildContext context) async {
    QuerySnapshot querySnapshot =
        await cart.where('description', isEqualTo: description).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Item already in cart")));
      emit(ErrorState());
    } else {
      cart.add({
        'price': price,
        'description': description,
        'image': url,
      }).then((value) {
        print("Data Added");
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Item added to cart")));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  Future<void> getLaptops() async {
    await FirebaseFirestore.instance
        .collection('laptops')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        laptops.add(Laptop(
            details: doc['details'],
            description: doc['description'],
            image: doc['image'],
            price: doc['price'],
            model: doc['model']));
      });
    });
    emit(GetItem());
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        deleteCartItemsFirebase();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
          return LoginPage();
        }));
      });
      emit(LogoutHome());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> deleteCartItemsFirebase() async {
    var snapshots = await cart.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
