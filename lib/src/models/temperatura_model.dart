class TemperaturasModel{
  String ? id;
  String ? fecha;
  String ? hora;
  double ? temperatura;
  double ? temperaturaAlta;
  double ? temperaturaMedia;

  TemperaturasModel({
    this.id,
    this.fecha,
    this.hora,
    this.temperatura,
    this.temperaturaAlta,
    this.temperaturaMedia
  });

  factory TemperaturasModel.fromMapJson(Map<String, dynamic>data)=>TemperaturasModel(
    id: data['_id'],
    fecha: data['fecha'],
    hora: data['hora'],
    temperatura: (data['temperatura'] == null) ? 0 : data['temperatura']/1,
    temperaturaAlta: (data['temperaturalta'] == null) ? 0 : data['temperaturalta']/1,
    temperaturaMedia: (data['temperaturamedia'] == null) ? 0 : data['temperaturamedia']/1
  );
}
