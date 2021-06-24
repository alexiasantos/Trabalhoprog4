import '../modelo/parque.dart';
import 'package:http/http.dart' as http;

class ControleEditar {
  Future<Parque> editarParque(parque) async {
    print(
      'ID:${parque.id},' +
          'Parque:${parque.nomeParque},' +
          'Animais:${parque.capacidadeDeAnimais},' +
          'Pessoas:${parque.capacidadeDePessoas},' +
          'Inicio:${parque.horaInicio},' +
          'Fim:${parque.horaFim},' +
          'Região:${parque.regiaoParque},' +
          'DataInauguracao:${parque.dataDaInauguracao}',
    );

    var envelope =
        "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'" +
            " xmlns:web='http://webservice.jurassicpark.com.br/'>" +
            "<soapenv:Header/>" +
            "<soapenv:Body>" +
            "<web:incluir>" +
            "<!--Optional:-->" +
            "<arg0>" +
            "<!--Optional:-->" +
            "<capacidadeAnimais>" +
            parque.capacidadeDeAnimais +
            "</capacidadeAnimais>" +
            "<!--Optional:-->" +
            "<capacidadePessoas>" +
            parque.capacidadeDePessoas +
            "</capacidadePessoas>" +
            "<!--Optional:-->" +
            "<dataInauguracao>?</dataInauguracao>" +
            "<!--Optional:-->" +
            "<horarioFim>" +
            parque.horaFim +
            "</horarioFim>" +
            "<!--Optional:-->" +
            "<horarioInicio>" +
            parque.horaInicio +
            "</horarioInicio>" +
            "<!--Optional:-->" +
            "<!--Optional:-->" +
            "<nome>" +
            parque.nomeParque +
            "</nome>" +
            "<parqueAtivo>?</parqueAtivo>" +
            "<!--Optional:-->" +
            "<regiao>" +
            parque.regiaoParque +
            "</regiao>" +
            "<dataInauguracao>" +
            parque.dataDaInauguracao +
            "</dataInauguracao>" +
            "<id_parque>" +
            parque.id +
            "</id_parque>" +
            "</arg0>" +
            "</web:incluir>" +
            "</soapenv:Body>" +
            "</soapenv:Envelope>";

    await http.post(
      'http://10.0.0.102:8080/jurassicpark/webservice/jurassicparkWS',
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
      },
      body: envelope,
    );

    return parque;
  }
}
