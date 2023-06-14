class Estacionamento {
  String? sId;
  String? nome;
  String? cnpj;
  String? endereco;
  int? qtdVagas;
  int? precoHora;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Estacionamento(
      {this.sId,
        this.nome,
        this.cnpj,
        this.endereco,
        this.qtdVagas,
        this.precoHora,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Estacionamento.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
    cnpj = json['cnpj'];
    endereco = json['endereco'];
    qtdVagas = json['qtdVagas'];
    precoHora = json['precoHora'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nome'] = nome;
    data['cnpj'] = cnpj;
    data['endereco'] = endereco;
    data['qtdVagas'] = qtdVagas;
    data['precoHora'] = precoHora;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
