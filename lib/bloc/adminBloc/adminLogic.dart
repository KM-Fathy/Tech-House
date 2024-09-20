import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'adminState.dart';

class AdminLogic extends Cubit<AdminState> {
  AdminLogic() : super(InitAdmin());

  CollectionReference laptops =
      FirebaseFirestore.instance.collection('laptops');

  ImagePicker picker = ImagePicker();
  File? Image;

  String? url = null;

  Future<void> saveData(
    String model,
    int price,
    String description,
    String details,
    BuildContext context,
  ) async {
    if (url == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Upload Image")));
    } else {
      laptops.add({
        'model': model,
        'price': price,
        'description': description,
        'details': details,
        'image': url,
      }).then((value) {
        url = null;
        emit(SaveData());
        emit(SaveImage());
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        emit((ErrorAdmin()));
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Image = File(image.path);
      await uploadImage(File(image.path));
    } else {
      emit(ErrorAdmin());
    }
  }

  Future<void> uploadImage(File image) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('usersImages')
        .child('${DateTime.now()}.jpg');

    await ref.putFile(File(image.path));

    String? url;

    url = await ref.getDownloadURL();

    this.url = url;
  }
}
