class PetAction {
  final String accion;
  final String fecha;
  final String hora;
  final String index;
  bool selected;

  PetAction(
      {required this.accion,
      required this.fecha,
      required this.hora,
      required this.index,
      required this.selected});

  factory PetAction.fromJson(Map<String, dynamic> json) {
    return PetAction(
        accion: json['accion'],
        fecha: json['fecha'],
        hora: json['hora'],
        index: json['index'],
        selected: false);
  }
}

class PetActionList {
  final List<dynamic> actions;

  const PetActionList({
    required this.actions,
  });

  factory PetActionList.fromJson(List<dynamic> json) {
    var list = [];
    for (var element in json) {
      var act = PetAction(
          accion: element['accion'],
          fecha: element['fecha'],
          hora: element['hora'],
          index: element['index'],
          selected: false);
      list.add(act);
    }
    return PetActionList(actions: list);
  }
}
