import 'package:flutter/material.dart';
import 'otp_verification_page.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../core/theme/app_colors.dart';
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
    backgroundColor: AppColors.primary,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 25,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              _buildHeader(),

              const SizedBox(height: 20),

              _buildTitle(languageProvider),

              const SizedBox(height: 8),

              _buildSubtitle(languageProvider),

              const SizedBox(height: 35),

              _buildFirstNameField(languageProvider),

              const SizedBox(height: 20),

              _buildLastNameField(languageProvider),

              const SizedBox(height: 20),

              _buildPhoneField(languageProvider),

              const SizedBox(height: 20),

              _buildEmailField(languageProvider),

              const SizedBox(height: 20),

              _buildDobField(languageProvider),

              const SizedBox(height: 35),

              _buildRegisterButton(languageProvider),

              const SizedBox(height: 20),

              _buildLoginSection(languageProvider),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Center(
    child: Icon(
      Icons.person_add_alt_1,
      size: 90,
      color: AppColors.primary,
    ),
  );
}
Widget _buildTitle(LanguageProvider languageProvider) {
  return Center(
    child: Text(
      languageProvider.text("create_account"),
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSubtitle(LanguageProvider languageProvider) {
  return Center(
    child: Text(
      languageProvider.text("fill_details"),
      style: const TextStyle(
        color: AppColors.grey,
        fontSize: 16,
      ),
    ),
  );
}
Widget _buildFirstNameField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("first_name"),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
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
    ],
  );
}

Widget _buildLastNameField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("last_name"),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
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
    ],
  );
}

Widget _buildPhoneField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("phone_number"),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextFormField(
        controller: phoneController,
        decoration: inputDecoration(
          languageProvider.text("enter_phone_number"),
          Icons.phone,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text("phone_number_required");
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildEmailField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("email"),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextFormField(
        controller: emailController,
        decoration: inputDecoration(
          languageProvider.text("enter_email"),
          Icons.email,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text("email_required");
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildDobField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("date_of_birth"),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextFormField(
        controller: dobController,
        decoration: inputDecoration(
          languageProvider.text("enter_date_of_birth"),
          Icons.calendar_today,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text("date_of_birth_required");
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildRegisterButton(
  LanguageProvider languageProvider,
) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpVerificationPage(
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
      child: Text(
        languageProvider.text("register"),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}

Widget _buildLoginSection(
  LanguageProvider languageProvider,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        languageProvider.text("already_have_account"),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          languageProvider.text("login"),
        ),
      ),
    ],
  );
}}