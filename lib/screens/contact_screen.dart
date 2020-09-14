import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future getData() async {
    final response =
        await http.get('https://api.rootnet.in/covid19-in/contacts');
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
        data = data["data"]['contacts']['regional'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getContactWidgets() {
      List<Widget> list = [];
      for (int i = 0; i < data.length; i++) {
        list.add(ContactBlock(
          number: (data[i]['number']).toString().split(',').first,
          state: data[i]['loc'],
          size: size,
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
          child: data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.05, left: size.width * 0.05),
                    child: Text(
                      'Contact and',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.01, left: size.width * 0.05),
                    child: Text(
                      'Helpline',
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
                      child: ListView(
                    children: getContactWidgets(),
                  ))
                ]
                  //getContactWidgets(),
                  ),
        ),
      ),
    );
  }
}

class ContactBlock extends StatelessWidget {
  final String state;
  final String number;
  const ContactBlock({
    Key key,
    this.state,
    this.number,
    @required this.size,
  }) : super(key: key);

  final Size size;
  _launchCaller(String number) async {
    var url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      padding: const EdgeInsets.all(10.0),
      height: size.height * 0.14,
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
                  state,
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
              Icon(
                Icons.local_phone,
                size: 20,
                color: Colors.black87,
              ),
              SizedBox(
                width: size.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  _launchCaller(number);
                },
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 2,
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
