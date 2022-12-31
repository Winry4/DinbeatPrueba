import 'package:firebase_test/src/model/Data.dart';
import 'package:firebase_test/src/model/DataGraphic.dart';
import 'package:firebase_test/src/model/Firebase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphic extends StatelessWidget {
  Graphic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Data>>(
        stream: Firebase.readData(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            print("Snapshot ERrror");
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Scaffold(
                body: Center(
                    child: Container(
                        child: SfCartesianChart(
                            primaryXAxis: DateTimeAxis(),
                            series: <ChartSeries>[
                  // Renders line chart
                  LineSeries<DataGraphic, int>(
                      dataSource: getGraphicData(data),
                      xValueMapper: (DataGraphic data, _) => data.x,
                      yValueMapper: (DataGraphic data, _) => data.num)
                ]))));
          } else {
            print("ELSEE");
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        }));
  }

  List<DataGraphic> getGraphicData(listData) {
    List<DataGraphic> listG = [];
    print("getGraphicData ");
    int i = 0;
    print(listData.length);
    listData.map((e) {
      print("New Data");
      List<String> arrayN = e.value_Array_number.split(", ");
      arrayN.map((array) {
        print("array ");
        print(array);
        listG.add(DataGraphic(i, int.parse(array)));
        i++;
      });
    });

    return listG;
  }
}
