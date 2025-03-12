import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuscardorPage extends StatefulWidget {
  const BuscardorPage({super.key});

  @override
  State<BuscardorPage> createState() => _BuscardorPageState();
}

class _BuscardorPageState extends State<BuscardorPage> {
  String? _search;
  int _offset = 0;

  Future<Map<String, dynamic>> _getGifs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=TyEPDvbAmwiB4AtPTjuFJ28Cy3eXyYRB&limit=20&offset=&rating=g&bundle=messaging_non_clips"));
    } else {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=TyEPDvbAmwiB4AtPTjuFJ28Cy3eXyYRB&q=$_search&limit=20&offset=$_offset&rating=g&lang=pt&bundle=messaging_non_clips"));
    }
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16,),
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                labelText: 'Pesquise aqui.',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
            ),
          )
        ],
      ),
    );
  }
}
