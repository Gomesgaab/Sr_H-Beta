import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/pages_Atendente/page_Home/mainPageAtendent.dart';
import 'package:flutter_srh_application/pages/pages_Enfermagem/page_home/mainPageEnferm.dart';
import 'package:flutter_srh_application/pages/pages_Medico/page_home/mainPageMed.dart';
import 'package:flutter_srh_application/pages/pages_triagem/page_home/mainPageTriagem.dart';
import 'package:flutter_srh_application/service/authUser.dart';
import 'package:flutter_srh_application/shared/componentes/snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  AutentificacaoUsuario _autenMedico = AutentificacaoUsuario();
  // iniciando intancia do fireBase FireStore
  final db = FirebaseFirestore.instance;
  var emailControler = TextEditingController();
  //criando variavel de controle de endereco
  var senhaControler = TextEditingController();
  bool isObscureText = true;
  //variavel de ação do botão entrar
  bool queroEntrar = true;
  //variavel da chave de controle do formulário
  final _formKey = GlobalKey<FormState>();

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
                        image: AssetImage('asset/loginUsuario.webp'),
                        fit: BoxFit.cover)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    children: [
                      Padding(
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
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 95),
                        width: double.infinity,
                      ),
                      //iniciando container email
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          //chave de formulário
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 260,
                                child: TextFormField(
                                  //controle de entrada de dados
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
                                          //limpar caixa der texto
                                          emailControler.clear();
                                        });
                                      },
                                      child: const Icon(Icons.clear),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(top: 0, left: 20),
                                  ),
                                  //validando campo
                                  validator: (
                                    String? value,
                                  ) {
                                    //validação de campo vazio
                                    if (value == null) {
                                      return "O em-mail não pode ser vazio";
                                    }
                                    //validação de tamanho
                                    if (value.length < 5) {
                                      return "E-mail deve conter mais de cinco caaracteres";
                                    }
                                    //validação de e-mail
                                    if (!value.contains("@")) {
                                      return "O e-mail informado não e valido";
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
                                  //controle de senha
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
                                    //validação de campo vazio
                                    if (value == null) {
                                      return "a senha não pode ser vazia";
                                    }
                                    //validação de tamanho da senha com exigência do fireauth
                                    if (value.length < 6) {
                                      return "A senha deve ter pelo menos 6 caracteres";
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
                                  //validando acesso
                                  if (queroEntrar = queroEntrar) {
                                    setState(() {
                                      botaoPrincipalClicado();
                                    });
                                  }
                                },
                                child: Text(
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    " Entrar"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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

  //verificação e validação de dados para execução do botão
  botaoPrincipalClicado() async {
    //chamando instancia do fireauth
    var usuarioAtual = FirebaseAuth.instance.currentUser;
    var velue = emailControler.text;
    //se chave de controle de formulário ativa velirificar validações
    if (_formKey.currentState!.validate()) {
      //se quero entrar verdadeiro ou usuário atual diferente de null form valido
      if (queroEntrar || usuarioAtual != null) {
        debugPrint("Form valido");
        //chamando controle de login de usuário 
        await _autenMedico
            .logarUsuario(
                email: emailControler.text, senha: senhaControler.text)
            .then((String? erro) {
          if (erro != null) {
            //mostrando erro 
            mostrarSnackBar(context: context, texto: erro);
          } else {
            //validação de modelo de entrada como médico
            if (velue.contains("medico")) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPageMed(),
                  ));
            }
            //validação de modelo de entrada como enfermagem
            if (velue.contains("enferm")) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPageEnferm(),
                  ));
            } else {
              //validação de modelo de entrada como atendente
              if (velue.contains("atendent")) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageAtendent(),
                    ));
              }
              //validação de modelo de entrada como triagem
              if (velue.contains("triagem")) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageTriagem(),
                    ));
              }
            }
          }
        });
      }
    } else {
      //se falso não direciona para lugar nenhum
      debugPrint("Form invalido");
    }
  }
}
