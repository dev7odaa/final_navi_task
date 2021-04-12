import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:final_navi_task/model/listResult.dart';
import 'package:final_navi_task/model/vehicle.dart';


class CarApi {
  static Future<List<VehicleModel>> fetchRequests() async {
    //request body
    Map map = new Map<String, dynamic>();
    map["do"] = "getVehicles";
    map["token"] = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";

    String carUrl = "https://www.ebda3-eg.com/test/";
    http.Response response = await http.post(carUrl, body: json.encode(map));

    if (response.statusCode == 200) {
      String data = response.body;
      var jsonData = jsonDecode(data);

      return ListResult.fromJson(jsonData).listResult;
    }
    return [];
  }
}
