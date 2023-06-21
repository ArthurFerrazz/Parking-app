class Estacionamento {
  String? sId;
  String? nome;
  int? cnpj;
  String? endereco;
  DiaDeFuncionamento? diaDeFuncionamento;
  Horario? horario;
  int? qtdVagas;
  Preco? preco;
  int? telefone;
  int? cep;
  int? diaDoVencimento;
  bool? isActive;
  String? image;

  Estacionamento(
      {this.sId,
        this.nome,
        this.cnpj,
        this.endereco,
        this.diaDeFuncionamento,
        this.horario,
        this.qtdVagas,
        this.preco,
        this.telefone,
        this.cep,
        this.diaDoVencimento,
        this.isActive,
        this.image});

  Estacionamento.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
    cnpj = json['cnpj'];
    endereco = json['endereco'];
    diaDeFuncionamento = json['diaDeFuncionamento'] != null
        ? DiaDeFuncionamento.fromJson(json['diaDeFuncionamento'])
        : null;
    horario =
    json['horario'] != null ? Horario.fromJson(json['horario']) : null;
    qtdVagas = json['qtdVagas'];
    preco = json['preco'] != null ? Preco.fromJson(json['preco']) : null;
    telefone = json['telefone'];
    cep = json['cep'];
    diaDoVencimento = json['diaDoVencimento'];
    isActive = json['isActive'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nome'] = nome;
    data['cnpj'] = cnpj;
    data['endereco'] = endereco;
    if (diaDeFuncionamento != null) {
      data['diaDeFuncionamento'] = diaDeFuncionamento!.toJson();
    }
    if (horario != null) {
      data['horario'] = horario!.toJson();
    }
    data['qtdVagas'] = qtdVagas;
    if (preco != null) {
      data['preco'] = preco!.toJson();
    }
    data['telefone'] = telefone;
    data['cep'] = cep;
    data['diaDoVencimento'] = diaDoVencimento;
    data['isActive'] = isActive;
    data['image'] = image;
    return data;
  }
}

class DiaDeFuncionamento {
  String? inicio;
  String? fim;

  DiaDeFuncionamento({this.inicio, this.fim});

  DiaDeFuncionamento.fromJson(Map<String, dynamic> json) {
    inicio = json['inicio'];
    fim = json['fim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inicio'] = inicio;
    data['fim'] = fim;
    return data;
  }
}

class Horario {
  String? horaAbertura;
  String? horaFechamento;

  Horario({this.horaAbertura, this.horaFechamento});

  Horario.fromJson(Map<String, dynamic> json) {
    horaAbertura = json['horaAbertura'];
    horaFechamento = json['horaFechamento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horaAbertura'] = horaAbertura;
    data['horaFechamento'] = horaFechamento;
    return data;
  }
}

class Preco {
  double? hora;
  double? minuto;
  double? fixo;

  Preco({this.hora, this.minuto, this.fixo});

  Preco.fromJson(Map<String, dynamic> json) {
    hora = json['hora'];
    minuto = json['minuto'];
    fixo = json['fixo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hora'] = hora;
    data['minuto'] = minuto;
    data['fixo'] = fixo;
    return data;
  }

  String value() {
    if (hora != null) {
      return 'R\$$hora/h';
    } else if (minuto != null) {
      return 'R\$$minuto/min';
    } else if (fixo != null) {
      return 'R\$$fixo FIXO';
    }

    return '';
  }
}
