import "dart:convert";

class ItemChat {
  ItemChat({required this.id, required this.nome});

  factory ItemChat.fromMap(Map<String, dynamic> map) => ItemChat(
        id: map["id"],
        nome: map["nome"],
      );

  factory ItemChat.fromJson(String str) => ItemChat.fromMap(json.decode(str));

  int id;
  String nome;

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
      };

  String toJson() => json.encode(toMap());
}
