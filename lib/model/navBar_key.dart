import 'package:flutter/material.dart';

//classe de chave de controle da navbar
class NavBarKey {
  NavBarKey._();
  static final GlobalKey _key = GlobalKey();
  static GlobalKey getkey() => _key;
}