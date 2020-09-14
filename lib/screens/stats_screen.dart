import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sanjivani/config/palette.dart';
import 'package:sanjivani/config/styles.dart';
import 'package:sanjivani/models/patient_stats.dart';
import 'package:sanjivani/widgets/chart.dart';
import 'package:sanjivani/widgets/widgets.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  States _state = States.India;
  String _age = 'All Ages';
  String _gender = 'All Genders';
  List list;
  DateTime startDate = DateTime(2020);
  DateTime endDate = DateTime.now();

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate) startDate = picked;
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate) endDate = picked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.primaryColor,
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(),
              ),
            ),
            _buildHeader1(),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: LineGraph(
                  start: startDate,
                  end: endDate,
                  state: _state,
                  age: _age,
                  gender: _gender,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List getStateItems() {
    List<DropdownMenuItem<String>> items = [];
    for (var state in States.values) {
      items.add(DropdownMenuItem(
        child: Text(PatientStats.statesEnumMap[state]),
        value: PatientStats.statesEnumMap[state],
      ));
    }
    return items;
  }

  Widget getStateDropdown() {
    print(getStateItems());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: PatientStats.statesEnumMap[_state],
          items: getStateItems(),
          onChanged: (selected) {
            setState(() {
              _state = (PatientStats.statesEnumMap.keys
                      .where((k) => PatientStats.statesEnumMap[k] == selected))
                  .first;
            });
          },
        ),
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Statistics',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            getStateDropdown(),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildHeader1() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CountryDropdown(
                  countries: [
                    'All Ages',
                    '0-9',
                    '10-19',
                    '20-29',
                    '30-39',
                    '40-49',
                    '50-59',
                    '60-69',
                    '70+'
                  ],
                  country: _age,
                  onChanged: (val) => setState(() => _age = val),
                ),
                CountryDropdown(
                  countries: ['All Genders', 'Female', 'Male'],
                  country: _gender,
                  onChanged: (val) => setState(() => _gender = val),
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _selectStartDate(context);
                    print('jggjgjgj$startDate');
                  },
                  child: Text('start date'),
                ),
                RaisedButton(
                  child: Text('Change'),
                  onPressed: () {
                    setState(() {
                      print('Dates');
                      print(startDate.toIso8601String() +
                          '\n' +
                          endDate.toIso8601String() +
                          '\nDatesENDDDDd');
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    _selectEndDate(context);
                    print(endDate);
                  },
                  child: Text('end date'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('My Country'),
              Text('Global'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
