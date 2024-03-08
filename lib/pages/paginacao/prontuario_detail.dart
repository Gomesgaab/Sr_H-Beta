import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/prontuarioModel.dart';
import 'package:flutter_srh_application/pages/pages_home/mainPage.dart';

class ProntuarioDetail extends StatelessWidget {
  const ProntuarioDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var datacontole = TextEditingController();
    var dataNacimento = "";
    var cnscontrol = TextEditingController();
    var sexoControle = TextEditingController();
    var nomeControle = TextEditingController();
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
    final db = FirebaseFirestore.instance;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(145, 200, 228, 1000),
        child: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection("Prontuario")
                .doc("Pacientes")
                .collection("HistoricoMedico")
                .snapshots(),
            builder: (context, snapshot) {
              //se não conter dados ficar na tela de carregamento
              return !snapshot.hasData
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 10,
                            backgroundColor: Colors.cyan,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: snapshot.data!.docs.map((e) {
                      var prontuario = ProntuarioModel.fromJson(
                          (e.data() as Map<String, dynamic>));
                      return Container(
                        margin: const EdgeInsets.all(10),
                        //utilizando inkwell para quando clicar no card ele expandir
                        child: Form(
                          child: Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirectio) async {},
                              key: Key(e.id),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //caixa de formulario do CNS
                                    Text(
                                        style: TextStyle(fontSize: 24),
                                        "CNS: ${prontuario.cns}"),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: cnscontrol,
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 200, 228, 232))),
                                        fillColor:
                                            Color.fromARGB(255, 200, 228, 232),
                                        filled: true,
                                        hintText: "CNS:",
                                        contentPadding:
                                            EdgeInsets.only(top: 0, left: 10),
                                      ),
                                    ),
                                    //caixa de formulario do nome
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: TextFormField(
                                        //dando valor inicial
                                        initialValue: prontuario.nome,
                                        decoration: const InputDecoration(
                                            label: Text("Nome ")),
                                        //deixando caixa de texto ativa
                                        enabled: true,
                                        //bloqueando edição
                                        readOnly: true,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            initialValue: prontuario.dtNacimento
                                                .toString(),
                                            decoration: const InputDecoration(
                                              label: Text("Data Nacimento"),
                                            ),
                                            //readOnly usado para dizer se o campo e de leitura ou editavel
                                            readOnly: true,
                                            //desativando caixa de texto
                                            enabled: true,
                                            onTap: () async {
                                              //Seleção de data
                                              var data = await showDatePicker(
                                                  context: context,
                                                  //validando data
                                                  firstDate:
                                                      DateTime(1900, 1, 1),
                                                  //dando data inicial
                                                  initialDate:
                                                      DateTime(2000, 1, 1),
                                                  //dando data máxima
                                                  lastDate:
                                                      DateTime(2023, 12, 31));
                                              if (data != null) {
                                                datacontole.text =
                                                    data.toString();
                                                dataNacimento =
                                                    data.timeZoneName;
                                              }
                                            },
                                          ),
                                        ),
                                        //expacamento das caixas de texto data e sexo
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            initialValue: prontuario.sexo,
                                            decoration: const InputDecoration(
                                                label: Text("Sexo")),
                                            //ativando caixa de texto
                                            enabled: true,
                                            //bloqueando edição
                                            readOnly: true,
                                            // controller
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 40,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: TextFormField(
                                              controller: fcControle,
                                              decoration: const InputDecoration(
                                                  label: Text("FC:")),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: TextFormField(
                                              controller: paControle,
                                              decoration: const InputDecoration(
                                                  label: Text("PA:")),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: TextFormField(
                                              controller: taxControle,
                                              decoration: const InputDecoration(
                                                  label: Text("TAx:")),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child: TextFormField(
                                              controller: rControle,
                                              decoration: const InputDecoration(
                                                label: Text("R:"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              controller: dxControle,
                                              decoration: const InputDecoration(
                                                label: Text("DX:"),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 25),
                                          SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              controller: sintomasControle,
                                              decoration: const InputDecoration(
                                                label: Text("Sintomas:"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPage(),
                                                      ));
                                                },
                                                child: const Text(
                                                  "Sarir",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                          ),
                                          Expanded(
                                            child: TextButton(
                                                onPressed: () async {
                                                  var updatePront =
                                                      ProntuarioModel(
                                                    dtNacimento: DateTime.parse(
                                                        datacontole.text),
                                                    cns: cnscontrol.text,
                                                    nome: prontuario.nome,
                                                    sexo: prontuario.sexo,
                                                    fc: fcControle.text,
                                                    pa: paControle.text,
                                                    tax: taxControle.text,
                                                    r: rControle.text,
                                                    dx: dxControle.text,
                                                    sintomas:
                                                        sintomasControle.text,
                                                    anamnese:
                                                        anamneseControler.text,
                                                    prescricaoMedica:
                                                        prescricaoMedicaControler
                                                            .text,
                                                    prescricaoEnfermagem:
                                                        prescricaoEnfermagemControler
                                                            .text,
                                                    horario:
                                                        horarioControler.text,
                                                    anotacaoEnfermagem:
                                                        anotacaoEnfermagemControler
                                                            .text,
                                                  );
                                                  await db
                                                      .collection("Prontuario")
                                                      .doc(cnscontrol.text)
                                                      .update(
                                                          updatePront.toJson());
                                                },
                                                child: const Text(
                                                  "Update",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }).toList());
            }),
      ),
    );
  }
}
