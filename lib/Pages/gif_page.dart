
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  const GifPage(this._gifData,{super.key});

  final Map _gifData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Scaffold(appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(_gifData["title"],style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
        backgroundColor: Colors.black,
        body: Center(child: Image.network(_gifData["images"]["fixed_height"]["url"]),),
      ),
    );
  }
}
