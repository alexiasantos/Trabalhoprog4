import 'package:flutter/material.dart';
import '../controle/controle_listar.dart';
import '../modelo/parque.dart';
import '../util/verificar_campo.dart';
import '../controle/controle_editar.dart';
import 'package:date_time_picker/date_time_picker.dart';

class EditarParque extends StatefulWidget {
  final Parque parque;

  EditarParque({this.parque});

  @override
  _EditarParqueState createState() => _EditarParqueState();
}

class _EditarParqueState extends State<EditarParque> {
  Parque parque = new Parque(
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  );

  Parque _parqueEditado;

  final _idParqueController = TextEditingController();
  final _nomeController = TextEditingController();
  final _capacidadeAnimaisController = TextEditingController();
  final _capacidadePessoasController = TextEditingController();
  final _horarioInicioController = TextEditingController();
  final _horarioFimController = TextEditingController();
  final _regiaoController = TextEditingController();
  final _dataInauguracaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.parque == null) {
      _parqueEditado = Parque(
        _idParqueController.text,
        _nomeController.text,
        _capacidadeAnimaisController.text,
        _capacidadePessoasController.text,
        _horarioInicioController.text,
        _horarioFimController.text,
        _regiaoController.text,
        _dataInauguracaoController.text,
      );
    } else {
      _parqueEditado = Parque.fromMap(widget.parque.toMap());

      _idParqueController.text = _parqueEditado.id;
      _nomeController.text = _parqueEditado.nomeParque;
      _capacidadeAnimaisController.text = _parqueEditado.capacidadeDeAnimais;
      _capacidadePessoasController.text = _parqueEditado.capacidadeDePessoas;
      _horarioInicioController.text = _parqueEditado.horaInicio;
      _horarioFimController.text = _parqueEditado.horaFim;
      _regiaoController.text = _parqueEditado.regiaoParque;
      _dataInauguracaoController.text = _parqueEditado.dataDaInauguracao;
    }
  }

  // --- DropDownButton Região ---
  var _regioes = [
    'Região',
    'Norte',
    'Sul',
    'Leste',
    'Oeste',
    'Nordeste',
    'Sudeste',
    'Centro'
  ];

  var _itemSelecionado = 'Região';

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }
  // -----------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Editar Parque"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          VerificaCamposTexto().verificarSeNuloEditar(
            parque,
            _idParqueController,
            _nomeController,
            _capacidadeAnimaisController,
            _capacidadePessoasController,
            _horarioInicioController,
            _horarioFimController,
            _regiaoController,
            _dataInauguracaoController,
          );
          ControleEditar().editarParque(parque);
          ControleListar().listarParquesWS(context).then(
                (value) => setState(
                  () {
                    ControleListar().listarParquesWS(context);
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                ),
              );
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _idParqueController,
                decoration: InputDecoration(
                  labelText: "ID",
                  icon: Icon(Icons.format_list_numbered),
                ),
                style: TextStyle(fontSize: 22.0),
              ),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  icon: Icon(Icons.account_balance_rounded),
                ),
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.nome = text;
                },
              ),
              TextField(
                controller: _capacidadeAnimaisController,
                decoration: InputDecoration(
                  labelText: "Capacidade Animais",
                  icon: Icon(Icons.pest_control),
                ),
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.capacidadeAnimais = text;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _capacidadePessoasController,
                decoration: InputDecoration(
                  labelText: "Capacidade Visitantes",
                  icon: Icon(Icons.person_add_alt_1),
                ),
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.capacidadeVisitantes = text;
                },
                keyboardType: TextInputType.number,
              ),
              DateTimePicker(
                controller: _horarioInicioController,
                type: DateTimePickerType.time,
                icon: Icon(Icons.access_time),
                timeLabelText: "Hora Abertura",
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.horaInicio = text;
                },
              ),
              DateTimePicker(
                controller: _horarioFimController,
                type: DateTimePickerType.time,
                icon: Icon(Icons.access_time),
                timeLabelText: "Hora Encerramento",
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.horaFim = text;
                },
              ),
              TextField(
                controller: _dataInauguracaoController,
                decoration: InputDecoration(
                  labelText: "Data Inauguração",
                  icon: Icon(Icons.access_time),
                ),
                style: TextStyle(fontSize: 22.0),
                onChanged: (String text) {
                  parque.dataInauguracao = text;
                },
              ),
              /*DateTimePicker(
                controller: _dataInauguracaoController,
                type: DateTimePickerType.date,
                dateMask: 'dd/MM/yyyy',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Data Inauguração',
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.dataInauguracao = text;
                },
              ),*/
              DropdownButton<String>(
                icon: Icon(Icons.place),
                iconSize: 30,
                elevation: 16,
                style: TextStyle(color: Colors.black54, fontSize: 22.0),
                underline: Container(
                  height: 2,
                  color: Colors.deepOrangeAccent,
                ),
                items: _regioes.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  parque.regiao = novoItemSelecionado;

                  _dropDownItemSelected(novoItemSelecionado);
                  setState(() {
                    this._regiaoController.text = novoItemSelecionado;
                  });
                },
                value: _regiaoController.text,
              ),
            ],
          )),
    );
  }
}
