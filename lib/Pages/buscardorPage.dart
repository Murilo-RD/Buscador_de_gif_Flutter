import 'dart:convert';
import 'dart:ui';

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


  int _getCount(List data){
    if(_search==null){
      return data.length;
    }else return data.length+1;
  }

  Future<Map<String, dynamic>> _getGifs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/trending?api_key=TyEPDvbAmwiB4AtPTjuFJ28Cy3eXyYRB&limit=20&offset=&rating=g&bundle=messaging_non_clips"));
    } else {
      response = await http.get(Uri.parse(
          "https://api.giphy.com/v1/gifs/search?api_key=TyEPDvbAmwiB4AtPTjuFJ28Cy3eXyYRB&q=$_search&limit=19&offset=$_offset&rating=g&lang=pt&bundle=messaging_non_clips"));
    }
    return jsonDecode(response.body);
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if(_search == null || index < snapshot.data["data"].length) {
          return GestureDetector(
            child: Image.network(
              snapshot.data['data'][index]['images']['fixed_height']['url'],
              height: 300,
              fit: BoxFit.cover,
            ),
          );
        }else{
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add,color: Colors.white,size: 70,),
                  Text("Carregar mais...",style: TextStyle(color: Colors.white),)
                ],
              ),
              onTap: (){
                setState(() {
                  _offset += 19;
                });
              },
            ),
          );
        }
      },
    );
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: TextField(
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {
                  if(text.isNotEmpty){
                    _search = text;
                    _offset = 0;
                  }
                });
                },
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
                height: 2.5,
              ),
              decoration: InputDecoration(
                  labelText: 'Pesquise aqui.',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 25),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _getGifs(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    width: 200,
                    alignment: Alignment.center,
                    height: 200,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5.0,
                    ),
                  );
                default:
                  if (snapshot.hasError)
                    return Container();
                  else
                    return _createGifTable(context, snapshot);
              }
            },
          ))
        ],
      ),
    );
  }
}
