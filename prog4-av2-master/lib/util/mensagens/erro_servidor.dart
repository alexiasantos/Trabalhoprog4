import 'package:flutter/material.dart';

MensagemErroServidor(context) {
  Widget botaoConfirmar = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(
        fontSize: 18.0,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Falha do servidor"),
    content: Text(
      "Falha na conexão com o servidor",
      style: TextStyle(
        fontSize: 20.0,
      ),
    ),
    actions: [
      botaoConfirmar,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
