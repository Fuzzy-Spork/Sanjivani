import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GovtInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.05, left: size.width * 0.05),
                  child: Text(
                    'Notification and Govt',
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
                InfoBlock(size: size),
                InfoBlock(size: size),
                InfoBlock(size: size),
                InfoBlock(size: size),
                InfoBlock(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoBlock extends StatelessWidget {
  const InfoBlock({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
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
                  '12 Sept 2020',
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
              Text(
                'Latest Advisory from Goverment 2020',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
              ),
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
                    Padding(
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
                    Padding(
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
