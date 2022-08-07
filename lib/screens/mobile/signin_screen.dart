import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/help_functions.dart';
import 'package:moo/services/firebase.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // ignore: deprecated_member_use
          child: InkWell(
            onTap: () => signInWithGoogle(),
            highlightColor: greenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark(context) ? whiteColor : greenColor,
                    width: 0.7,
                  )),
              child: Image.asset(
                isDark(context)
                    ? 'assets/images/googlebtnwhite.png'
                    : 'assets/images/googlebtn.png',
                fit: BoxFit.contain,
                width: size.width / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
