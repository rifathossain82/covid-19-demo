import 'dart:convert';
import 'dart:math';

import 'package:covid_19_demo/model/WorldStatesModel.dart';
import 'package:covid_19_demo/services/states_services.dart';
import 'package:covid_19_demo/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_demo/services/utils/api_url.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with SingleTickerProviderStateMixin{

  late AnimationController animationController;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    animationController=AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  final colorList=[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<WorldStatesModel>(
              future: StatesServices().fetchWorldStatesRecord(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                  if(snapshot.hasData){
                    return buildBody(size, snapshot);
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text("${snapshot.error}"));
                  }
                  else{
                    return Center(
                        child: SpinKitFadingCircle(
                          size: 50,
                          color: Colors.white,
                          controller: animationController,
                        )
                    );
                  }
              }),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.search,color: Colors.white,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
        },
      ),
    );
  }

  Widget buildBody(Size size, AsyncSnapshot<WorldStatesModel> snapshot){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: PieChart(
            dataMap: {
              'Total': double.parse(snapshot.data!.cases!.toString()),
              'Recovered': double.parse(snapshot.data!.recovered!.toString()),
              'Death': double.parse(snapshot.data!.deaths!.toString()),
            },
            chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true
            ),
            animationDuration: const Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: colorList,
            chartRadius: size.width/3.2,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.left,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildCard(title: 'Total', value: snapshot.data!.cases.toString()),
                  BuildCard(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                ],
              ),
              SizedBox(height: size.height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildCard(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                  BuildCard(title: 'Active', value: snapshot.data!.active.toString()),
                ],
              ),
              SizedBox(height: size.height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildCard(title: 'Critical', value: snapshot.data!.critical.toString()),
                  BuildCard(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                ],
              ),
              SizedBox(height: size.height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuildCard(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                  BuildCard(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

}


class BuildCard extends StatelessWidget {
  String title;
  String value;
  BuildCard({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: size.height*0.1,
      width: size.width*0.41,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ]
        )
      ),
      child: Row(
        children: [
          Expanded(child: AutoSizeText(title,style: TextStyle(),maxLines: 1,textAlign: TextAlign.start,)),
          SizedBox(width: 8,),
          Expanded(child: AutoSizeText(value,style: TextStyle(),maxLines: 1,textAlign: TextAlign.end,))
        ],
      ),
    );
  }
}

