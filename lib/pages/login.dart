import 'package:docket/controller/google_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/cover.png",
                    ),
                  ),
                ),
              ),
            ),
            //
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              child: Text(
                "Create and Manage your Dockets",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36.0,
                  fontFamily: "lato",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                    primary: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login With Google",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "lato",
                      ),
                    ),
                    //
                    const SizedBox(
                      width: 10.0,
                    ),
                    //
                    Image.asset(
                      'assets/images/google.png',
                      height: 36.0,
                    ),
                  ],
                ),
              ),
            ),
            //
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
