import 'package:flutter/material.dart';
import 'dashboard_page.dart ';

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

                const Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Enter the 6-digit OTP sent to your email",
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
                    hintText: "Enter OTP",
                    prefixIcon: const Icon(Icons.lock_outline),
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "OTP is required";
                    }

                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return "OTP must contain exactly 6 digits";
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
                    child: const Text(
                      "Verify OTP",
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
                      const SnackBar(
                        content: Text("OTP Resent Successfully"),
                      ),
                    );
                  },
                  child: const Text(
                    "Resend OTP",
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
                  child: const Text(
                    "Demo OTP: 123456",
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

