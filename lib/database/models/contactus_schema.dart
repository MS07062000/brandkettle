class ContactFormData {
  final String name;
  final String phoneNumber;
  final String companyName;
  final String companyEmail;

  ContactFormData({
    required this.name,
    required this.phoneNumber,
    required this.companyName,
    required this.companyEmail,
  });

  // Method to convert ContactUsSchema to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'companyName': companyName,
      'companyEmail': companyEmail,
    };
  }
}
