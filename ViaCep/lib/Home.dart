import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  String complemento = "";
  String cep = "";
  String erro = "";

  _recuperarCep() async {
    String cepUser = _controller.text;
    var url = Uri.parse("https://viacep.com.br/ws/${cepUser}/json/");

    http.Response response; //Response é uma classe que dei o nome de response
    //Tem que ser assincrona, pq requer tempo para pegar a resposta
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro1 = retorno["logradouro"]; //chave
    String bairro1 = retorno["bairro"]; //chave
    String localidade1 = retorno["localidade"]; //chave
    String uf1 = retorno["uf"]; //chave
    String cep1 = retorno["cep"]; //chave
    String complemento1 = retorno["complemento"]; //chave

    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}'); //Vem como txt, tem que converter para Json

    if(response.statusCode == 400){
         setState(() {
       erro = "CEP NÃO ENCONTRADO";
        print("ERROOOO" + erro);
    });  
    } else {
       
     setState(() {
      logradouro = "Rua: ${logradouro1}";
      bairro = "Bairro: ${bairro1}";
      localidade = "Localidade: ${localidade1}";
      uf = "UF: ${uf1}";
      complemento = "Complemento: ${complemento1}";
      cep = "CEP: ${cep1}";
      print("ERROOOO" + erro);
      _controller.clear();
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CEP'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                 
                  children: <Widget>[
                    Text(
                      "BUSQUE UM CEP",
                      style: TextStyle(fontSize: 40),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          
                          labelText: 'Digite um CEP...',
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: _recuperarCep,                      
                      child: Text(
                        'Buscar',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${erro}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${logradouro}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${bairro}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${localidade}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${uf}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${cep}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "${complemento}",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ), )
                    
                  ],
                ))));
  }
}
