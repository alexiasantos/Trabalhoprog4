import 'package:flutter/widgets.dart';
import 'package:date_time_picker/date_time_picker.dart';

class VerificaCamposTexto {
  void verificarSeNuloIncluir(parque) {
    if (parque.nomeParque == null) {
      parque.nome = "???";
    }
    if (parque.capacidadeDeAnimais == null) {
      parque.capacidadeAnimais = "?";
    }
    if (parque.capacidadeDePessoas == null) {
      parque.capacidadeVisitantes = "?";
    }
    if (parque.horaInicio == null) {
      parque.horaInicio = "00:00";
    }
    if (parque.horaFim == null) {
      parque.horaFim = "00:00";
    }
    if (parque.regiaoParque == null) {
      parque.regiao = "Região";
    }
    if (parque.dataDaInauguracao == null) {
      parque.dataInauguracao = "2000-01-01";
    }
  }

  void verificarSeNuloEditar(
    parque,
    TextEditingController idParqueController,
    nomeController,
    capacidadeAnimaisController,
    capacidadePessoasController,
    horarioInicioController,
    horarioFimController,
    regiaoController,
    dataInauguracaoController,
  ) {
    if (parque.id == null) {
      parque.idParque = idParqueController.text;
    }
    if (parque.nomeParque == null) {
      parque.nome = nomeController.text;
    }
    if (parque.capacidadeDeAnimais == null) {
      parque.capacidadeAnimais = capacidadeAnimaisController.text;
    }
    if (parque.capacidadeDePessoas == null) {
      parque.capacidadeVisitantes = capacidadePessoasController.text;
    }
    if (parque.horaInicio == null) {
      parque.horaInicio = horarioInicioController.text;
    }
    if (parque.horaFim == null) {
      parque.horaFim = horarioFimController.text;
    }
    if (parque.regiaoParque == null) {
      parque.regiao = regiaoController.text;
    }
    if (parque.dataDaInauguracao == null) {
      String datas = dataInauguracaoController.text;
      DateTime tempDate = DateFormat("dd/MM/yyyy").parse(datas);
      String data = DateFormat("yyyy-MM-dd").format(tempDate);
      parque.dataInauguracao = data;
    } else {
      String datas = parque.dataDaInauguracao;
      DateTime tempDate = DateFormat("dd/MM/yyyy").parse(datas);
      String data = DateFormat("yyyy-MM-dd").format(tempDate);
      parque.dataInauguracao = data;
    }
  }
}
