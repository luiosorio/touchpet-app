class Pet {
  final String nombre;
  final String raza;
  final String tamanio;
  final String personalidad;
  final double kgs;
  final String fechaCumpleanios;
  bool selected;

  Pet(
      {required this.nombre,
      required this.raza,
      required this.tamanio,
      required this.personalidad,
      required this.kgs,
      required this.fechaCumpleanios,
      required this.selected});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        nombre: json['nombre'],
        raza: json['raza'],
        tamanio: json['tamanio'],
        personalidad: json['personalidad'],
        kgs: json['kgs'],
        fechaCumpleanios: json['fechaCumpleanios'],
        selected: false);
  }
}

class PetList {
  final List<dynamic> pets;

  const PetList({
    required this.pets,
  });

  factory PetList.fromJson(List<dynamic> json) {
    var list = [];
    for (var element in json) {
      var u = Pet(
          nombre: element['nombre'],
          raza: element['raza'],
          tamanio: element['tamanio'],
          personalidad: element['personalidad'],
          kgs: element['kgs'],
          fechaCumpleanios: element['fechaCumpleanios'],
          selected: false);
      list.add(u);
    }
    return PetList(pets: list);
  }
}
