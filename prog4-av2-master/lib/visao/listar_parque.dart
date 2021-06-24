import 'package:flutter/material.dart';
import '../modelo/parque.dart';
import '../controle/controle_listar.dart';
import '../controle/controle_excluir.dart';
import 'incluir_parque.dart';
import 'editar_parque.dart';

class ListarParque extends StatefulWidget {
  @override
  _ListarParqueState createState() => _ListarParqueState();
}

class _ListarParqueState extends State<ListarParque> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Jurassic Park'),
            backgroundColor: Colors.red,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              indicatorWeight: 5.0,
              tabs: [
                Tab(
                  child: Row(children: <Widget>[
                    Icon(Icons.account_balance_rounded),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Parques",
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                  ]),
                ),
                Tab(
                  child: Row(children: <Widget>[
                    Icon(Icons.pest_control),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Dinossauros",
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _abaParques(),
              _abaDinossauros(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _abaDinossauros() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Os dinossauros foram extintos \n',
              style: TextStyle(fontSize: 20),
            ),
            Image(
              image: AssetImage('assets/dino.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _abaParques() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IncluirParque()),
          ).then(
            (value) => setState(() {}),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: FutureBuilder(
            future: ControleListar()
                .listarParquesWS(context), //listarParquesWS(context),
            builder: (context, data) {
              if (data.hasData) {
                List<Parque> parques = data.data;
                return ListView.builder(
                    itemCount: parques.length,
                    itemBuilder: (context, index) {
                      return _parqueCard(context, index, parques);
                    });
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Aguardando conexão...',
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _parqueCard(BuildContext context, int index, List<Parque> parques) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0),
                width: 60.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      '#' + parques[index].id ?? "???",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    parques[index].nomeParque ?? "???",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Capacidade Animais: " +
                            parques[index].capacidadeDeAnimais ??
                        "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Capacidade Visitantes: " +
                            parques[index].capacidadeDePessoas ??
                        "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Hora Abertura: " + parques[index].horaInicio ?? "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Hora Encerramento: " + parques[index].horaFim ?? "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Data Inauguração: " + parques[index].dataDaInauguracao ??
                        "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Região: " + parques[index].regiaoParque ?? "?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index, parques, parques[index].id);
      },
    );
  }

  void _showOptions(BuildContext context, int index, parques, idParque) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _optionButton(
                      context,
                      Icons.edit,
                      "Editar".padLeft(8),
                      () {
                        Navigator.pop(context);
                        _showEditPage(parque: parques[index]);
                      },
                    ),
                    _optionButton(
                      context,
                      Icons.delete,
                      "Excluir".padLeft(8),
                      () {
                        Widget botaoCancelar = FlatButton(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            Navigator.pop(context);
                          },
                        );

                        Widget botaoExcluir = FlatButton(
                          child: Text(
                            "Excluir",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: () {
                            ExcluirParque()
                                .excluirParqueSelecionado(idParque)
                                .then(
                                  (value) => setState(
                                    () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  ),
                                );
                            Navigator.pop(context);
                          },
                        );

                        AlertDialog alert = AlertDialog(
                          title: Text("Excluir"),
                          content: Text(
                            "Deseja realmente excluir o item selecionado?",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          actions: [
                            botaoCancelar,
                            botaoExcluir,
                          ],
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Widget _optionButton(BuildContext context, icon, title, pressedFunction) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        onPressed: pressedFunction,
      ),
    );
  }

  void _showEditPage({Parque parque}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarParque(
          parque: parque,
        ),
      ),
    );
  }
}
