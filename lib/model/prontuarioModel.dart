class ProntuarioModel {
  String? cns = "";
  String? nome = "";
  String? dtNacimento = "";
  String? sexo = "";
  String? fc;
  String? pa;
  String? tax;
  String? r;
  String? dx;
  String? sintomas;
  String? anamnese;
  String? prescricaoMedica;
  String? prescricaoEnfermagem;
  String? horario = "";
  String? anotacaoEnfermagem;
  

  ProntuarioModel({
    this.cns,
    this.nome,
    this.dtNacimento,
    this.sexo,
    this.fc,
    this.pa,
    this.tax,
    this.r,
    this.dx,
    this.sintomas,
    this.anamnese,
    this.prescricaoMedica,
    this.prescricaoEnfermagem,
    this.horario,
    this.anotacaoEnfermagem,
  });

  ProntuarioModel.fromJson(Map<String, dynamic> json) {
    cns = json['cns'];
    nome = json['nome'];
    dtNacimento = json['dtNacimento'];
    sexo = json['sexo'];
    fc = json['fc'];
    pa = json['pa'];
    tax = json['tax'];
    r = json['r'];
    dx = json['dx'];
    sintomas = json['sintomas'];
    anamnese = json['anamnese'];
    prescricaoMedica = json['prescricaoMedica'];
    prescricaoEnfermagem = json['prescricaoEnfermagem'];
    horario = json['horario'];
    anotacaoEnfermagem = json['anotacaoEnfermagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cns'] = this.cns;
    data['nome'] = this.nome;
    data['dtNacimento'] = this.dtNacimento!;
    data['sexo'] = this.sexo;
    data['fc'] = this.fc;
    data['pa'] = this.pa;
    data['tax'] = this.tax;
    data['r'] = this.r;
    data['dx'] = this.dx;
    data['sintomas'] = this.sintomas;
    data['anamnese'] = this.anamnese;
    data['prescricaoMedica'] = this.prescricaoMedica;
    data['prescricaoEnfermagem'] = this.prescricaoEnfermagem;
    data['horario'] = this.horario;
    data['anotacaoEnfermagem'] = this.anotacaoEnfermagem;
    return data;
  }
}
