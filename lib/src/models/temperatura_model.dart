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
    id: (data['_id'] == null )? [] : data['_id'],
    fecha: (data['fecha'] == null) ? [] : data['fecha'],
    hora: (data['hora']== null) ? [] : data['hora'],
    temperatura: (data['temperatura']/1 == null) ? [] : data['temperatura']/1,
    temperaturaAlta: (data['temperaturalta']/1 == null) ? [] : data['temperaturalta']/1,
    temperaturaMedia: (data['temperaturamedia']/1 == null) ? [] : data['temperaturamedia']/1

  );
}
