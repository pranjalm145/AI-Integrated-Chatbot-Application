import 'package:flutter/material.dart';
import 'package:flutter_application_1/MyHomePage.dart';
import 'package:flutter_application_1/Services/authentication.dart';
import 'package:flutter_application_1/Widget/button.dart';
import 'package:flutter_application_1/Widget/snack_bar.dart';
import 'package:flutter_application_1/Widget/text_field.dart';
import 'package:flutter_application_1/logn_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void despose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser() async {
    String res = await AuthServices().signUpUser(
    email: emailController.text, 
    password: passwordController.text, 
    name: nameController.text,
    );
    if(res == "success"){
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
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
                height: height/2.8, 
                child: Image.asset("assets/signup.jpeg"),
                ),
                TextFieldInpute(
                  textEditingController: nameController, 
                  hintText: "Enter your name",
                  icon: Icons.person,
                  ),
                TextFieldInpute(
                  textEditingController: emailController, 
                  hintText: "Enter your email",
                  icon: Icons.email,
                  ),
                  TextFieldInpute(
                  textEditingController: passwordController, 
                  hintText: "Enter your password",
                  isPass: true,
                  icon: Icons.lock,
                  ),
                  
                  MyButton(
                    onTab: signUpUser, text: "Sign Up"),
                  SizedBox(height: height/15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
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
                            builder: (context)=> const LoginScreen(),
                            ),
                            );
                      },
                    child: const Text(
                      " Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.lightBlue,
                      ),
                      ),
                    )
                    ],
                    )
            ],
            ),
          )),
    );
  }
}