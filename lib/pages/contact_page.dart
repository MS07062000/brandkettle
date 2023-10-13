import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_app/database/models/contactus_Schema.dart';
import 'package:my_app/pages/confirmation_message_page.dart';
import 'package:my_app/pages/home_page.dart';

import '../database/databaseoperation.dart';

// Define a Contact Us Form widget.
class ContactUsForm extends StatefulWidget {
  final bool submissionSuccessful;
  const ContactUsForm({super.key, required this.submissionSuccessful});

  @override
  ContactUsFormState createState() {
    return ContactUsFormState();
  }
}

class ContactUsFormState extends State<ContactUsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyEmailController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'IND');
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.submissionSuccessful) {
          // Navigate to the home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          return false; // Prevent normal back navigation
        } else {
          // Allow normal back navigation
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              widget.submissionSuccessful
                  ? Navigator.of(context).pop()
                  : Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false);
            },
          ),
          title: const Text('Contact Us'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Colors.black, // Initial text color
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Return null if the input is valid
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      counterText: "",
                      labelStyle: const TextStyle(
                        color: Colors.black, // Initial text color
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/icons8-india-flag-48.png',
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                          const Text(
                            '+91',
                            style: TextStyle(
                              fontSize: 16.0, // Set the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: phoneNumberController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter a phone number';
                    //   }

                    //   value = '+91$value';
                    //   // Check if the value follows the Indian phone number format
                    //   if (!RegExp(r'^\+91[1-9]\d{9}$').hasMatch(value)) {
                    //     return 'Invalid Indian phone number';
                    //   }

                    //   return null;
                    // },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      labelStyle: TextStyle(
                        color: Colors.black, // Initial text color
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.business,
                        color: Colors.black,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: companyNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter company name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Company Email',
                      labelStyle: TextStyle(
                        color: Colors.black, // Initial text color
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    controller: companyEmailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter company email address';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid company email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      fixedSize:
                          MaterialStateProperty.all(const Size.fromHeight(50)),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        submitForm(ContactFormData(
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text,
                            companyName: companyNameController.text,
                            companyEmail: companyEmailController.text));
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm(ContactFormData contactFormData) {
    addContactUsRequest(contactFormData).then((_) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const ConfirmationMessage(success: true)),
          (Route<dynamic> route) => false);
    }).catchError((error) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const ConfirmationMessage(success: false)),
          (Route<dynamic> route) => false);
    });
  }
}
