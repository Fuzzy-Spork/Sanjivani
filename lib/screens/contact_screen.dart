import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContactScreen extends StatelessWidget {
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
                ContactBlock(size: size),
                ContactBlock(size: size),
                ContactBlock(size: size),
                ContactBlock(size: size),
                ContactBlock(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactBlock extends StatelessWidget {
  const ContactBlock({
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
                  'Uttar Pradesh',
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
              Text(
                '7272028119',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
                maxLines: 2,
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
