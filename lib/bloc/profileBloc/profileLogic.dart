import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techhouse/bloc/profileBloc/profileState.dart';
import '../../models/account/account.dart';



class ProfileLogic extends Cubit<ProfileState> {
  ProfileLogic() : super(InitProfile());

  List<Account> users = [];
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == user?.email) {
          users.add(Account(
              email: doc['email'],
              password: doc['password'],
              userName: doc['name'],
              address: doc['address']));
          emit(GetProfile());
        }
      });
    });
  }

  Future<void> updateUser(String address) async {
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update(
      {
        'address': address,
      },
    );
    for (int i = 0; i < users.length; i++) {
      if (users[i].email == user?.email) {
        users[i].address = address;
        break;
      }
    }
    emit(UpdateAddress());
  }
}

