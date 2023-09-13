import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:my_app/database/models/category_schema.dart';
import 'package:my_app/database/models/contactus_Schema.dart';

// Define a function to add data
Future<void> addContactUsRequest(ContactFormData contactFormData) {
  return FirebaseFirestore.instance
      .collection('contactUsRequests')
      .add(contactFormData.toJson());
}

Future<List<Category>> getCategories() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();

  final List<Category> categories = [];

  for (final QueryDocumentSnapshot<Map<String, dynamic>> document
      in querySnapshot.docs) {
    final String name = document.data()['name'] as String;
    final String imageUrl = document.data()['image'] as String;

    final Uint8List? imageBytes = await downloadImage(imageUrl);

    final category =
        Category(name: name, imageBytes: imageBytes ?? Uint8List(0));
    categories.add(category);
  }

  return categories;
}

Future<Uint8List?> downloadImage(String imageUrl) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Reference ref = storage.refFromURL(imageUrl);

  try {
    final FullMetadata metadata = await ref.getMetadata();
    final int? imageSize = metadata.size;

    if (imageSize == null) {
      return Uint8List(0);
    }

    final Uint8List? imageBytes = await ref.getData(imageSize);
    return imageBytes;
  } catch (e) {
    return Uint8List(0);
  }
}
