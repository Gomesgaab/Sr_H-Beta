import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/model/navBar_key.dart';
import 'package:flutter_srh_application/pages/page_ArquivoProntuario/page_paste_prontuario.dart';
import 'package:flutter_srh_application/pages/pages_Medico/page_Prontuario/prontuario_pageMed.dart';
import 'package:flutter_srh_application/shared/page_user_med.dart';

class MainPageMed extends StatefulWidget {
  const MainPageMed({super.key});

  @override
  State<MainPageMed> createState() => _MainPageMedState();
}

class _MainPageMedState extends State<MainPageMed> {
  //definindo página index
  int selectedindex = 1;
  //definindo páginas de navegação
  final screens = [
    PageUser(),
    PageProntuarioMed(),
    PagePastepront(),
  ];
  @override
  Widget build(BuildContext context) {
    //area  separada
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: const Color.fromARGB(145, 200, 228, 1000),
          actions: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: const Text(
                "Médico",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            // logo
            Expanded(child: Container()),
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

        //construindo body/corpo
        body: screens[selectedindex],

        //iniciando Navgation bar
        bottomNavigationBar: CurvedNavigationBar(
          //chave de controle 
          key: NavBarKey.getkey(),
          //definindo página index
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
