import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    } catch (e) {
      print("Error sending password reset email: $e");

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.white,
                filled: true,
              ),

            ),
            SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE67F17),shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                )),
                onPressed:() async{
              sendPasswordResetEmail(emailController.text);
            }, child: Text('Reset Password',style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
    );
  }
}
