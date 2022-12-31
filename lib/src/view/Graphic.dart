import 'package:firebase_test/src/model/Data.dart';
import 'package:firebase_test/src/model/DataGraphic.dart';
import 'package:firebase_test/src/model/Firebase.dart';
import 'package:firebase_test/src/viewModel/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
            Text("ERROR. Go back and try again later");
          }
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Scaffold(
                body: Center(
                    child: Container(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: lineChart(data, context)))));
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        }));
  }

  Widget lineChart(data, context) {
    return SfCartesianChart(primaryXAxis: NumericAxis(), series: <ChartSeries>[
      // Renders line chart
      LineSeries<DataGraphic, int>(
          dataSource: getDataSource(data, context),
          xValueMapper: (DataGraphic data, _) => data.x,
          yValueMapper: (DataGraphic data, _) => data.num)
    ]);
  }

  List<DataGraphic> getDataSource(data, context) {
    List<DataGraphic> list = Provider.of<HomeController>(context, listen: false)
        .getGraphicData(data);
    return list;
  }
}
