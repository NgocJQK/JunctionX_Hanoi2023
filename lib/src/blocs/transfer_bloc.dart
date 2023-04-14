import 'dart:async';
import '../validators/validations.dart';

class TransferBloc {
  StreamController _moneyController = new StreamController();
  StreamController _contentController = new StreamController();

  Stream get moneyStream => _moneyController.stream;
  Stream get contentStream => _contentController.stream;

  bool isValidInfo(String money, String content) {
    return (content != "");
  }

  void dispose() {
    _moneyController.close();
    _contentController.close();
  }
}