import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/database/models/category_schema.dart';
import 'package:my_app/database/models/contactus_Schema.dart';
import 'package:my_app/database/models/storedesign_schema.dart';

// Define a function to add "Contact Request" data
Future<bool> addContactUsRequest(ContactFormData contactFormData) async {
  try {
    await FirebaseFirestore.instance
        .collection('contactUsRequests')
        .add(contactFormData.toJson());
    return true; // Return true on success.
  } catch (e) {
    // Handle any exceptions that occur during Firestore operation.
    return false; // Return false on error.
  }
}

// Define a function to get categories
Future<List<Category>> getCategories() async {
  try {
    final List<Category> categories = [];
    // Reference to the Firestore collection "Categories"
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      Map<String, dynamic> data = document.data();
      final String name = data['Name'] as String;
      final String imageLocation = data['Image'] as String;

      // Decode the category image from Firebase Storage
      final String imageURL = await _getImageURL(imageLocation);

      // Create a Category object and add it to the list
      final category = Category(name: name, image: imageURL);

      categories.add(category);
    }
    return categories;
  } catch (error) {
    // Handle any exceptions that occur during Firestore operation.
    // If an error occurs, return an empty list.
    return [];
  }
}

// Define a function to get Store Designs
Future<List<StoreDesign>> getStoreDesigns() async {
  try {
    final List<StoreDesign> storeDesigns = [];
    // Reference to the Firestore collection "Store Design"
    final QuerySnapshot<Map<String, dynamic>> storeDesignCollectionSnapshot =
        await FirebaseFirestore.instance.collection('storeDesign').get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> document
        in storeDesignCollectionSnapshot.docs) {
      Map<String, dynamic> data = document.data();
      List<String> galleryImagesLocation = List<String>.from(data['Gallery']);

      // Decode the main design image from Firebase Storage
      String mainDesignImage = await _getImageURL(data['Main Design Image']);

      // Decode the gallery images from Firebase Storage
      List<String> galleryImages = [];
      for (String imageLocation in galleryImagesLocation) {
        String imageURL = await _getImageURL(imageLocation);
        galleryImages.add(imageURL);
      }

      // Create a StoreDesign object and add it to the list
      StoreDesign storeDesign = StoreDesign(
        mainDesignImage: mainDesignImage,
        gallery: galleryImages,
        category: data['Category'],
        description: data['Description'],
        width: data['Width'],
        height: data['Height'],
      );

      storeDesigns.add(storeDesign);
    }
    return storeDesigns;
  } catch (error) {
    // error handling here if needed
    return [];
  }
}

// Define a function to get Image URL from Firebase Storage
Future<String> _getImageURL(String imageLocation) async {
  try {
    // Decode the image from Firebase Storage
    String imageURL = await FirebaseStorage.instance
        .refFromURL(imageLocation)
        .getDownloadURL();
    return imageURL;
  } catch (error) {
    return ''; // Return an empty string or a default URL in case of an error
  }
}
