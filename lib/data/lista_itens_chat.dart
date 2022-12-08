import "dart:convert";
import "package:teste/data/chat_item.dart";

class ListaItensChat {
  ListaItensChat({required this.itensChat});

  factory ListaItensChat.fromMap(Map<String, dynamic> map) => ListaItensChat(
        itensChat: List<ItemChat>.from(
            map["itensChat"].map((e) => ItemChat.fromMap(e))),
      );

  factory ListaItensChat.fromJson(String str) =>
      ListaItensChat.fromMap(json.decode(str));

  List<ItemChat> itensChat;

  Map<String, dynamic> toMap() => {
        "itensChat": itensChat.map((e) => e.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
