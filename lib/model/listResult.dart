import 'package:final_navi_task/model/vehicle.dart';

class ListResult {
  //vehicles list
  final List<VehicleModel> listResult;

  ListResult({this.listResult});

  factory ListResult.fromJson(Map<String, dynamic> jsonData) {
    final jsonList = jsonData["Result"] as List; //Get json as a List
    List<VehicleModel> list = jsonList
        .map((e) => VehicleModel.fromJson(e))
        .toList(); // Convert jsonList to list of VehicleModel objects
    print(list.length);
    return ListResult(
      listResult: list,
    );
  }
}
