import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:indicraft_major/repository/screens/auth/login.dart';
import '../home/homepage/home_tab.dart';

class checkUser extends StatefulWidget {
  const checkUser({super.key});

  @override
  State<checkUser> createState() => _checkUserState();
}

class _checkUserState extends State<checkUser> {
  @override
  Widget build(BuildContext context) {
    return checkuser();
  }
}

checkuser(){
  final user = FirebaseAuth.instance.currentUser;
  if(user != null){
    return Homepage();
  }else{
    return LoginPage();
  }

}