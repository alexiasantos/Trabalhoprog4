import 'package:flutter/material.dart';
import '../modelo/parque.dart';
import '../util/mensagens/erro_servidor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ControleListar {
  List<Parque> parques = List();

  var envelope =
      "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'" +
          " xmlns:web='http://webservice.jurassicpark.com.br/'>" +
          "<soapenv:Header/>" +
          "<soapenv:Body>" +
          "<web:listar/>" +
          "</soapenv:Body>" +
          "</soapenv:Envelope>";

  Future<List<Parque>> listarParquesWS(BuildContext context) async {
    try {
      final response = await http.post(
        'http://10.0.0.102:8080/jurassicpark/webservice/jurassicparkWS',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
        },
        body: envelope,
      );

      var raw = xml.parse(response.body);
      var elements =
          raw.findAllElements('return'); // tag do resultado no SoapUI

      return elements.map((element) {
        // OBS: Se no banco de dados alguma célula estiver como 'null' vai dar erro:
        // StateError (Bad state: No element)
        String datas = element.findElements("dataInauguracao").first.text;
        DateTime tempDate = DateFormat("yyyy-MM-dd").parse(datas);
        String data = DateFormat("dd/MM/yyyy").format(tempDate);

        return Parque(
          // nome deve ser o mesmo da tag do XML no SOAP UI
          element.findAllElements("id_parque").first.text,
          element.findElements("nome").first.text,
          element.findElements("capacidadeAnimais").first.text,
          element.findElements("capacidadePessoas").first.text,
          element.findElements("horarioInicio").first.text,
          element.findElements("horarioFim").first.text,
          element.findElements("regiao").first.text,
          data,
        );
      }).toList();
    } catch (error) {
      print(error);
      MensagemErroServidor(context);
    }
  }
}
