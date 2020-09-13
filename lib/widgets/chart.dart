import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:sanjivani/models/patient_stats.dart';

class LineGraph extends StatefulWidget {
  DateTime start;
  DateTime end;
  String state;
  String age;
  String gender;

  LineGraph({this.start, this.end, this.state, this.age, this.gender});

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  Map getLine() {
    Map<DateTime, double> dateNumbers = Map();
    for (PatientStats patient in list) {
      if (patient.status == Status.Deceased) {
        if (DateTime.parse('20200500').difference(patient.reportedOn).inDays <
            100) {
          if (dateNumbers.containsKey(patient.reportedOn)) {
            dateNumbers[patient.reportedOn]++;
          } else {
            dateNumbers[patient.reportedOn] = 1;
          }
        }
      }
    }
    setState(() {
      print('jabjkbfkasj$dateNumbers');
    });
    print(dateNumbers.runtimeType);

    return dateNumbers;
  }

  List list;

  Map<DateTime, double> line1;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      line1 = getLine();
    });
  }

  Future getData() async {
    list = await PatientStats.listFromJson();
  }

  @override
  Widget build(BuildContext context) {
    LineChart lineChart;
    //print(line1.runtimeType);

    lineChart = AreaLineChart.fromDateTimeMaps(
        [line1], [Colors.red.shade900], ['C'],
        gradients: [Pair(Colors.yellow.shade400, Colors.red.shade700)],
        tapTextFontWeight: FontWeight.w900);

    return Container(
      height: 375.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: line1 == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Deceased',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AnimatedLineChart(
                      lineChart,
                      key: UniqueKey(),
                    ),
                  ),
                ),
                SizedBox(width: 200, height: 50, child: Text('')),
              ],
            ),
    );
  }
}
