// OBS: Verificar o nome da tag no arquivo XML do SOAP UI

class Parque {
  String _idParque;
  String _nome;
  String _capacidadeAnimais;
  String _capacidadePessoas;
  String _horarioInicio;
  String _horarioFim;
  String _regiao;
  String _dataInauguracao;

  Parque(
    this._idParque,
    this._nome,
    this._capacidadeAnimais,
    this._capacidadePessoas,
    this._horarioInicio,
    this._horarioFim,
    this._regiao,
    this._dataInauguracao,
  );
  factory Parque.fromXML(Map<String, dynamic> xml) {
    if (xml == null) {
      return null;
    } else {
      return Parque(
        xml["idParque"],
        xml["nome"],
        xml["capacidadeAnimais"],
        xml["capacidadePessoas"],
        xml["horarioInicio"],
        xml["horarioFim"],
        xml["regiao"],
        xml["dataInauguracao"],
      );
    }
  }

  get id => this._idParque;
  get nomeParque => this._nome;
  get capacidadeDeAnimais => this._capacidadeAnimais;
  get capacidadeDePessoas => this._capacidadePessoas;
  get horaInicio => this._horarioInicio;
  get horaFim => this._horarioFim;
  get regiaoParque => this._regiao;
  get dataDaInauguracao => this._dataInauguracao;

  set idParque(String value) => this._idParque = value;
  set nome(String value) => this._nome = value;
  set capacidadeAnimais(String value) => this._capacidadeAnimais = value;
  set capacidadeVisitantes(String value) => this._capacidadePessoas = value;
  set horaInicio(String value) => this._horarioInicio = value;
  set horaFim(String value) => this._horarioFim = value;
  set regiao(String value) => this._regiao = value;
  set dataInauguracao(String value) => this._dataInauguracao = value;

  /* Adicionado para usar na classe EditarParque */
  final String idColumn = "idColumn";
  final String nomeColumn = "nomeColumn";
  final String capacidadeAnimaisColumn = "capacidadeAnimaisColumn";
  final String capacidadePessoasColumn = "capacidadePessoasColumn";
  final String horaInicioColumn = "horaInicioColumn";
  final String horaFimColumn = "horaFimColumn";
  final String regiaoColumn = "regiaoColumn";
  final String dataInauguracaoColumn = "dataInauguracaoColumn";

  Parque.fromMap(Map map) {
    _idParque = map[idColumn];
    _nome = map[nomeColumn];
    _capacidadeAnimais = map[capacidadeAnimaisColumn];
    _capacidadePessoas = map[capacidadePessoasColumn];
    _horarioInicio = map[horaInicioColumn];
    _horarioFim = map[horaFimColumn];
    _regiao = map[regiaoColumn];
    _dataInauguracao = map[dataInauguracaoColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      idColumn: _idParque,
      nomeColumn: _nome,
      capacidadeAnimaisColumn: _capacidadeAnimais,
      capacidadePessoasColumn: _capacidadePessoas,
      horaInicioColumn: _horarioInicio,
      horaFimColumn: _horarioFim,
      regiaoColumn: _regiao,
      dataInauguracaoColumn: _dataInauguracao,
    };

    if (_idParque != null) {
      map[idColumn] = _idParque;
    }
    return map;
  }
}
