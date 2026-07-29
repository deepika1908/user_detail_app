import 'package:flutter/material.dart';
import 'otp_verification_page.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(
      String hint, IconData icon,
      {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),

                Center(
                  child: Icon(
                    Icons.person_add_alt_1,
                    size: 90,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    languageProvider.text("create_account"),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    languageProvider.text("fill_details"),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "First Name",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: firstNameController,
                  decoration: inputDecoration(
                    languageProvider.text("enter_first_name"),
                    Icons.person,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return languageProvider.text("first_name_required");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  languageProvider.text("last_name"),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: lastNameController,
                  decoration: inputDecoration(
                    languageProvider.text("enter_last_name"),
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return languageProvider.text("last_name_required");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  languageProvider.text("phone_number"),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: inputDecoration(
                    languageProvider.text("enter_phone_number"),
                    Icons.phone,
                  ).copyWith(counterText: ""),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.text("phone_number_required");
                    }

                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return languageProvider.text("valid_phone");
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  languageProvider.text("email"),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration(
                    languageProvider.text("example_email"),
                    Icons.email_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.text("email_required");
                    }

                    if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                    ).hasMatch(value)) {
                      return languageProvider.text("enter_valid_gmail");
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  languageProvider.text("date_of_birth"),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  onTap: selectDate,
                  decoration: inputDecoration(
                    languageProvider.text("select_dob"),
                    Icons.calendar_today_outlined,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.text("dob_required");
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                OtpVerificationPage(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  dob: dobController.text,
                                ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(languageProvider.text("already_have_account")),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(languageProvider.text("login")),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}