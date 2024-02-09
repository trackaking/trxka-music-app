import 'package:chatapp_firebase/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../widgets/song_widget/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'trxka-music',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sign up now to  get access to thousand songs!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Image.asset("assets/images/register.png"),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailInput.text = value.toString();
                    });
                  },
                  decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email,
                          color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _passwordInput.text = value.toString();
                    });
                  },
                  cursorColor: Colors.white,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.password,
                          color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  //style: style,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {},
                  child: const Text('signup'),
                ),
                const Text(
                  "Already have an account ?",
                  style: TextStyle(color: Colors.grey),
                ),
                ElevatedButton(
                  //style: style,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    'login',
                    style: TextStyle(color: Colors.greenAccent),
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
