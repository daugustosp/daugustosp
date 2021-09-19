class Segredo {
  int codigo;
  String breveDescricao;
  String descricao;
  String dataSecredo;
  String validade;
  double codidentifica;
  String userCompartilhado;

  Segredo(
      {this.codigo,
        this.breveDescricao,
        this.descricao,
        this.dataSecredo,
        this.validade,
        this.codidentifica});

  Segredo.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    breveDescricao = json['breveDescricao'];
    descricao = json['descricao'];
    dataSecredo = json['dataSecredo'];
    validade = json['validade'];
    codidentifica = json['codidentifica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['breveDescricao'] = this.breveDescricao;
    data['descricao'] = this.descricao;
    data['dataSecredo'] = this.dataSecredo;
    data['validade'] = this.validade;
    data['codidentifica'] = this.codidentifica;
    return data;
  }
}