import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanjivani/config/palette.dart';

class GovtInfoScreen extends StatefulWidget {
  @override
  _GovtInfoScreenState createState() => _GovtInfoScreenState();
}

class _GovtInfoScreenState extends State<GovtInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildYourOwnTest(screenHeight),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Notifications',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            padding: const EdgeInsets.all(10.0),
            height: screenHeight * 0.20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFAD9FE4), Palette.primaryColor],
              ),
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
                        '29 Sept 2020',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Revised guidelines for international Arrivals',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    Icon(
                      Icons.link,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: screenHeight * 0.01,
                    ),
                    Text(
                      'https://www.mohfw.gov.in/pdf/RevisedguidelinesforInternationalArrivals02082020.pdf',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
