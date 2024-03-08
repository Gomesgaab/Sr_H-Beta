import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_srh_application/pages/paginacao/prontuario_page.dart';
import 'package:flutter_srh_application/shared/componentes/menu_custon.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
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
        drawer: const CustonMenu(),
        //menu lateral
        //construindo body/corpo
        body: Expanded(
          child: PageView(
            controller: controller,
            children: [
              Container(
                color: const Color.fromARGB(145, 200, 228, 1000),
              ),
              const PageProntuario(),
              
            ],
          ),
        ),

        //iniciando Navif=gation bar
        bottomNavigationBar: CurvedNavigationBar(
          items: const <Widget>[
            Icon(Icons.dock, size: 30),
            Icon(Icons.home_filled, size: 30),
            Icon(Icons.list, size: 30)
          ],
          backgroundColor: const Color.fromARGB(145, 200, 228, 1000),
          height: 70,
          onTap: (page) => setState(() {
            controller.animateToPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
                page);
          }),
        ),
      ),
    );
  }
}
