import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pagesLogin/login_page_Menu.dart';
import 'package:flutter_srh_application/pages/pages_home/mainPage.dart';
import 'package:flutter_srh_application/service/authUser.dart';
import 'package:flutter_srh_application/shared/componentes/snackbar.dart';

class ConfirmarEnfermagem extends StatefulWidget {
  const ConfirmarEnfermagem({super.key});

  @override
  State<ConfirmarEnfermagem> createState() => _ConfirmarEnfermagemState();
}

class _ConfirmarEnfermagemState extends State<ConfirmarEnfermagem> {
  // iniciando intancia do fireBase
  final db = FirebaseFirestore.instance;
  var coremControler = TextEditingController();
  //criando variavel de controle de e-mail
  var emailControler = TextEditingController();
  //criando variavel de controle de senha
  var senhaControler = TextEditingController();
  bool isObscureText = true;
  // variavel de controle de entrada
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();
  AutentificacaoUsuario _autenEnfermagem = AutentificacaoUsuario();
  // variavel de validação de email

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 188, 218, 232),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            //MediaQuery e um metodo de pegar o tamanho do dispositivo
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/fundocadastro.png'),
                        fit: BoxFit.cover)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon:
                                  const Icon(color: Colors.black, Icons.clear),
                              label: const Text(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  "Login Emfermagem"),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 130),
                        width: double.infinity,
                      ),
                      //iniciando container email
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  controller: emailControler,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 200, 228, 232))),
                                    fillColor: const Color.fromARGB(
                                        255, 200, 228, 232),
                                    filled: true,
                                    label: const Text("Email:"),
                                    prefixIcon: const Icon(Icons.email),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          emailControler.clear();
                                        });
                                      },
                                      child: const Icon(Icons.clear),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(top: 0, left: 20),
                                  ),
                                  //falidando campo
                                  validator: (String? value) {
                                    if (value == null) {
                                      return "O em-mail não pode ser vazio";
                                    }

                                    if (value.length< 5) {
                                      return "E-mail deve conter mais de cinco caaracteres";
                                    }
                                    if (!value.contains("@")) {
                                      return "O e-mail informado não e valido";
                                    }
                                    if (value.contains("medico") ){
                                      return "E-mail não e desta área de login";
                                    }
                                    if (value.contains("atend") ){
                                      return "E-mail não e desta área de login";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              //Inicio Text form senha
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  controller: senhaControler,
                                  obscureText: isObscureText,
                                  onChanged: (value) {
                                    debugPrint(value);
                                  },
                                  // decorando caixa de entrada de texto
                                  decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  // cor da borda do imput
                                                  Color.fromARGB(
                                                      255, 200, 228, 232))),
                                      fillColor:
                                          //cor de fundo
                                          const Color.fromARGB(
                                              255, 200, 228, 232),
                                      //permitindo cor de fundo
                                      filled: true,
                                      contentPadding: const EdgeInsets.only(
                                          top: 0, left: 10),
                                      //cor icon
                                      iconColor:
                                          const Color.fromARGB(255, 0, 0, 0),

                                      //estamos detectando ações para executar algo
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: GestureDetector(
                                        //um clique
                                        onTap: () {
                                          setState(() {
                                            //escondendo texto (!isObscureText negação oposto do que ele vale)
                                            isObscureText = !isObscureText;
                                          });
                                        },
                                        // utilizando ternário para execução de ação
                                        child: Icon(isObscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                      label: const Text("Senha")),
                                  validator: (value) {
                                    if (value == null) {
                                      return "a senha não pode conter menos de 6 caracteres";
                                    }
                                    return null;
                                  },
                                ),
                              ), //fim  senha

                              const SizedBox(
                                height: 50,
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 60, right: 60),
                                ),
                                onPressed: () {
                                  if (queroEntrar = queroEntrar) {
                                    setState(() {
                                      botaoPrincipalClicado();
                                    });
                                  } else {
                                    setState(() {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPageMenu(),
                                          ));
                                    });
                                  }
                                },
                                child: Text(
                                    style: const TextStyle(fontSize: 20),
                                    (queroEntrar) ? " Entrar" : "Sair"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    queroEntrar = !queroEntrar;
                                  });
                                },
                                child: Text(
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    (queroEntrar)
                                        ? "Deseja Sair?"
                                        : " Deseja Entrar?"),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "asset/Logo.png",
                                height: 70,
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  botaoPrincipalClicado() {
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        debugPrint("Form valido");
        _autenEnfermagem
            .logarUsuario(
                email: emailControler.text, senha: senhaControler.text)
            .then((String? erro) {
          if (erro != null) {
            mostrarSnackBar(context: context, texto: erro);
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ));
          }
        });
      }
    } else {
      debugPrint("Form valido");
    }
  }
}
