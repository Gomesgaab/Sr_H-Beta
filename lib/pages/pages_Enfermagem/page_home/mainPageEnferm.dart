import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/navBar_key.dart';
import 'package:flutter_srh_application/pages/page_ArquivoProntuario/page_paste_prontuario.dart';
import 'package:flutter_srh_application/pages/pages_Enfermagem/page_prontuario/prontuario_pageEnferm.dart';
import 'package:flutter_srh_application/shared/page_user_med.dart';

class MainPageEnferm extends StatefulWidget {
  const MainPageEnferm({super.key});

  @override
  State<MainPageEnferm> createState() => _MainPageEnfermState();
}

class _MainPageEnfermState extends State<MainPageEnferm> {
  //definindo páginas de paginação
  final screens = [
    PageUser(),
    PageProntuarioEnferm(),
    PagePastepront(),
  ];
  //definindo número da pagina index
  int selectedindex = 1;
  @override
  Widget build(BuildContext context) {
    //area  separada
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: const Color.fromARGB(145, 200, 228, 1000),
          actions: [
            // logo
            Container(
              margin: EdgeInsets.only(left: 20),
              child: const Text(
                "Enfermagem",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(child: Container(),),
            Image.asset(
              'asset/Logo.png',
              height: 67.6,
            ),

            const SizedBox(
              width: 10,
            ),
            const Text(
              "Sr .H",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
        
        body: screens[selectedindex],

        //iniciando Navgation bar
        bottomNavigationBar: CurvedNavigationBar(
          //chave de controle
          key: NavBarKey.getkey(),
          //selecionando página index
          index: selectedindex,
          items: <Widget>[
            //icones de navegação
            Icon(Icons.person_2, size: 30),
            Icon(Icons.dock, size: 30),
            Icon(Icons.home_filled, size: 30),
          ],
          animationDuration: Duration(milliseconds: 600),
          animationCurve: Curves.easeOut,
          backgroundColor: const Color.fromARGB(145, 200, 228, 1000),
          height: 70,
          onTap: (index) => setState(() {
            selectedindex = index;
          }),
        ),
      ),
    );
  }
}
