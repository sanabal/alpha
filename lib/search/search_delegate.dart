import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_models.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';


class DataSearch extends SearchDelegate{

  String seleccion ="";
  final peliculasProvider = new PeliculasProvider();

  final peliculas=[
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America'

  ];

  final peliculasRecientes =[
    'Spiderman',
    'Capitan America'

  ];


  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro AppBar cancelar y x
      return[
        IconButton(icon: Icon(Icons.clear), onPressed: (){ print('Click!!');})

      ];    
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // icono  a la izquiera del appbar

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
         progress: transitionAnimation,
         ),
          onPressed: (){
            //print('Leading Icons Press');    
            close(context, null);
      });

    }
  
    @override
  Widget buildResults(BuildContext context) {
    // Resultados que vamos a mostrar
    //throw UnimplementedError();
    return Center(child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.blueAccent,
            child: Text(seleccion),


    ));
  }
   
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias cuando la persona escribe
    if(query.isEmpty){ return Container();}


      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

            if(snapshot.hasData){

              final peliculas = snapshot.data;

              return ListView(
                children:  peliculas.map( (pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.jpg'), 
                      image: NetworkImage(pelicula.getPosterImg()),
                      width: 50.0,
                      fit: BoxFit.contain,
                      ),
                      title: Text(pelicula.title),
                      subtitle: Text(pelicula.originalTitle),
                      onTap: (){
                        close(context,null);
                        pelicula.uniqueId="";
                        Navigator.pushNamed(context, 'detalle', arguments: pelicula);

                      },
                  );
                }).toList()

              );

            }else{
                return Center(
                    child:  CircularProgressIndicator(),
                );

            }

        },
      );

   }



  

/* 

 @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias cuando la persona escribe

      final listaSugerida = (query.isEmpty)? peliculasRecientes: peliculas.where(
          (p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

        return ListView.builder(
          itemCount: listaSugerida.length,  
          itemBuilder: (context, i){
              return ListTile(
                leading: Icon(Icons.movie),
                title: Text(listaSugerida[i]),
                onTap: (){
                    seleccion = listaSugerida[i];
                    showResults(context); //manda al cuadro..

                },

              );

          }
          );

  }



   */




}