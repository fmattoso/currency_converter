import 'dart:convert';

import 'package:currency_converter/models/hgbrasil_key.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(HgBrasilKey.urlGetFinance));
  return json.decode(response.body);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),),
          hintStyle: TextStyle(color: Colors.amber),
          labelStyle: TextStyle(color: Colors.amber),
        ),
      ),
      home: const MyHomePage(title: 'Conversor de Moedas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController realController = TextEditingController();
  final TextEditingController dollarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  double dollar = 0;
  double euro = 0;

  void _realChanged(String? text) {
    if (text == null || text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real/ euro).toStringAsFixed(2);
  }

  void _dollarChanged(String? text) {
    if (text == null || text.isEmpty) {
      _clearAll();
      return;
    }
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String? text) {
    if (text == null || text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.clear();
    dollarController.clear();
    euroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: const Color(0xFF030303),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('Carregando ...',
                style: TextStyle(color: Colors.amber, fontSize: 25.0,
                ),),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Houve um erro ao carregar os dados: ',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20.0,
                  ))
                );
              }
              }
              if (snapshot.data != null) {
                dollar = snapshot.data!['results']['currencies']['USD']['buy'];
                euro = snapshot.data!['results']['currencies']['EUR']['buy'];
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(Icons.monetization_on, size: 98, color: Colors.amber,),
                    ),
                    buildTextField('Reais', 'R\$', realController, _realChanged),
                    const Divider(),
                    buildTextField('Dólares', 'US\$', dollarController, _dollarChanged),
                    const Divider(),
                    buildTextField('Euros', 'EU\$', euroController, _euroChanged),
                  ],
                )
              );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController ctrl, void Function(String?) fun) {
  return TextField(
    controller: ctrl,
      onChanged: fun,
      // Funciona no Android e no iOS.
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixText: '$prefix ',
      ),
    style: const TextStyle(
        color: Colors.amber, fontSize: 20.0
    ),
  );
}