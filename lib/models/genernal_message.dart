class GeneralMessage {
  GeneralMessage({
    this.id,
    this.messageOut,
    this.code,
  });

  GeneralMessage.fromJson(dynamic json) {
    id = json['id'];
    messageOut = json['message_out'];
    code = json['code'];
  }

  int? id;
  String? messageOut;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message_out'] = messageOut;
    map['code'] = code;
    return map;
  }
}
