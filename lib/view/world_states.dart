import 'package:covid_19/modal/model.dart';
import 'package:covid_19/modal/service/stateservices.dart';
import 'package:covid_19/view/Countriees.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class worldscreen extends StatefulWidget {
  const worldscreen({super.key});

  @override
  State<worldscreen> createState() => _worldscreenState();
}

// List<Root> datavalue = [];
// Future<List<Root>> fetchdata()async{
//   final Response = await http.get(Uri.parse(Appurl.worldStateApi));
//   if (Response.statusCode == 200) {
//     var data = jsonDecode(Response.body.toString());
// for(Map<String,dynamic> i in data ){
// datavalue.add(Root.fromJson(i));
// }
//     return datavalue;
//   }else{
//  return datavalue;
//   }
// }
class _worldscreenState extends State<worldscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final Colorlist = <Color>[
    Color(0xff4206F4),
    Color(0xff1006260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    Stateservices stateservices = Stateservices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            FutureBuilder(
                future: stateservices.fetchdata(),
                builder: (context, AsyncSnapshot<welcome> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50.0,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths': double.parse(
                                snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValuesInPercentage: true),
                          chartRadius: 140.0,
                          animationDuration:
                              const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: Colorlist,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                listdetail(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString()),
                                listdetail(
                                    title: 'recovered',
                                    value:
                                        snapshot.data!.recovered.toString()),
                                listdetail(
                                    title: 'death',
                                    value: snapshot.data!.deaths.toString()),
                                listdetail(
                                    title: 'active',
                                    value: snapshot.data!.active.toString()),
                                listdetail(
                                    title: 'Critical',
                                    value:
                                        snapshot.data!.critical.toString()),
                                listdetail(
                                    title: 'Today death',
                                    value: snapshot.data!.todayDeaths.toString()),
                                listdetail(
                                    title: 'Today recovered',
                                    value:
                                        snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                       GestureDetector   (
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>contriesscreen()));
                        },
                          child: Container(
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(240, 3, 155, 41)),
                            child:  Center(
                                child: Text(
                              'Track Countrys',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class listdetail extends StatelessWidget {
  String title, value;
  listdetail({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
