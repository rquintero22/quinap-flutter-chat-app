import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/custom_labels.dart';
import 'package:chat/widgets/custom_logo.dart';
import 'package:chat/widgets/custom_buttom_blue.dart';
import 'package:chat/helpers/mostrar_alerta.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Messenger', logo: 'assets/tag-logo.png'),
                _Form(),
                Labels(
                  route: 'register',
                  titulo: '¿No tienes cuenta?',
                  subtitulo: '¡Crea una ahora!',
                ),
                Text('Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authSrv = Provider.of<AuthService>(context);
    final socketSrv = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          // CustomInput(),
          CustomButtonBlue(
              text: 'Ingrese',
              onPressed: authSrv.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authSrv.login(
                          emailCtrl.text.trim(), passCtrl.text.trim());
                      if (loginOk) {
                        socketSrv.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(context, 'Credenciales inválidas',
                            'Valide la información ingresada');
                      }
                    })
        ],
      ),
    );
  }
}
