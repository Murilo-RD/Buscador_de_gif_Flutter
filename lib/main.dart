
import 'Pages/buscardorPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(MaterialApp(home: Home(),debugShowCheckedModeBanner: false,theme: ThemeData(hintColor: Colors.white),));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const BuscardorPage();
  }
}
