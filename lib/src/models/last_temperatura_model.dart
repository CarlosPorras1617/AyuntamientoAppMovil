class LastTemperaturasModel{
  String ? id;
  String ? fecha;
  String ? hora;
  double ? temperatura;
  double ? temperaturaAlta;
  double ? temperaturaMedia;

  LastTemperaturasModel({
    this.id,
    this.fecha,
    this.hora,
    this.temperatura,
    this.temperaturaAlta,
    this.temperaturaMedia
  });

  factory LastTemperaturasModel.fromMapJson(Map<String, dynamic>data)=>LastTemperaturasModel(
    id: (data['_id'] == null )? [] : data['_id'],
    fecha: (data['fecha'] == null) ? [] : data['fecha'],
    hora: (data['hora']== null) ? [] : data['hora'],
    temperatura: (data['temperatura']/1 == null) ? [] : data['temperatura']/1,
    temperaturaAlta: (data['temperaturalta']/1 == null) ? [] : data['temperaturalta']/1,
    temperaturaMedia: (data['temperaturamedia']/1 == null) ? [] : data['temperaturamedia']/1
  );
}