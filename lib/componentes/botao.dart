import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  
  final texto;
  final funcao;
  final corFundo;
  final corLetra;
  final largura;
  final altura;
  final tamanhoFonte;
  
  const Botao({super.key, this.texto = "Botão", this.funcao, this.corFundo = const Color.fromARGB(251, 143, 0, 0), this.corLetra = Colors.white, this.largura = 200, this.altura = 40, this.tamanhoFonte = 15});

  @override
  State<Botao> createState() => _botaoState();
}

class _botaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: widget.tamanhoFonte
          ),
          foregroundColor: widget.corLetra,
          backgroundColor: widget.corFundo,
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: Size(widget.largura, widget.altura),
        ),
        onPressed: widget.funcao, 
        child: Text(widget.texto)
      ),
    );
  }
}