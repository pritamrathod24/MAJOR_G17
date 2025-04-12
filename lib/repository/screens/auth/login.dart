import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:indicraft_major/repository/screens/auth/signup.dart';
import 'package:indicraft_major/repository/screens/forgetpassword/forget.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const
  LoginPage({super.key});
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

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

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await login(context, email.text, password.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
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
                      'Welcome back use your email and',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'password to log in.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 80),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: Colors.white60,
                      filled: true,
                    ),
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: password,
                    obscureText:
                    !_isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons
                              .visibility_off, // Toggle visibility icon
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible =
                            !_isPasswordVisible; // Toggle visibility state
                          });
                        },
                      ),
                      labelText: 'Password',
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                    ),
                    validator:
                    _validatePassword, // Your validation logic here
                  ),
                  SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                    },child: Text('Forgot Password??',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
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
                        onPressed: handleLogin,
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18),
                        )),
                  ),
                  SizedBox(height: 16,),
                  Text('or Login with',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/images/google.svg'), // Add your SVG file
                        onPressed: () async{
                          await signInWithGoogle(context);
                        },
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
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (contex) => SignupPage(),
                                ));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFFE67F17),
                              fontWeight: FontWeight.w900,),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
