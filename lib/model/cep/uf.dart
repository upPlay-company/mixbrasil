class UF {
  UF({this.id, this.initials, this.name});

  factory UF.fromJson(Map<String, dynamic> json) => UF(
    id: json['id'],
    initials: json['sigla'],
    name: json['nome'],
  );

  int id;
  String initials;
  String name;

  UF listUF;

  Future<void> loadCity(UF uf) async {

    listUF = uf;

    print(listUF);

  }

  @override
  String toString() {
    return 'UF{id: $id, initials: $initials, name: $name}';
  }
}
