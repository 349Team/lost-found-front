import "dart:convert";

class Mensagem {
  Mensagem({
    required this.mensagem,
    required this.sender,
    required this.timestamp,
  });

  factory Mensagem.fromMap(Map<String, dynamic> map) => Mensagem(
        mensagem: map["mensagem"],
        sender: map["sender"],
        timestamp: map["timestamp"],
      );

  factory Mensagem.fromJson(String str) => Mensagem.fromMap(json.decode(str));

  String mensagem;
  int sender;
  int timestamp;

  Map<String, dynamic> toMap() => {
        "mensagem": mensagem,
        "sender": sender,
        "timestamp": timestamp,
      };

  String toJson() => json.encode(toMap());
}
