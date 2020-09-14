import 'package:flutter/material.dart';
import 'package:sanjivani/data/medical_colleges.dart';

class MedicalCollegeScreen extends StatefulWidget {
  @override
  _MedicalCollegeScreenState createState() => new _MedicalCollegeScreenState();
}

class _MedicalCollegeScreenState extends State<MedicalCollegeScreen> {
  TextEditingController editingController = TextEditingController();

  var duplicateItems = List<String>();
  var items = List<String>();
  bool searchBarVisible = false;
  bool navigationButtonVisible = true;

  @override
  void initState() {
    duplicateItems.addAll(medicalCollegesList.keys);
    print(duplicateItems);
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
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
                  child: Expanded(
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
                        padding:
                            const EdgeInsets.only(left: 5, top: 4, right: 5),
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
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: medicalCollegesList[items[index]]);
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
