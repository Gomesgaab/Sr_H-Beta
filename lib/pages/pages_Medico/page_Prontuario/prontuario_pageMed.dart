import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/prontuarioModel.dart';
import 'package:flutter_srh_application/service/Prontuario_Detail/prontuario_detailmed.dart';
import 'package:flutter_srh_application/shared/form_prontuario/form_prntuario.dart';

class PageProntuarioMed extends StatefulWidget {
  const PageProntuarioMed({super.key});

  @override
  State<PageProntuarioMed> createState() => _PageProntuarioMedState();
}

class _PageProntuarioMedState extends State<PageProntuarioMed> {
  final db = FirebaseFirestore.instance;
  var collection = FirebaseFirestore.instance.collection('Prontuario');
  //validação do formulario e criação de chave de controle

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(145, 200, 228, 1000),
        child: StreamBuilder<QuerySnapshot>(
            //definindo caminho de coleção para visualização de dados
            stream: db
                .collection("Prontuario")
                .doc("Pacientes")
                .collection("HistoricoMedico")
                .snapshots(),
            builder: (context, snapshot) {
              //se não conter dados ficar na tela de carregamento
              return !snapshot.hasData
                  ? const CircularProgressIndicator()
                  : ListView(
                      children: snapshot.data!.docs.map((e) {
                      var prontuario = ProntuarioModel.fromJson(
                          (e.data() as Map<String, dynamic>));
                      return Container(
                        margin: const EdgeInsets.all(10),
                        //utilizando inkwell para quando clicar no card ele expandir
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                       PRontuarioDetailMed(),
                                ));
                          },
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Dismissible(
                                onDismissed:
                                    (DismissDirection dismissDirectio) async {},
                                key: Key(e.id),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Paciente",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 23),
                                                "${prontuario.nome!}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "CNS",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                "${prontuario.cns!}"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 10, top: 10, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Data de Nascimento",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                "${prontuario.dtNacimento}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      );
                    }).toList());
            }),
      ),
      //botão de criação de prontuário
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext bc) {
                return ListView(
                  children: [
                    AlertDialog.adaptive(
                      backgroundColor: const Color.fromARGB(255, 200, 228, 232),
                      title: const Text(" prontuario"),
                      actions: [FormProntuario()],
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
