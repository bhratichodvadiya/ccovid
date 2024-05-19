import 'package:covid_19/view/Countriees.dart';
import 'package:covid_19/view/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class detailsscreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      todayRecovered,
      active,
      critical,
      tests;
  detailsscreen(
      {required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.tests,
      required this.image});

  @override
  State<detailsscreen> createState() => _detailsscreenState();
}

class _detailsscreenState extends State<detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => contriesscreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height:  MediaQuery.of(context).size.height * .06,),
                      listdetail(
                          title: 'Cases', value: widget.totalCases.toString()),
                      listdetail(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      listdetail(
                          title: 'Deaths', value: widget.totalDeaths.toString()),
                      listdetail(
                          title: 'Critical', value: widget.critical.toString()),
                          listdetail(
                          title: 'Tests', value: widget.tests.toString()),
                      listdetail(
                          title: 'TodayRecovered',
                          value: widget.todayRecovered.toString())
                    ],
                  ),
                ),
              ),

              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),)
            ],
          )
        ],
      ),
    );
  }
}
