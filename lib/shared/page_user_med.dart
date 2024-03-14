import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pageLogin/LoginPage.dart';

import 'package:flutter_srh_application/service/authUser.dart';

class PageUser extends StatefulWidget {
  const PageUser({super.key});

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(145, 200, 228, 1000),
      body: Container(
        margin: EdgeInsets.only(top: 0, left: 10, right: 10),
        child: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: double.maxFinite, maxWidth: double.maxFinite),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(1),
              child: Stack(alignment: Alignment.center, children: [
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(192, 189, 177, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                title: const Text("Camera"),
                                leading: const Icon(Icons.camera_alt_outlined),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                title: const Text("Galeria"),
                                leading: const Icon(Icons.photo_album),
                              ),
                            ],
                          );
                        });
                  },
                ),
                //container da imagem do usuário
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 125),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('asset/avatar.png'),
                          radius: 48,
                          child: Container(
                              padding: EdgeInsets.only(top: 50, left: 75),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.edit))),
                        )),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Wrap(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                title: const Text("Camera"),
                                leading: const Icon(Icons.camera_alt_outlined),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                title: const Text("Galeria"),
                                leading: const Icon(Icons.photo_album),
                              ),
                            ],
                          );
                        });
                  },
                )
              ]),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(246,244,235,1000)),
                margin: EdgeInsets.only(top: 40, left: 10, right: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        enabled: true,
                        decoration: InputDecoration(label: Text("ID")),
                        initialValue: FirebaseAuth.instance.currentUser?.uid,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        enabled: true,
                        readOnly: true,
                        decoration: InputDecoration(label: Text("E-mail")),
                        initialValue: FirebaseAuth.instance.currentUser?.email,
                      )
                    ],
                  )),
                )),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 40),
              width: double.maxFinite,
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.exit_to_app_sharp),
                  label: Text("Sair"),
                  style: ButtonStyle(),
                  //efeito de clic
                  onPressed: () {
                    // assim que clicar (showdialog) caixa de dialogo flutuante
                    showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          //retornando um alerta
                          return AlertDialog(
                            //centraalizando
                            alignment: Alignment.centerLeft,
                            //wrap mesma função do colunn porem ajusta o tamanho da caixa de acordo com o conteudo.
                            content: const Wrap(
                              children: [
                                Text("Deseja sair do aplicativo?"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Não")),
                              //pushReplacement vai sair e substituir a tela
                              TextButton(
                                  onPressed: () {
                                    AutentificacaoUsuario().deslogar().then(
                                        (User) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            )));
                                  },
                                  child: const Text("Sim"))
                            ],
                          );
                        });
                  },
                ),
              ),
            )
          ]),
        )),
      ),
    );
  }
}
