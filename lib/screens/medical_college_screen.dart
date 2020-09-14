import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanjivani/widgets/search_medical_college_card.dart';

class MedicalCollegeScreen extends StatefulWidget {
  @override
  _MedicalCollegeScreenState createState() => new _MedicalCollegeScreenState();
}

class _MedicalCollegeScreenState extends State<MedicalCollegeScreen> {
  TextEditingController editingController = TextEditingController();

  var duplicateItems = [];
  var items = List();
  bool searchBarVisible = false;
  bool navigationButtonVisible = true;
  Future getData() async {
    final response = await http
        .get('https://api.rootnet.in/covid19-in/hospitals/medical-colleges');
    return jsonDecode(response.body);
  }

  var data;

  fetch() async {
    await getData().then((value) {
      setState(() {
        data = value;
        data = data["data"]['medicalColleges'];
        formatData();
        duplicateItems.addAll(medicalList);
        print(duplicateItems);
        items.addAll(duplicateItems);
      });
    });
  }

  List<SearchMedicalCollegeCard> medicalList = [];
  formatData() {
    for (int i = 0; i < data.length; i++) {
      medicalList.add(SearchMedicalCollegeCard(
        stateName: data[i]['state'],
        instituteName: data[i]['name'],
        city: data[i]['city'],
        ownership: data[i]['ownership'],
        admissionCapacity: data[i]['admissionCapacity'].toString(),
        hospitalBeds: data[i]['hospitalBeds'].toString(),
      ));
    }
  }

  @override
  void initState() {
    fetch();

    super.initState();
  }

  void filterSearchResults(String query) {
    List dummySearchList = List();
    dummySearchList.addAll(duplicateItems);

    if (query.isNotEmpty) {
      List dummyListData = List();
      dummySearchList.forEach((item) {
        if (item.stateName.toLowerCase().contains(query.toLowerCase()) ||
            item.ownership.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: size.width * 0.05, left: size.width * 0.05),
                child: Text(
                  'Medical Colleges',
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
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Container(
                  height: size.height * 0.08,
                  width: size.width - 30,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Color(0xFF006a71),
                            width: 1,
                          ),
                          left: BorderSide(
                            color: Color(0xFF006a71),
                            width: 1,
                          ),
                          top: BorderSide(
                            color: Color(0xFF006a71),
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Color(0xFF006a71),
                            width: 1,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(35)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 4, right: 5),
                      child: TextField(
                        autofocus: searchBarVisible,
                        showCursor: false,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        style: TextStyle(
                          color: Color(0xFF006a71),
                        ),
                        controller: editingController,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: "Search",
                          hintStyle: TextStyle(color: Color(0xFF006a71)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
