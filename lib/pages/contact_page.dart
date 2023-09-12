import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  final TextEditingController emailController = TextEditingController();
  String? category;
  String? designer;
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
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  hint: const Text('Select a Category'),
                  value: category,
                  validator: (value) =>
                      value == null ? "Select a Category" : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  hint: const Text('Select a Designer'),
                  value: designer,
                  validator: (value) =>
                      value == null ? "Select a Designer" : null,
                  onChanged: (String? newValue) {
                    setState(() {
                      designer = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Designer',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
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
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
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
}
