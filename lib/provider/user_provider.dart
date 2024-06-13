import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String codigo;
  String id;
  String state;
  String token;

  UserProvider({
    this.codigo = '',
    this.id = '',
    this.state = 'no-authenticated',
    this.token = ''
  });

  void changeUserEmail({
    required String newCodigo,
    required String newId,
    required String newToken,
    String? newState
  }) async {
    codigo = newCodigo;
    id = newId;
    token = newToken;
    state = newState ?? 'no-authenticated';
    notifyListeners();
  }

  void deletedUser() async {
    codigo = '';
    id = '';
    state = 'no-authenticated';
    notifyListeners();
  }
}
