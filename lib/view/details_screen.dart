import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String cases;
  String deaths;
  String recovered;
  String active;
  String critical;
  String countryName;
  String flag;
  String date;
  DetailsScreen({Key? key,required this.cases,required this.deaths,required this.recovered, required this.active, required this.critical, required this.countryName, required this.flag, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Center(
        child: Card(
          child: Container(
            height: size.height*0.8,
            width: size.width*0.9,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: CircleAvatar(backgroundImage: NetworkImage(flag),radius: 60)),
                SizedBox(height: size.height*0.03,),
                Center(child: Text('${countryName}')),
                Divider(color: Colors.grey,),
                SizedBox(height: size.height*0.03,),
                Row(
                  children: [
                    Expanded(child: Text('Cases',textAlign: TextAlign.start,)),
                    Expanded(child: Text('${cases}',textAlign: TextAlign.end,)),
                  ],
                ),
                SizedBox(height: size.height*0.03,),
                Row(
                  children: [
                    Expanded(child: Text('Deaths',textAlign: TextAlign.start,)),
                    Expanded(child: Text('${deaths}',textAlign: TextAlign.end,)),
                  ],
                ),
                SizedBox(height: size.height*0.03,),
                Row(
                  children: [
                    Expanded(child: Text('Recovered',textAlign: TextAlign.start,)),
                    Expanded(child: Text('${recovered}',textAlign: TextAlign.end,)),
                  ],
                ),
                SizedBox(height: size.height*0.03,),
                Row(
                  children: [
                    Expanded(child: Text('Active',textAlign: TextAlign.start,)),
                    Expanded(child: Text('${active}',textAlign: TextAlign.end,)),
                  ],
                ),
                SizedBox(height: size.height*0.03,),
                Row(
                  children: [
                    Expanded(child: Text('Critical',textAlign: TextAlign.start,)),
                    Expanded(child: Text('${critical}',textAlign: TextAlign.end,)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
