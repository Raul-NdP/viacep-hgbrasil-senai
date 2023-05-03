import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Texto extends StatefulWidget {

  final conteudo;
  final fonteTamanho;
  final fonteCor;

  const Texto({super.key, this.conteudo = "Texto", this.fonteTamanho = 10, this.fonteCor});

  @override
  State<Texto> createState() => _TextoState();
}

class _TextoState extends State<Texto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        widget.conteudo,
        style: TextStyle(
          fontSize: widget.fonteTamanho,
          color: widget.fonteCor
        ),
      ),
    );
  }
}