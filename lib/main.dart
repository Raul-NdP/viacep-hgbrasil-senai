import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'componentes/botao.dart';
import 'componentes/caixa_texto.dart';
import 'componentes/texto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _cidade = "xxxx";
  String _uf = "xxxx";

  String _dataHoje = "xx/xx/xxxx";
  String _hora = "xx:xx";
  String _temperatura = "xx°";
  String _descricaoHoje = "xxxx";

  String _dataAmanha = "xx/xx/xxxx";
  String _descricaoAmanha = "xxxx";
  String _diaSemanaAmanha = "xxxx";

  final _txtCep = TextEditingController();

  buscarClima() async {
    buscarEndereco();
    final String urlHgBrasilWeather =
        "https://api.hgbrasil.com/weather?format=json-cors&key=87a07943&city_name=$_cidade,$_uf";
    Response resposta = await get(Uri.parse(urlHgBrasilWeather));
    Map clima = json.decode(resposta.body);
    setState(() {
      _dataHoje = "${clima["results"]["date"]}";
      _hora = "${clima["results"]["time"]}";
      _temperatura = "${clima["results"]["temp"]}";
      _descricaoHoje = "${clima["results"]["description"]}";

      _diaSemanaAmanha = "${clima["results"]["forecast"][1]["weekday"]}";
      _dataAmanha = "${clima["results"]["forecast"][1]["date"]}";
      _descricaoAmanha = "${clima["results"]["forecast"][1]["description"]}";
    });
  }

  buscarEndereco() async {
    final String urlViaCep = "https://viacep.com.br/ws/${_txtCep.text}/json/";
    Response resposta = await get(Uri.parse(urlViaCep));
    Map endereco = json.decode(resposta.body);
    setState(() {
      _cidade = "${endereco["localidade"]}";
      _uf = "${endereco["uf"]}";
    });
  }

  principal() {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CaixaTexto(
                  texto: "CEP",
                  controlador: _txtCep,
                  msgValidacao: "Insira o CEP",
                ),
              ),
              Botao(texto: "OK", funcao: buscarClima)
            ],
          ),
          Row(
            children: [
              const Texto(
                  conteudo: "Cidade:",
                  fonteTamanho: 30,
                  fonteCor: Colors.black),
              Texto(conteudo: _cidade, fonteTamanho: 30),
              const Texto(
                  conteudo: "UF:", fonteTamanho: 30, fonteCor: Colors.black),
              Texto(conteudo: _uf, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              const Texto(
                  conteudo: "Data:",
                  fonteTamanho: 30,
                  fonteCor: Colors.black),
              Texto(conteudo: _dataHoje, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              const Texto(
                  conteudo: "Hora:",
                  fonteTamanho: 30,
                  fonteCor: Colors.black),
              Texto(conteudo: _hora, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              const Texto(
                  conteudo: "Temperatura:",
                  fonteTamanho: 30,
                  fonteCor: Colors.black),
              Texto(conteudo: _temperatura, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              const Texto(
                  conteudo: "Descricao:",
                  fonteTamanho: 30,
                  fonteCor: Colors.black),
              Texto(conteudo: _descricaoHoje, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              Texto(conteudo: _diaSemanaAmanha, fonteTamanho: 30),
              const Texto(conteudo: " - ", fonteTamanho: 30),
              Texto(conteudo: _dataAmanha, fonteTamanho: 30),
            ],
          ),
          Row(
            children: [
              Texto(conteudo: _descricaoAmanha, fonteTamanho: 30),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: principal(),
    );
  }
}
