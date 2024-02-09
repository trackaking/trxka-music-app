import 'dart:convert';
import 'dart:io';

import 'package:chatapp_firebase/pages/signup_page.dart';
import 'package:chatapp_firebase/shared/constants.dart';
import 'package:chatapp_firebase/widgets/song_widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helper/helper_function.dart';
import '../models/login_model.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  HelperFunctions helper = HelperFunctions();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  String invalidPasswordMessage = "";
  String invalidUsernameMessage = "";
  HelperFunctions sharedPref = HelperFunctions();
  // Create storage
  final storage = const FlutterSecureStorage();

//user log in function
  Future<Login> login() async {
    //loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    final response = await http.post(
      Uri.parse("${Constants.serverUrl}auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'emailOrUsername': _emailInput.text.toString(),
        'password': _passwordInput.text.toString()
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      SweetCookieJar sweetCookieJar = SweetCookieJar.from(response: response);
      Cookie cookie = sweetCookieJar.find(name: 'token');
      // Write value
      await storage.write(key: "token", value: cookie.value);

      await sharedPref.setToken(cookie.value);

      // //pop the loading circle and redirect to home page
      Login loginClassValues = Login.fromJson(jsonDecode(response.body));

      if (loginClassValues.success == true) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }

      //verify if the username is invalid
      if (loginClassValues.validUserInfo == false) {
        setState(() {
          invalidUsernameMessage = "Invalid username or email";
        });
      } else {
        setState(() {
          invalidUsernameMessage = "";

          //verify if the user password is invalid
          if (loginClassValues.validPassword == false) {
            setState(() {
              invalidPasswordMessage = "Invalid password";
            });
          } else {
            setState(() {
              invalidPasswordMessage = "";
            });
          }
        });
      }

      return loginClassValues;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      if (context.mounted) {
        Navigator.of(context).pop();
      }
      throw Exception('Failed to log in');
    }
  }

  @override
  void initState() {
    //redirectToMainPage();
    super.initState();
  }

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
                  "Login now to  get access to thousand songs!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Image.asset("assets/images/login.png"),
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
                      labelText: "Email or username",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.supervised_user_circle,
                          color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  invalidUsernameMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  invalidPasswordMessage,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  //style: style,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    await login();
                  },
                  child: const Text('Login'),
                ),
                const Text(
                  "Doesn't have an account ?",
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
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text(
                    'signup',
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
