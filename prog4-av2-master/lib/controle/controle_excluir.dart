import 'package:http/http.dart' as http;

class ExcluirParque {
  Future<void> excluirParqueSelecionado(idParque) async {
    var envelope =
        "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'" +
            " xmlns:web='http://webservice.jurassicpark.com.br/'>" +
            "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<web:excluir>" +
            "<arg0>" +
            "<id_parque>" +
            idParque +
            "</id_parque>" +
            "</arg0>" +
            "</web:excluir>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>";

    await http.post(
      'http://10.0.0.102:8080/jurassicpark/webservice/jurassicparkWS',
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
      },
      body: envelope,
    );
  }
}
