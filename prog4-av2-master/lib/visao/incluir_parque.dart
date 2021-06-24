import 'package:flutter/material.dart';
import '../controle/controle_listar.dart';
import '../modelo/parque.dart';
import '../controle/controle_incluir.dart';
import 'package:date_time_picker/date_time_picker.dart';

class IncluirParque extends StatefulWidget {
  IncluirParque({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IncluirParqueState createState() => _IncluirParqueState();
}

class _IncluirParqueState extends State<IncluirParque> {
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

  // DropDownButton
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Novo Parque"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ControleIncluir().salvarParque(parque).then(
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
                decoration: InputDecoration(
                    labelText: "Capacidade Visitantes",
                    icon: Icon(Icons.person_add_alt_1)),
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.capacidadeVisitantes = text;
                },
                keyboardType: TextInputType.number,
              ),
              DateTimePicker(
                type: DateTimePickerType.time,
                icon: Icon(Icons.access_time),
                initialValue: '',
                timeLabelText: "Hora Abertura",
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.horaInicio = text;
                },
              ),
              DateTimePicker(
                type: DateTimePickerType.time,
                icon: Icon(Icons.access_time),
                initialValue: '',
                timeLabelText: "Hora Encerramento",
                style: TextStyle(fontSize: 22.0),
                onChanged: (text) {
                  parque.horaFim = text;
                },
              ),
              DateTimePicker(
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
              ),
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
                onChanged: (novoItemSelecionado) {
                  parque.regiao = novoItemSelecionado;

                  _dropDownItemSelected(novoItemSelecionado);
                  setState(() {
                    this._itemSelecionado = novoItemSelecionado;
                  });
                },
                value: _itemSelecionado,
              ),
            ],
          )),
    );
  }
}
