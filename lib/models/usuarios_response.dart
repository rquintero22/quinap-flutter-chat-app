// To parse this JSON data, do
//
//     final usuariosListaResponse = usuariosListaResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/usuario.dart';

UsuariosListaResponse usuariosListaResponseFromJson(String str) =>
    UsuariosListaResponse.fromJson(json.decode(str));

String usuariosListaResponseToJson(UsuariosListaResponse data) =>
    json.encode(data.toJson());

class UsuariosListaResponse {
  UsuariosListaResponse({
    this.ok,
    this.usuarios,
    this.total,
  });

  bool ok;
  List<Usuario> usuarios;
  int total;

  factory UsuariosListaResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosListaResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(
            json["usuarios"].map((x) => Usuario.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
        "total": total,
      };
}
