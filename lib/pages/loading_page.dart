import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text(
                'Espere un momento, nos encontramos validando la información'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authSrv = Provider.of<AuthService>(context, listen: false);
    final socketSrv = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authSrv.isLoggedIn();

    if (autenticado) {
      socketSrv.connect();

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    }
  }
}
