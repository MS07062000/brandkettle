import 'package:cloud_firestore/cloud_firestore.dart';
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

      // Create a StoreDesign object and add it to the list
      StoreDesign storeDesign = StoreDesign(
        mainDesignImage: data['Main Design Image'], //mainDesignImage,
        gallery: galleryImagesLocation, //data['Gallery'],
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

/*
This particular was defined inside for loop of getStoreDesigns
//Decode the main design image from Firebase Storage
// String mainDesignImage = await _getImageURL(data['Main Design Image']);
// Decode the gallery images from Firebase Storage
// List<String> galleryImages = [];
// for (String imageLocation in galleryImagesLocation) {
//   String imageURL = await _getImageURL(imageLocation);
//   galleryImages.add(imageURL);
// }
*/
//-----------------------------------------------------------------------------
// Define a function to get categories
// Future<List<Category>> getCategories() async {
//   try {
//     final List<Category> categories = [];
//     // Reference to the Firestore collection "Categories"
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance.collection('categories').get();

//     for (final QueryDocumentSnapshot<Map<String, dynamic>> document
//         in querySnapshot.docs) {
//       Map<String, dynamic> data = document.data();
//       final String name = data['Name'] as String;
//       final String imageLocation = data['Image'] as String;

//       // Decode the category image from Firebase Storage
//       final String imageURL = await _getImageURL(imageLocation);

//       // Create a Category object and add it to the list
//       final category = Category(name: name, image: imageURL);

//       categories.add(category);
//     }
//     return categories;
//   } catch (error) {
//     // Handle any exceptions that occur during Firestore operation.
//     // If an error occurs, return an empty list.
//     return [];
//   }
// }

//Define a function to get Image URL from Firebase Storage
// Future<String> _getImageURL(String imageLocation) async {
//   try {
//     // Decode the image from Firebase Storage
//     String imageURL = await FirebaseStorage.instance
//         .refFromURL(imageLocation)
//         .getDownloadURL();

//     log("imageUrl");
//     log(imageURL);
//     return imageURL;
//   } catch (error) {
//     return ''; // Return an empty string or a default URL in case of an error
//   }
// }

// Future<void> uploadStoreDesign() async {
//   // Initialize Firebase (you should have already set up Firebase in your app)
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   // Create an array of documents with the specified fields
//   List<Map<String, dynamic>> storeDesignArray = [
//     {
//       'Category': 'Jewellery',
//       'Description':
//           'Generating random paragraphs can be an excellent way for writers to get their creative flow going at the beginning of the day. The writer has no idea what topic the random paragraph will be about when it appears. This forces the writer to use creativity to complete one of three common writing challenges. The writer can use the paragraph as the first one of a short story and build upon it. A second option is to use the random paragraph somewhere in a short story they create. The third option is to have the random paragraph be the ending paragraph in a short story. No matter which of these challenges is undertaken, the writer is forced to use creativity to incorporate the paragraph into their writing.',
//       'Gallery': ['ImageUrl', 'ImageUrl', 'ImageUrl'],
//       'Height': 1,
//       'Main Design Image': 'ImageUrl',
//       'Width': 1,
//     },
//   ];

//   // Upload the documents to the 'storeDesign' collection
//   for (int i = 0; i < storeDesignArray.length; i++) {
//     await firestore.collection('storeDesign').add(storeDesignArray[i]);
//   }
// }
