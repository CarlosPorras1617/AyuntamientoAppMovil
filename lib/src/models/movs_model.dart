class MovimientosModel {
  String ? id;
  String ? fecha;
  String ? hora;
  String ? foto;

  MovimientosModel({
    this.id,
    this.fecha,
    this.hora,
    this.foto
  });

  factory MovimientosModel.fromMapJson(Map<String, dynamic> data) => MovimientosModel(
    id: (data['_id'] == null) ? [] : data['_id'],
    fecha: (data['fecha'] == null) ? [] : data['fecha'],
    hora: (data['hora'] == null) ? [] : data['hora'],
    foto: (data['foto'] == null ) ? [] : data['foto']
  );
}