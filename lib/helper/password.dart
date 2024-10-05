import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordHelper {
  PasswordHelper._();
  static String hash(String password) {
    final bytes = utf8.encode(password);
    final hashed = sha256.convert(bytes).toString();
    return hashed;
  }
}
