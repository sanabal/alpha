
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_models.dart';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_models.dart';

class PeliculasProvider{

  String _apikey ="34b28b085ba0bf20e62ac2619b0467ac";

  String _url ="api.themoviedb.org";

  String _language = "es-ES";

  int _popularesPage  = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast(); //tuberia

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add; // apunta al stream 

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;




  void disposeStreams(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp= await http.get(url);

    final decodedData = json.decode(resp.body); //toma el cuerpo de la peticion y genera un mapa

    //print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']); //genera las peliculas..
    return peliculas.items; //peliculas lista para usar...

  }

  Future<List<Pelicula>>getEnCines() async{


    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apikey,
      'language': _language
      
      });


    final resp= await http.get(url);

    final decodedData = json.decode(resp.body); //toma el cuerpo de la peticion y genera un mapa

    //print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']); //genera las peliculas..

    //print(peliculas.items[0].title);


    return peliculas.items; //peliculas lista para usar...

  }

  Future<List<Pelicula>>getPopular() async{
    
    if(_cargando) return[];

    _cargando = true;



    _popularesPage++;
    
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
      
      });


    
      final resp = await _procesarRespuesta(url);
     

      _populares.addAll(resp);
      popularesSink(_populares);
      _cargando = false;
      return resp;
    // 
     // return[];
  }



  Future<List<Actor>>getCast(String peliId) async{


    final url = Uri.https(_url, '3/movie/$peliId/credits' ,{
      'api_key': _apikey,
      'language': _language
      
      });


    final resp= await http.get(url);

    final decodedData = json.decode(resp.body); //toma el cuerpo de la peticion y genera un mapa

    //print(decodedData['results']);
    final cast = new Cast.fromJsonList(decodedData['cast']); //genera las peliculas..

    //print(peliculas.items[0].title);


    return cast.actores; //peliculas lista para usar...

  }



}