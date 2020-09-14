import 'dart:io' as io;

import 'package:ext_storage/ext_storage.dart';
import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/area_line_chart.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:sanjivani/models/patient_stats.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

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
    setState(() {});
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

  final doc = pw.Document();
  update() {
    getData().then((value) {
      line1 = getLine();
    });
  }

  Future getData() async {
    list = await PatientStats.listFromJson();
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String email = '';
  ScreenshotController screenshotController = ScreenshotController();
  io.File _imageFile;
  @override
  Widget build(BuildContext context) {
    LineChart lineChart;
    //print(line1.runtimeType);
    lineChart = AreaLineChart.fromDateTimeMaps(
        [line1], [Colors.red.shade900], ['C'],
        gradients: [Pair(Colors.yellow.shade400, Colors.red.shade700)],
        tapTextFontWeight: FontWeight.w900);
    TextEditingController _controller = TextEditingController();

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    RaisedButton(
                      child: Text('Print'),
                      onPressed: () async {
                        if (await Permission.storage.request().isGranted) {
                          // Either the permission was already granted before or the user just granted it.
                          screenshotController
                              .capture(pixelRatio: 1.5)
                              .then((io.File image) async {
                            //Capture Done
                            setState(() {
                              _imageFile = image;
                            });
                            doc.addPage(
                              pw.Page(
                                build: (pw.Context context) => pw.Center(
                                  child: pw.Image(PdfImage.file(doc.document,
                                      bytes: _imageFile.readAsBytesSync())),
                                ),
                              ),
                            );
                            String path = await ExtStorage
                                .getExternalStoragePublicDirectory(
                                    ExtStorage.DIRECTORY_DOWNLOADS);
                            // final output = await Environment
                            //     .getExternalStoragePublicDirectory(
                            //         Environment.DIRECTORY_DOWNLOADS);
                            final file = io.File("$path/graph.pdf");
                            await file.writeAsBytes(doc.save());
                          }).catchError((onError) {
                            print(onError);
                          });
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('Mail'),
                      onPressed: () async {
                        String path =
                            await ExtStorage.getExternalStoragePublicDirectory(
                                ExtStorage.DIRECTORY_DOWNLOADS);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            _controller.text = email;
                            return AlertDialog(
                              title: new Text("Enter Email ID"),
                              content: TextField(
                                controller: _controller,
                                textInputAction: TextInputAction.newline,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) {
                                  email = value;
                                },
                              ),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Okay"),
                                  onPressed: () async {
                                    final Email email2 = Email(
                                      body: 'This is the graph you requested.',
                                      subject: 'Your Graph',
                                      recipients: [email],
                                      attachmentPaths: [path + '/graph.pdf'],
                                      isHTML: false,
                                    );

                                    await FlutterEmailSender.send(email2);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        final output = await getTemporaryDirectory();
                        final file = io.File("${output.path}/graph.pdf");
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: line1 == null
                        ? Text('No Data')
                        : line1.values.length == 1
                            ? Text(
                                'Only one point found, not enough data to plot with the given parameters.')
                            : Screenshot(
                                controller: screenshotController,
                                child: AnimatedLineChart(
                                  lineChart,
                                  key: UniqueKey(),
                                ),
                              ),
                  ),
                ),
                SizedBox(width: 200, height: 50, child: Text('')),
              ],
            ),
    );
  }
}
