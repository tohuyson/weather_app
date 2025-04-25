// ignore_for_file: non_constant_identifier_names

class GeneralObject {
  GeneralObject({
    this.ID,
    this.id,
    this.name,
    this.value,
    this.code,
  });

  GeneralObject.fromJson(dynamic json) {
    ID = json['ID'];
    id = json['id'];
    name = json['name'];
    value = json['value'];
    code = json['code'];
  }

  int? ID;
  int? id;
  String? name;
  int? value;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = ID;
    map['id'] = id;
    map['name'] = name;
    map['value'] = value;
    map['code'] = code;
    return map;
  }
}