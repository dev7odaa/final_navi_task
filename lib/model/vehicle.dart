class VehicleModel {
  int id;
  String name, photo;

  VehicleModel({this.id, this.name, this.photo});

//convert json to object
  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      VehicleModel(id: json["ID"], name: json["Name"], photo: json["Photo"]);
}
