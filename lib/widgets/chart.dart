import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:sanjivani/models/patient_stats.dart';

class LineGraph extends StatefulWidget {
  DateTime start;
  DateTime end;
  States state = States.India;
  String age = '';
  String gender;

  LineGraph({this.start, this.end, this.state, this.age, this.gender});

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  Map getLine() {
    Map<DateTime, double> dateNumbers = Map();
    for (PatientStats patient in list) {
      if (patient.status == Status.Deceased &&
          patient.reportedOn.isBefore(widget.end) &&
          patient.reportedOn.isAfter(widget.start)) {
        if (widget.gender == 'All Genders' || patient.gender == widget.gender) {
          if (widget.state == patient.state || widget.state == States.India) {
            if (widget.age == 'All Ages') {
              if (dateNumbers.containsKey(patient.reportedOn)) {
                dateNumbers[patient.reportedOn]++;
              } else {
                dateNumbers[patient.reportedOn] = 1;
              }
            } else {
              if (widget.age == '70+') {
                if (patient.ageEstimate >= 70) {
                  if (dateNumbers.containsKey(patient.reportedOn)) {
                    dateNumbers[patient.reportedOn]++;
                  } else {
                    dateNumbers[patient.reportedOn] = 1;
                  }
                }
              } else {
                if (widget.age == '0-9') {
                  continue;

                  if (patient.ageEstimate >= 1 && patient.ageEstimate <= 9) {
                    if (dateNumbers.containsKey(patient.reportedOn)) {
                      dateNumbers[patient.reportedOn]++;
                    } else {
                      dateNumbers[patient.reportedOn] = 1;
                    }
                  }
                } else {
                  if (widget.age == '10-19') {
                    if (patient.ageEstimate >= 10 &&
                        patient.ageEstimate <= 19) {
                      if (dateNumbers.containsKey(patient.reportedOn)) {
                        dateNumbers[patient.reportedOn]++;
                      } else {
                        dateNumbers[patient.reportedOn] = 1;
                      }
                    }
                  } else {
                    if (widget.age == '20-29') {
                      print('YESSSSS\n\n\n\n\n\n');
                      if (patient.ageEstimate >= 20 &&
                          patient.ageEstimate <= 29) {
                        if (dateNumbers.containsKey(patient.reportedOn)) {
                          dateNumbers[patient.reportedOn]++;
                        } else {
                          dateNumbers[patient.reportedOn] = 1;
                        }
                      }
                    } else {
                      if (widget.age == '30-39') {
                        if (patient.ageEstimate >= 30 &&
                            patient.ageEstimate <= 39) {
                          if (dateNumbers.containsKey(patient.reportedOn)) {
                            dateNumbers[patient.reportedOn]++;
                          } else {
                            dateNumbers[patient.reportedOn] = 1;
                          }
                        }
                      } else {
                        if (widget.age == '40-49') {
                          if (patient.ageEstimate >= 40 &&
                              patient.ageEstimate <= 49) {
                            if (dateNumbers.containsKey(patient.reportedOn)) {
                              dateNumbers[patient.reportedOn]++;
                            } else {
                              dateNumbers[patient.reportedOn] = 1;
                            }
                          }
                        } else {
                          if (widget.age == '50-59') {
                            if (patient.ageEstimate >= 50 &&
                                patient.ageEstimate <= 59) {
                              if (dateNumbers.containsKey(patient.reportedOn)) {
                                dateNumbers[patient.reportedOn]++;
                              } else {
                                dateNumbers[patient.reportedOn] = 1;
                              }
                            }
                          } else {
                            if (widget.age == '60-69') {
                              if (patient.ageEstimate >= 60 &&
                                  patient.ageEstimate <= 69) {
                                if (dateNumbers
                                    .containsKey(patient.reportedOn)) {
                                  dateNumbers[patient.reportedOn]++;
                                } else {
                                  dateNumbers[patient.reportedOn] = 1;
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    setState(() {
      dateNumbers.forEach((key, value) {
        print('$key : $value');
      });
    });
    return dateNumbers;
  }

  List list;

  Map<DateTime, double> line1;

  @override
  void initState() {
    super.initState();
    update();
  }

  @override
  void didUpdateWidget(LineGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != oldWidget.start ||
        widget.end != oldWidget.end ||
        widget.age != oldWidget.age ||
        widget.gender != oldWidget.gender ||
        widget.state != oldWidget.state) {
      update();
    }
  }

  update() {
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
      child: line1.isEmpty
          ? Center(child: Text('No Deceased People in the given parameters'))
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    child: line1 == null
                        ? Text('No Data')
                        : AnimatedLineChart(
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
