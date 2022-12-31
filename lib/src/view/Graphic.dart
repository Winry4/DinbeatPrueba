import 'package:firebase_test/src/model/Data.dart';
import 'package:firebase_test/src/model/DataGraphic.dart';
import 'package:firebase_test/src/model/Firebase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:fl_chart/fl_chart.dart';

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
                body: Center(child: Container(child: lineChart(data))));
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        }));
  }

  Widget lineChart(data) {
    return SfCartesianChart(primaryXAxis: NumericAxis(), series: <ChartSeries>[
      // Renders line chart
      LineSeries<DataGraphic, int>(
          dataSource: getGraphicData(data),
          xValueMapper: (DataGraphic data, _) => data.x,
          yValueMapper: (DataGraphic data, _) => data.num)
    ]);
  }

  List<DataGraphic> getGraphicData(listData) {
    List<DataGraphic> listG = [];
    print("getGraphicData ");
    int x = 0;
    print(listData.length);
    for (int i = 0; i < listData.length; i++) {
      print("New Data");
      List<String> arrayN = listData[i].value_Array_number.split(", ");
      for (int j = 0; j < arrayN.length; j++) {
        listG.add(DataGraphic(x, int.parse(arrayN[j])));
        x++;
      }
    }

    return listG;
  }
}
