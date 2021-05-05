import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String logo;
  final String titulo;

  const Logo({@required this.logo, @required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 160,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Image(
              image: AssetImage(this.logo),
            ),
            Text(this.titulo, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
