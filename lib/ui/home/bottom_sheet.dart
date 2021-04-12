import 'package:flutter/material.dart';
import 'package:final_navi_task/api/carApi.dart';
import 'package:final_navi_task/model/vehicle.dart';

class CarBottomSheet extends StatefulWidget {
  @override
  _CarBottomSheetState createState() => _CarBottomSheetState();
}

class _CarBottomSheetState extends State<CarBottomSheet> {
  var _future;
  List<VehicleModel> vehicls;
  double height, width;
  @override
  void initState() {
    _future = CarApi.fetchRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return //ButtomSheet
        Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: height / 3.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
          ),
        ),
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              vehicls = snapshot.data;
              return Column(
                children: [
                  imageListView(),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: Colors.grey,
                      thumbColor: Colors.blue,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 15.0),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Slider(
                        value: 170,
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {},
                      ),
                    ),
                  ),
                  distanceRow(),
                  //Button Book Now
                  Container(
                    width: width,
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: ElevatedButton(
                      child: Text('Book Now'),
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text("Something wrong happend."));
            }
            return Center(
                child: Container(
                    height: 50, width: 50, child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  Widget imageListView() => Container(
        width: width,
        height: 120,
        child: Center(
          child: ListView.builder(
            itemCount: vehicls.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, int index) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: Image.network(
                      vehicls[index].photo,
                      height: 70,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(vehicls[index].name ?? ""),
                ],
              ),
            ),
          ),
        ),
      );
  Widget distanceRow() => //Row of Distance
      Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 5,
              ),
              child: Text(
                'Distance:',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                '5.2km',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                '|',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ),
            Text(
              '10min',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '60 EGP',
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      );
}
