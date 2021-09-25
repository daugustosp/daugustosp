import 'dart:async';

import 'package:bytebank/pages/carro/loripsum.dart';
import 'package:http/http.dart' as http;
import 'package:bytebank/pages/carro/simpleBloc.dart';

class LoripsumBloc extends SimpleBloc<String> {

  static String lorim;

  fetch() async {
    String s = lorim ?? await LoripsumApi.getLoripsum();

    lorim = s;

    add(s);
  }
}

class LoripsumApi {

  static Future<String> getLoripsum() async {


    var url = 'https://loripsum.net/api';

    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;

//    String text = await rootBundle.loadString("assets/lorim.json");

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}