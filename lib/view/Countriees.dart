import 'package:covid_19/modal/service/stateservices.dart';
import 'package:covid_19/view/details.dart';
import 'package:covid_19/view/splash.dart';
import 'package:covid_19/view/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class contriesscreen extends StatefulWidget {
  const contriesscreen({super.key});

  @override
  State<contriesscreen> createState() => _contriesscreenState();
}

class _contriesscreenState extends State<contriesscreen> {
  TextEditingController _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stateservices stateservices = Stateservices();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => worldscreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: _searchcontroller,
              decoration: InputDecoration(
                  hintText: 'search a countries',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: stateservices.Countrydata(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade100,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                child: ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];

                            if (_searchcontroller.text.isEmpty) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailsscreen(
                                              name: name,
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['todayDeaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              active: snapshot.data![index] ['active'],
                                              critical: snapshot.data![index] ['critical'],
                                              tests: snapshot.data![index]['tests'],
                                              image: snapshot.data![index]['countryInfo']['flag'])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']))),
                                ),
                              );
                            } else if (name.toLowerCase().contains(
                                _searchcontroller.text.toLowerCase())) {
                              return InkWell(
                                 onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailsscreen(
                                              name: name,
                                              totalCases: snapshot.data![index]['cases'],
                                              totalDeaths: snapshot.data![index]['todayDeaths'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              active: snapshot.data![index] ['active'],
                                              critical: snapshot.data![index] ['critical'],
                                              tests: snapshot.data![index]['tests'],
                                              image: snapshot.data![index]['countryInfo']['flag'])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: ListTile(
                                      title:
                                          Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']
                                                  ['flag']))),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
