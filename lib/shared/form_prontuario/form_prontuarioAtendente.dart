import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/prontuarioModel.dart';
import 'package:flutter_srh_application/shared/componentes/snackbar.dart';

class FormProntuarioAtendente extends StatefulWidget {
  FormProntuarioAtendente({super.key});

  @override
  State<FormProntuarioAtendente> createState() =>
      _FormProntuarioAtendenteState();
}

class _FormProntuarioAtendenteState extends State<FormProntuarioAtendente> {
  //validação do formulario e criação de chave de controle
  final _formKey = GlobalKey<FormState>();

  bool queroEntrar = true;
  final db = FirebaseFirestore.instance;
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
              validator: (String? value) {
                if (value == null) {
                  return "O campo CNS não pode ser vazio";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: nomeControle,
                decoration: const InputDecoration(hintText: "Nome "),
                validator: (String? value) {
                  if (value == null) {
                    return "O campo Nome não pode ser vazio";
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Data Nacimento"),
                    controller: datacontole,
                    //readOnly usado para dizer se o campo e de leitura ou editavel
                    readOnly: true,
                    onTap: () async {
                      //Seleção de data
                      var data = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900, 1, 1),
                          initialDate: DateTime(2000, 1, 1),
                          lastDate: DateTime(2023, 12, 31));
                      if (data != null) {
                        datacontole.text = data.toString();
                        dataNacimento = data.timeZoneName;
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return "O campo Data não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                SizedBox(
                  width: 80,
                  child: TextFormField(
                    controller: sexoControle,
                    decoration: const InputDecoration(hintText: "Sexo"),
                    validator: (value) {
                      if (value == null) {
                        return "O campo Sexo não pode ser vazio";
                      }
                      return null;
                    },
                  ),
                )
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
                          //fechando tela
                          Navigator.pop(context);
                          //coletando e enviando dados ao bd
                          botaoPrincipalClicado();
                          //limpando variaveis

                          cnscontrol.text = "";
                          nomeControle.text = "";
                          sexoControle.text = "";
                          datacontole.text = "";
                        },
                        child: const Text("Salvar")),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  botaoPrincipalClicado() async {
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        debugPrint("Form valido");
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
            .set(prontuario.toJson())
            .onError(
          (error, stackTrace) {
            if (error == null) {
              mostrarSnackBar(context: context, texto: error.toString());
            }
          },
        );
      }
    }
  }
}
