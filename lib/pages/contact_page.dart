import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_app/pages/confirmation_message_page.dart';

import '../database/databaseoperation.dart';

// Define a Contact Us Form widget.
class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Name should contain only letters (a-z or A-Z)';
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
                    border: const OutlineInputBorder(),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }

                    value = '+91$value';
                    // Check if the value follows the Indian phone number format
                    if (!RegExp(r'^\+91[1-9]\d{9}$').hasMatch(value)) {
                      return 'Invalid Indian phone number';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.business,
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
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: companyEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter company email address';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
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
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromHeight(50)),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      submitForm(
                          nameController.text,
                          phoneNumberController.text,
                          companyNameController.text,
                          companyEmailController.text);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitForm(String name, String phoneNumber, String companyName,
      String companyEmail) {
    addContactUsRequest(name, phoneNumber, companyName, companyEmail).then((_) {
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
