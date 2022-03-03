import 'package:covid_19_demo/services/states_services.dart';
import 'package:covid_19_demo/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                cursorColor: Colors.white,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white70)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Expanded(
                child: FutureBuilder<List>(
                  future: StatesServices().fetchCountriesRecord(),
                  builder: (context,AsyncSnapshot<List> snapshot) {
                    if(snapshot.hasData){
                      return buildList(snapshot);
                    }
                    else if(snapshot.hasError){
                      return Center(child: Text("${snapshot.error}"));
                    }
                    else{
                      return buildShimmer(size);
                    }
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmer(Size size){
    return ListView.builder(
      itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              baseColor: Colors.grey.shade700,
              highlightColor: Colors.grey.shade100,
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  color: Colors.white,
                ),
                title: Container(
                  height: 10,
                  color: Colors.white,
                  width: size.width,
                ),
                subtitle: Container(
                  height: 15,
                  width: size.width,
                  color: Colors.white,
                ),
              ),
          );
        },
    );
  }

  Widget buildList(AsyncSnapshot<List> snapshot){
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        String name=snapshot.data![index]['country'];
        var data=snapshot.data![index];
        if(searchController.text.isEmpty){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(cases: data['cases'].toString(), deaths: data['deaths'].toString(), recovered: data['recovered'].toString(), active: data['active'].toString(), critical: data['critical'].toString(), countryName: data['country'].toString(), flag: data['countryInfo']['flag'].toString(), date: data['updated'].toString())));
            },
            child: ListTile(
              leading: Image.network(
                snapshot.data![index]['countryInfo']['flag'],
                height: 50,
                width: 50,
              ),
              title: Text(snapshot.data![index]['country']),
              subtitle: Text(snapshot.data![index]['cases'].toString()),
            ),
          );
        }
        else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(cases: data['cases'].toString(), deaths: data['deaths'].toString(), recovered: data['recovered'].toString(), active: data['active'].toString(), critical: data['critical'].toString(), countryName: data['country'].toString(), flag: data['countryInfo']['flag'].toString(), date: data['updated'].toString())));
            },
            child: ListTile(
              leading: Image.network(
                snapshot.data![index]['countryInfo']['flag'],
                height: 50,
                width: 50,
              ),
              title: Text(snapshot.data![index]['country']),
              subtitle: Text(snapshot.data![index]['cases'].toString()),
            ),
          );
        }
        else{
          return Container();
        }
      },
    );
  }
}
