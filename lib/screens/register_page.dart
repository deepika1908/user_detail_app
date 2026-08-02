import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/extensions/context_extension.dart';
import '../core/theme/app_text_styles.dart';
import '../core/theme/app_input_decorator.dart';
import '../widgets/custom_button.dart';
import 'otp_verification_page.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // final _formKey = GlobalKey<FormState>();

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

  bool _validateFields() {
    // final language = context.languageWatch;
    final language = context.language;

    if (firstNameController.text.trim().isEmpty) {
      _showSnackBar(language.text("first_name_required"));
      return false;
    }

    if (lastNameController.text.trim().isEmpty) {
      _showSnackBar(language.text("last_name_required"));
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      _showSnackBar(language.text("phone_number_required"));
      return false;
    }

    if (phoneController.text.length != 10) {
      _showSnackBar(language.text("invalid_phone_number"));
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      _showSnackBar(language.text("email_required"));
      return false;
    }

    if (!emailController.text.contains("@")) {
      _showSnackBar(language.text("invalid_email"));
      return false;
    }

    if (dobController.text.trim().isEmpty) {
      _showSnackBar(language.text("date_of_birth_required"));
      return false;
    }

    return true;
  }


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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
  // final languageProvider = Provider.of<LanguageProvider>(context);
final languageProvider = context.languageWatch;
  return Scaffold(
    // backgroundColor: AppColors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 25,
        ),
        // child: Form(
        //   key: _formKey,
        //   child: Column(
        child:Column(
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
      // style: const TextStyle(
        // fontSize: 28,
        // fontWeight: FontWeight.bold,
        style: AppTextStyles.heading,
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
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: firstNameController,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text("enter_first_name"),
          icon: Icons.person,
        ),
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
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: lastNameController,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text("enter_last_name"),
          icon: Icons.person_outline,
        ),
        
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
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: phoneController,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text("enter_phone_number"),
          icon: Icons.phone,
        ),
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
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      TextField(
        controller: emailController,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text("enter_email"),
          icon: Icons.email,
        ),
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
        style: AppTextStyles.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      const SizedBox(height: 8),

      // TextField(
      //   controller: dobController,
      //   decoration: inputDecoration(
      //     languageProvider.text("enter_date_of_birth"),
      //     Icons.calendar_today,
      //   ),
      TextField(
        controller: dobController,
        readOnly: true,
        onTap: selectDate,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text("enter_date_of_birth"),
          icon: Icons.calendar_today,
        ),
      )
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
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: AppColors.primary,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      // ),
      style: AppButtonStyle.primary,
      // onPressed: () {
      //   if (_formKey.currentState!.validate()) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => OtpVerificationPage(
      //           firstName: firstNameController.text,
      //           lastName: lastNameController.text,
      //           phone: phoneController.text,
      //           email: emailController.text,
      //           dob: dobController.text,
      //         ),
      //       ),
      //     );
      //   }
      // },
      onPressed: () {
          if (!_validateFields()) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpVerificationPage(
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text.trim(),
                phone: phoneController.text.trim(),
                email: emailController.text.trim(),
                dob: dobController.text.trim(),
              ),
            ),
          );
        },
      child: Text(
        languageProvider.text("register"),
        // style: const TextStyle(
        //   color: AppColors.white,
        //   fontSize: 18,
        style: AppTextStyles.button,
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