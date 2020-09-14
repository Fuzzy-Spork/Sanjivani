import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Future getData() async {
    final response =
        await http.get('https://api.rootnet.in/covid19-in/hospitals/beds');
    return jsonDecode(response.body);
  }

  var data;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  var total;

  fetch() async {
    await getData().then((value) {
      setState(() {
        data = value;
        total = data["data"]["summary"];
        data = data["data"]['regional'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getInfoWidgets() {
      List<Widget> list = [];
      for (int i = 0; i < data.length; i++) {
        list.add(HospitalBedBlocks(
          state: data[i]['state'],
          ruralBeds: data[i]['ruralBeds'],
          ruralHospitals: data[i]['ruralHospitals'],
          urbanBeds: data[i]['urbanBeds'],
          urbanHospitals: data[i]['urbanHospitals'],
          totalBeds: data[i]['totalBeds'],
          totalHospitals: data[i]['totalHospitals'],
        ));
      }
      print(list);
      return list;
    }

    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.05, left: size.width * 0.05),
            child: Text(
              'Hospitals',
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
              '& Beds',
              style: TextStyle(
                color: Colors.black87,
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFecf4f3),
                ),
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: total == null
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rural Hospitals',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['ruralHospitals'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rural Beds',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['ruralBeds'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Urban Hospitals',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['urbanHospitals'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Urban Beds',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['urbanBeds'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Hospitals',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['totalHospitals'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Beds',
                                  style: TextStyle(
                                    color: Color(0xFF006a71),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  total['totalBeds'].toString(),
                                  style: TextStyle(
                                    color: Color(0xFFff7e67),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
          data == null
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView(
                    children: getInfoWidgets(),
                  ),
                )
        ],
      )),
    );
  }
}

class HospitalBedBlocks extends StatelessWidget {
  final String state;
  final int ruralHospitals;
  final int ruralBeds;
  final int urbanBeds;
  final int urbanHospitals;
  final int totalHospitals;
  final int totalBeds;

  HospitalBedBlocks(
      {this.state,
      this.ruralHospitals,
      this.ruralBeds,
      this.urbanBeds,
      this.urbanHospitals,
      this.totalHospitals,
      this.totalBeds});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text(
                state,
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rural Hospitals',
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ruralHospitals.toString(),
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rural Beds',
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ruralBeds.toString(),
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Urban Hospitals',
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                urbanHospitals.toString(),
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                urbanHospitals.toString(),
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '12302',
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Hospitals',
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                totalHospitals.toString(),
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Beds',
                style: TextStyle(
                  color: Color(0xFF006a71),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                totalBeds.toString(),
                style: TextStyle(
                  color: Color(0xFFff7e67),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
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
