import 'package:flutter/foundation.dart';

class ChatProvider extends ChangeNotifier {

  final List<String> messages = ["This is the first message", "hello there, how are you", "nothin new ?",];
  void addMessage(String message) {
    messages.add(message);
    notifyListeners();
  }
}
