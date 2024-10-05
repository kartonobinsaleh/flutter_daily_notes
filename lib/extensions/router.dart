import 'package:flutter/material.dart';

extension RouterManager on BuildContext {
  Future<T?> offAll<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  Future<T?> to<T>(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  back() => Navigator.of(this).pop();
  Future<T?> off<T>(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
