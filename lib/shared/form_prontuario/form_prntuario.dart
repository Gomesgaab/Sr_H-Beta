import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/prontuarioModel.dart';

class FormProntuario extends StatefulWidget {
  const FormProntuario({super.key});

  @override
  State<FormProntuario> createState() => _FormProntuarioState();
}

class _FormProntuarioState extends State<FormProntuario> {
  final db = FirebaseFirestore.instance;
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  var datacontole = TextEditingController(text: "");
  var dataNacimento = "";
  var cnscontrol = TextEditingController();
  var nomeControle = TextEditingController();
  var sexoControle = TextEditingController();
  var fcControle = TextEditingController(text: "");
  var paControle = TextEditingController();
  var taxControle = TextEditingController();
  var rControle = TextEditingController();
  var dxControle = TextEditingController();
  var sintomasControle = TextEditingController();
  var anamneseControler = TextEditingController();
  var prescricaoMedicaControler = TextEditingController();
  var prescricaoEnfermagemControler = TextEditingController();
  var horarioControler = TextEditingController();
  var anotacaoEnfermagemControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          controller: cnscontrol,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 200, 228, 232))),
            fillColor: Color.fromARGB(255, 200, 228, 232),
            filled: true,
            hintText: "CNS:",
            contentPadding: EdgeInsets.only(top: 0, left: 10),

          ),
          validator: (value) {
            if (value.toString().length < 15) {
              return "CNS invalido, O CNS deve conter pelo menos 15 dígitos";
            }
            
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: nomeControle,
            decoration: const InputDecoration(hintText: "Nome "),
            validator: (value) {
              if (value == "") {
                return "Campo nao pode ser vazio";
              }
              return null;
            },
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Data Nacimento"),
                controller: datacontole,
                //readOnly usado para dizer se o campo e de leitura ou editavel
                readOnly: true,
                onTap: () async {
                  //Seleção de data
                  var data = await showDatePicker(
                      context: context,
                      firstDate: DateTime.utc(1900, 1, 1),
                      initialDate: DateTime.utc(2000, 1, 1),
                      lastDate: DateTime.utc(2023, 12, 31));

                  if (data != null) {
                    datacontole.text = data.toString();
                    dataNacimento = data.year.toString();
                  }
                },
                validator: (value) {
                  if (value == "") {
                    return "O campo data não pode ser vazio";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              width: 80,
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: sexoControle,
                decoration: const InputDecoration(hintText: "Sexo"),
                validator: (value) {
                  if (value == "") {
                    return "O campo sexo não poder ser vazio";
                  }
                  return null;
                },
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                  color: Colors.black,
                  child: const Text(
                    "Triagem",
                    style: TextStyle(fontSize: 25),
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  controller: fcControle,
                  decoration: const InputDecoration(hintText: "FC:"),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  controller: paControle,
                  decoration: const InputDecoration(hintText: "PA:"),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  controller: taxControle,
                  decoration: const InputDecoration(hintText: "TAx:"),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  controller: rControle,
                  decoration: const InputDecoration(
                    hintText: "R:",
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: dxControle,
                decoration: const InputDecoration(
                  hintText: "DX:",
                ),
              ),
            ),
            const SizedBox(width: 25),
            SizedBox(
              width: 130,
              child: TextFormField(
                controller: sintomasControle,
                decoration: const InputDecoration(
                  hintText: "Sintomas:",
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")),
              ),
              Expanded(
                flex: 289,
                child: Container(),
              ),
              Expanded(
                flex: 0,
                child: TextButton(
                    onPressed: () async {
                      botaoPrincipal();
                    },
                    child: const Text("Salvar")),
              )
            ],
          ),
        ),
      ],
    ));
  }

  botaoPrincipal() async {
    if (queroEntrar) {
      if (_formKey.currentState!.validate()) {
        //coletando e enviando dados ao bd
        var prontuario = ProntuarioModel(
          cns: cnscontrol.text,
          nome: nomeControle.text,
          dtNacimento: datacontole.text,
          sexo: sexoControle.text,
          fc: fcControle.text,
          pa: paControle.text,
          tax: taxControle.text,
          r: rControle.text,
          dx: dxControle.text,
          sintomas: sintomasControle.text,
          anamnese: anamneseControler.text,
          prescricaoMedica: prescricaoMedicaControler.text,
          prescricaoEnfermagem: prescricaoEnfermagemControler.text,
          horario: horarioControler.text,
          anotacaoEnfermagem: anotacaoEnfermagemControler.text,
        );
        await db
            .collection("Prontuario")
            .doc("Pacientes")
            .collection("HistoricoMedico")
            .doc()
            .set(prontuario.toJson()).then((value) => Navigator.pop(context));
        //limpando variaveis
        cnscontrol.text = "";
        nomeControle.text = "";
        sexoControle.text = "";
        datacontole.text = "";
      }
    }
  }
}
