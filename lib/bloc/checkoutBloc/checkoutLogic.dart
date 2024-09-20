import 'package:bloc/bloc.dart';
import '../../models/cart/cart.dart';
import 'checkoutState.dart';

class CheckOutLogic extends Cubit<CheckOutState> {
  CheckOutLogic() : super(InitCheckOut());

  int totalPrice = 0;

  int calculateTotal(List<Cart> checkout) {
    totalPrice = 0;
    for (int i=0; i<checkout.length; i++) {
      totalPrice += checkout[i].price * checkout[i].quantity;
    }
    return totalPrice;
  }
}

