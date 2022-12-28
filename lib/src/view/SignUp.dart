import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nombreController = TextEditingController();
    final apellidosController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.teal,
                Colors.teal,
                Colors.blue,
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 150,
                width: 300,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 325,
                height: 480,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "DINBEAT",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please Login to Your Account",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textF(
                        nombreController,
                        "Nombre",
                        const Icon(
                          FontAwesomeIcons.person,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    textF(
                        apellidosController,
                        "Apellidos",
                        const Icon(
                          FontAwesomeIcons.person,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    textF(
                        emailController,
                        "Email",
                        const Icon(
                          FontAwesomeIcons.envelope,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    textF(
                        passwordController,
                        "Password",
                        const Icon(
                          FontAwesomeIcons.eyeSlash,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        clickRegister(
                            context, emailController, passwordController);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ])),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textF(passwordController, labelText_, icon) {
    return Container(
      width: 260,
      height: 48,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
            suffix: icon,
            labelText: labelText_,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            )),
      ),
    );
  }

  void clickRegister(context, TextEditingController emailController,
      TextEditingController passwordController) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    Navigator.pop(context);
  }
}
