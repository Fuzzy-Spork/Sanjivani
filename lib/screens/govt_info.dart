import 'dart:convert';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sanjivani/models/notifBlock.dart';
import 'package:url_launcher/url_launcher.dart';

class GovtInfoScreen extends StatefulWidget {
  @override
  _GovtInfoScreenState createState() => _GovtInfoScreenState();
}

class _GovtInfoScreenState extends State<GovtInfoScreen> {
  Future getData() async {
    final response =
        await http.get('https://api.rootnet.in/covid19-in/notifications');
    return jsonDecode(response.body);
  }

  var data;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    await getData().then((value) {
      setState(() {
        data = value;
        data = data["data"]['notifications'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getInfoWidgets() {
      List<Widget> list = [];
      List<NotifBlock> notifs = [];
      for (int i = 0; i < data.length; i++) {
        if (int.tryParse(data[i]['title'].toString()[1]) != null) {
          notifs.add(NotifBlock(
            name: (data[i]['title'])
                .toString()
                .substring(11, data[i]['title'].toString().length),
            link: data[i]['link'],
            date: DateTime.parse((data[i]['title'])
                    .toString()
                    .substring(0, 10)
                    .substring(6, 10) +
                (data[i]['title']).toString().substring(0, 10).substring(3, 5) +
                (data[i]['title']).toString().substring(0, 10).substring(0, 2)),
          ));
          // list.add(InfoBlock(
          //   name: (data[i]['title'])
          //       .toString()
          //       .substring(11, data[i]['title'].toString().length),
          //   link: data[i]['link'],
          //   size: size,
          //   date: DateTime.parse((data[i]['title'])
          //           .toString()
          //           .substring(0, 10)
          //           .substring(6, 10) +
          //       (data[i]['title']).toString().substring(0, 10).substring(3, 5) +
          //       (data[i]['title']).toString().substring(0, 10).substring(0, 2)),
          // ));
        }
      }
      notifs.sort((a, b) => b.date.compareTo(a.date));
      for (var notif in notifs) {
        list.add(InfoBlock(
          size: size,
          name: notif.name,
          link: notif.link,
          date: notif.date,
        ));
      }
      return list;
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.width * 0.05, left: size.width * 0.05),
              child: Text(
                'Notification and Govt',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: size.height * 0.038,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.width * 0.01, left: size.width * 0.05),
              child: Text(
                'Advisories',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: size.height * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: 2,
              width: size.width * 0.5,
              child: Container(
                color: Color(0xFFff7e67),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: data == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: getInfoWidgets(),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}

class InfoBlock extends StatelessWidget {
  final String link;
  final String name;
  final DateTime date;
  InfoBlock({
    this.date,
    this.name,
    this.link,
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  String formatDate(DateTime date) =>
      new DateFormat("MMMM d, yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    _launchCaller(String link) async {
      var url = "$link";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      padding: const EdgeInsets.all(10.0),
      height: size.height * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  formatDate(date),
                  style: const TextStyle(
                    color: Color(0xFF006a71),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Expanded(
                  child: Text(
                name,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
              )),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Container(
                height: 40,
                width: size.width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFecf4f3),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.copy,
                        size: 22,
                        color: Color(0xFF006a71),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        ClipboardManager.copyToClipBoard(link).then((result) {
                          final snackBar = SnackBar(
                            content: Text('Copied to Clipboard'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Copy',
                          style: TextStyle(
                            color: Color(0xFF006a71),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 40,
                width: size.width * 0.33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFecf4f3),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.externalLinkAlt,
                        size: 21,
                        color: Color(0xFF006a71),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchCaller(link);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Open',
                          style: TextStyle(
                            color: Color(0xFF006a71),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 2,
                width: size.width * 0.3,
                child: Container(
                  color: Color(0xFF68b0ab),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
