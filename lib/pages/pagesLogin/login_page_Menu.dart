import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pagesLogin/LoginAtendente.dart';
import 'package:flutter_srh_application/pages/pagesLogin/LoginEnfermagem.dart';
import 'package:flutter_srh_application/pages/pagesLogin/LoginMedicoPage.dart';

class LoginPageMenu extends StatefulWidget {
  const LoginPageMenu({super.key});

  @override
  State<LoginPageMenu> createState() => _LoginPageMenu();
}

class _LoginPageMenu extends State<LoginPageMenu> {
  var emailControler = TextEditingController();
  var senhaControler = TextEditingController();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // alterando cor de fundo da tela inteira
        backgroundColor: const Color.fromARGB(255, 188, 218, 232),
        // responsividade
        body: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/loginimage.png'),
                      fit: BoxFit.cover)),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  //MediaQuery e um metodo de pegar o tamanho do dispositivo
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //alinhamento
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              "asset/Logo.png",
                              height: 70,
                            ),
                          ),
                          const Text(
                            "Sr.H",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                    ),
                    // formulario de opções de entrada
                    Form(
                        child: Container(
                      width: 250,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 50, right: 50),
                              ),
                              onPressed: () {
                                //Navegação entre as página cadastro
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ConfirmarAtendente()));
                              },
                              child: const Text(
                                "Recepcionasta",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 45, right: 45),
                              ),
                              onPressed: () {
                                //Navegação entre as página cadastro
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ConfirmarEnfermagem()));
                              },
                              child: const Text(
                                "Enfermagem",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 70, right: 70)),
                              onPressed: () {
                                //Navegação entre as página cadastro
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ConfirmarMedico()));
                              },
                              child: const Text(
                                "Médico",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
