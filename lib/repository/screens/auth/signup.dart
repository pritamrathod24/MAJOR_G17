import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indicraft_major/repository/screens/auth/login.dart';
import 'package:indicraft_major/repository/screens/bottomnav/bottomnavbar.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isPasswordVisible2 = false;

  String? _validateUserName(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a email';
    }
    RegExp userRegExp = RegExp(r'^[a-zA-Z0-9._]{3,20}$');
    if (!userRegExp.hasMatch(value)) {
      return 'Please enter a valid username';
    } else {
      return null;
    }
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a email';
    }
    RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  // String? _validatePhoneNumber(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a number';
  //   }
  //   RegExp mobileRegExp = RegExp(r'^\d{10}$');
  //   if (!mobileRegExp.hasMatch(value)) {
  //     return 'Please enter 10-digit valid number';
  //   }
  //   return null;
  // }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8 || value.length > 20) {
      return 'Password must be between 8 and 20 characters';
    } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validatePassword2(value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8 || value.length > 20) {
      return 'Password must be between 8 and 20 characters';
    } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  bool isLogin = false;

  String email = '', password = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Future<void> authenticate() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     try {
  //       if (isLogin) {
  //         await login(context, emailController.text, passwordController.text);
  //       } else {
  //         await signup(context, emailController.text, passwordController.text);
  //
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Error: $e"))
  //       );
  //     }
  //   }
  // }
  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != passwordController2.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'password': passwordController2.text,
          'name': nameController.text,
          'email': emailController.text,
          // 'password':passwordController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Signup failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Text(
                    'We Say Hello!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15,left: 15),
                    child: Text(
                      'Welcome use your name and personal',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'credential to sign up.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 35),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: _validateUserName,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText:
                    !_isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off, // Toggle visibility icon
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible =
                            !_isPasswordVisible; // Toggle visibility state
                          });
                        },
                      ),
                      labelText: 'Create-Password',
                      hintText: 'Create-Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: _validatePassword, // Your validation logic here
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController2,
                    obscureText:
                    !_isPasswordVisible2, // Toggle password visibility
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off, // Toggle visibility icon
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible2 =
                            !_isPasswordVisible2; // Toggle visibility state
                          });
                        },
                      ),
                      labelText: 'Re-type Password',
                      hintText: 'Re-type Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: _validatePassword2, // Your validation logic here
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE67F17),shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)
                        )),
                        onPressed: signUp,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),
                        )),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Or Sign up with',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      IconButton(
                          icon: SvgPicture.asset('assets/images/google.svg'), // Add your SVG file
                          onPressed: (){}
                        // async{
                        //   await signInWithGoogle(context);
                        // },
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/images/instagram.svg'), // Add your SVG file
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/images/twitter.svg'), // Add your SVG file
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Color(0xFFE67F17),
                                    fontWeight: FontWeight.w900),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
