import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final List<ValUser> valUser;

    UserModel({
        required this.valUser,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        valUser: List<ValUser>.from(json["ValUser"].map((x) => ValUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ValUser": List<dynamic>.from(valUser.map((x) => x.toJson())),
    };
}

class ValUser {
    final String usuario;
    final String passwd;
    final String nombre;

    ValUser({
        required this.usuario,
        required this.passwd,
        required this.nombre,
    });

    factory ValUser.fromJson(Map<String, dynamic> json) => ValUser(
        usuario: json["Usuario"],
        passwd: json["Passwd"],
        nombre: json["Nombre"],
    );

    Map<String, dynamic> toJson() => {
        "Usuario": usuario,
        "Passwd": passwd,
        "Nombre": nombre,
    };
}
