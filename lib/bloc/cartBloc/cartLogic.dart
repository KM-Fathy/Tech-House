import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/cart/cart.dart';
import '../homeBloc/homeLogic.dart';
import 'cartState.dart';

class CartLogic extends Cubit<CartState> {
  CartLogic() : super(InitCart());

  List<Cart> cartitems = [];

  Future<void> getCartItems() async {
    await FirebaseFirestore.instance
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        cartitems.add(Cart(
          description: doc['description'],
          image: doc['image'],
          price: doc['price'],
          docId: doc.id,
          quantity: 1,
        ));
      });
    });
    emit(GetCartItem());
  }

  void incQuantity(int index) {
    cartitems[index].quantity++;
    emit(IncQuantaty());
  }

  void decQuantity(int index) {
    if (cartitems[index].quantity > 1) {
      cartitems[index].quantity--;
    }
    emit(DecQuantaty());
  }

  Future<void> deleteCartItem(String docId) {
    return HomeLogic()
        .cart
        .doc(docId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  void removeItemFromCart(int index) {
    String docId = cartitems[index].docId;
    deleteCartItem(docId);
    emit(RemoveState());
    cartitems.removeAt(index);
  }
}
