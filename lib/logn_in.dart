import 'package:flutter/material.dart';
import 'package:flutter_application_1/MyHomePage.dart';
import 'package:flutter_application_1/Services/authentication.dart';
import 'package:flutter_application_1/Widget/button.dart';
import 'package:flutter_application_1/Widget/snack_bar.dart';
import 'package:flutter_application_1/Widget/text_field.dart';
import 'package:flutter_application_1/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void despose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUsers() async {
    String res = await AuthServices().loginUser(
    email: emailController.text, 
    password: passwordController.text,
    );
    if(res == "success"){
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
        builder: (context)=> MyHomePage()
        )
        );
    }
    else{
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7, 
                child: Image.asset("assets/login.jpg"),
              ),
              TextFieldInpute(
                textEditingController: emailController, 
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              TextFieldInpute(
                isPass: true,
                textEditingController: passwordController, 
                hintText: "Enter your password",
                icon: Icons.lock,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue, 
                    ),
                  ),
                ),
              ),
              MyButton(
                onTab: loginUsers,
                text: "Log In"
              ),
              SizedBox(height: height / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.lightBlue
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
