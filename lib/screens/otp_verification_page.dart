import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_page.dart ';
import '../providers/language_provider.dart';

class OtpVerificationPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dob;

  const OtpVerificationPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dob,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  // Dummy OTP
  final String savedOtp = "123456";
  void verifyOtp() {
  if (_formKey.currentState!.validate()) {
    if (otpController.text == savedOtp) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardPage(
            firstName: widget.firstName,
            lastName: widget.lastName,
            phone: widget.phone,
            email: widget.email,
            dob: widget.dob,
          ),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 30,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),

                const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.deepPurple,
                  size: 90,
                ),

                const SizedBox(height: 25),

                Text(
                  languageProvider.text("otp_verification"),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  languageProvider.text("enter_6_digit_otp"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: languageProvider.text("enter_otp"),
                    prefixIcon: const Icon(Icons.lock_outline),
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return languageProvider.text("otp_required");
                    }

                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return languageProvider.text("invalid_otp");
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

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
                    onPressed: verifyOtp,
                    child: Text(
                      languageProvider.text("verify_otp"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text(languageProvider.text("otp_resent_successfully")),
                      ),
                    );
                  },
                  child: Text(
                    languageProvider.text("resend_otp"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),


                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    languageProvider.text("demo_otp"),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
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
}

