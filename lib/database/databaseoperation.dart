import 'package:cloud_firestore/cloud_firestore.dart';

// Define a function to add data
Future<void> addContactUsRequest(
    String name, String phoneNumber, String companyName, String companyEmail) {
  return FirebaseFirestore.instance.collection('contactUsRequests').add({
    'name': name,
    'Phone Number': phoneNumber,
    'Company Name': companyName,
    'Company Email': companyEmail,
  });
}
