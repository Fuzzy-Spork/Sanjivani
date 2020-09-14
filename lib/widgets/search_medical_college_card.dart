import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchMedicalCollegeCard extends StatefulWidget {
  SearchMedicalCollegeCard(
      {@required this.stateName,
      @required this.city,
      @required this.admissionCapacity,
      @required this.hospitalBeds,
      @required this.instituteName,
      @required this.type});
  final String stateName;
  final String city;
  final String type;
  final String admissionCapacity;
  final String hospitalBeds;
  final String instituteName;
  @override
  _SearchMedicalCollegeCardState createState() =>
      _SearchMedicalCollegeCardState();
}

class _SearchMedicalCollegeCardState extends State<SearchMedicalCollegeCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
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
                        'Arunanchal Pradesh',
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
                        'Rural Beds',
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
                        'Urban Hospitals',
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
                        'Urban Beds',
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
                        'Total Beds',
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
            ),
          )
        ],
      ),
    );
  }
}
