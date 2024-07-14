import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:http/http.dart' as http;

import '../menu/drawer.widget.dart';

class GallerieDetailsPage extends StatefulWidget {
  String keyword; // Utilisez "keyword" au lieu de "Keyword" pour la variable
  GallerieDetailsPage(this.keyword);
  @override
  State<GallerieDetailsPage> createState() => _GallerieDetailsPageState();
}

class _GallerieDetailsPageState extends State<GallerieDetailsPage> {
  int currentPage =1 ;
  int size =10;
  late int totalPages;
  ScrollController _scrollController = new ScrollController();
  List<dynamic>hits =[];


  var gallerieData;
  void initState() {
    super.initState();
    getGallerieData(widget.keyword);
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
      {
        if (currentPage<totalPages){
          currentPage++;
          getGallerieData(widget.keyword);
        }
      }
    });
  }
  void getGallerieData( String keyword) {
    print("Gallerie de la keyword de "+keyword);
    String url="https://pixabay.com/api/?key=40239884-400b73c7236c662e5e3cb89ad&q=${keyword}&page=${currentPage}&per_page=${size}";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.gallerieData=json.decode(resp.body);
        hits.addAll(gallerieData['hits']);
        totalPages=(gallerieData['totalHits']/size).ceil();
        hits = gallerieData ['hits'];
        print(hits);
      });

    }).catchError((err){
      print(err);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: totalPages==0?Text('Page Gallerie Detail'):
            Text("${widget.keyword}), Page ${currentPage}/${totalPages}")
        ),
        body: (gallerieData== null
            ? Center(child :CircularProgressIndicator())
            : ListView.builder(
            itemCount: (gallerieData== null ? 0 : hits.length),
            controller: _scrollController,
            itemBuilder: (context ,index){
              return Column(
                children: [
                  Container(
                    width: double.infinity, // Utilisation de width pour occuper toute la largeur

                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Card(
                        child: Text(
                          hits [index]['tags'],
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        color : Colors.redAccent[100],

                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      child: Card(
                        child : Image.network(
                          hits[index]['previewURL'],
                          fit: BoxFit.fitHeight, // You can adjust the fit to your needs
                        ),
                      ),
                      padding : EdgeInsets.only(left : 10 , right: 10),
                    ),
                  )
                ],
              );
            }
        )
        )
    );



  }
  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

}