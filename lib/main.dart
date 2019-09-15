import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'home.dart';

const key = "4734bcf9";
const request = "https://api.hgbrasil.com/finance?key=$key";

void main() async
{
  runApp(
    MaterialApp(
      theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))
            )
      ),
      home:Home()
  ));
}

Future<Map> getData() async
{
  http.Response response = await http.get(request);
  return(json.decode(response.body)["results"]["currencies"]);
} 