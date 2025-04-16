import 'package:flutter/material.dart';
import 'package:pollutrack25/screens/exposure.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 50, bottom: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              'assets/logo.png',
              scale: 4,
              ),
            const SizedBox(
                  height: 30,
                ),
            const Text(
              'Welcome',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Login',
            ),
            const SizedBox(
              height: 25,
            ),

            TextField(
              controller: userController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Username',
                hintText: 'Enter your username',
              ),),

              const SizedBox(
                height: 20,
              ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
                hintText: 'Enter your password',
              ),),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(userController.text == 'admin' && passwordController.text == '123456') {

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const Exposure(),
                        ),
                      );
                      } else {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(8),
                              duration: Duration(seconds: 2),
                              content:
                                  Text("username or password incorrect")));
                      }
                  },
                  style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF384242))),
                  child: const Text('Log In'),
                ),
              ),
            ),
            const Spacer(),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "By logging in, you agree to Pollutrack's\nTerms & Conditions and Privacy Policy",
                  style: TextStyle(fontSize: 12),
                )),
                ]),
              ),
            
          ),
    );
  }
}