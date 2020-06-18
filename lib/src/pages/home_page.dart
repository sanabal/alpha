import 'package:flutter/material.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/widgets/card_swiper_widget.dart';
import 'package:peliculas/widgets/pelicula_horizondal.dart';



class HomePage extends StatelessWidget {

      final peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en el cine'),
        backgroundColor:  Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(context: context, delegate: DataSearch(),
               //query: 'hola'
              
              );
          }, 
          )
        ],

      ),
      body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperTarjetas(),
                _footer(context),
              ],
            ),

      )
      
      
      
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future:  peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot <List> snapshot) {

        if(snapshot.hasData){
                  return CardSwiper(peliculas: snapshot.data);


        }else{
          return Container(height: 400.0, child: Center(child: CircularProgressIndicator()));
        }

      },
    );

  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
       children: <Widget>[
          Text("Populares: ", style:Theme.of(context).textTheme.subtitle1),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,

            builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
               
               // print(snapshot.data);
                //return Container();
                   if(snapshot.hasData){
                  return PeliculaHorizontal(peliculas: snapshot.data, siguientePagina: peliculasProvider.getPopular);


                }else{
                return  Center(child: CircularProgressIndicator());                   }
            },
          ),

        ],

      ),

    );






    }
}