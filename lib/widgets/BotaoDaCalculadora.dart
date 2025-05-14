import 'package:flutter/material.dart';

Widget BotaoDaCalculadora(String txt, VoidCallback onpressed) {
  return FilledButton(
    style: estiloBotaoNumero(),
    onPressed: onpressed,
    child: Text(
      txt,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

ButtonStyle estiloBotaoNumero() {
  return FilledButton.styleFrom(
    backgroundColor: const Color.fromARGB(29, 179, 160, 216),
    padding: EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
