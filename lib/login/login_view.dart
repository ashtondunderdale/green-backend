import 'package:flutter/material.dart';
import 'package:twofile/services/onefile.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _onefile = OneFileAPI();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 180),
          child: SizedBox(
            width: screen.width / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _title(),
                const SizedBox(height: 42),
                _detailField("keychain email or username", emailController, screen),
                const SizedBox(height: 20),
                _passwordFieldWithIcon(screen),

                _forgotPassword(),
                const SizedBox(height: 40),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "login with your onefile account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w100,
                        fontSize: 14
                      ),
                    ),
          
                    _loginButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: "better go reset it then",
            child: Text(
              "forgot password",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: "Inter",
                fontWeight: FontWeight.w100,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return const Column(
      children: [
        Text(
          "TwoFile",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
        Text(
          "because one wasn't enough",
          style: TextStyle(
            color: Colors.grey,
            fontFamily: "Inter",
            fontWeight: FontWeight.w100,
            fontSize: 14,
            fontStyle: FontStyle.italic
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onLogin,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                "Login",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordFieldWithIcon(Size screen) {
    return SizedBox(
      width: screen.width / 4,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _detailField("password", passwordController, screen, obscureText: true),
          _showPasswordIcon(),
        ],
      ),
    );
  }

  Widget _showPasswordIcon() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _detailField(
    String hintText,
    TextEditingController controller,
    Size screen, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText && !showPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  Future onLogin() async {
    var isValid = await _onefile.login(emailController.text, passwordController.text);
    print(isValid);

    if (isValid) {
    } else {
    }
  }
}
