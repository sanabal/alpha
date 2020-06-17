class Cast{
  
  List<Actor> actores = new List();


  Cast.fromJsonList( List<dynamic> jsonList ) {//Recibo un mapa con las propiedades de las peliculas

    if(jsonList==null) return;

    jsonList.forEach( (item) { 
      final actor = new Actor.fromJsonMap(item);
      actores.add(actor);// almacena en la lista todas las peliculas mapeadas por el prceso anterior
      
   }); 
     
    

  }



} 




class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> json){

    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];


  }

  getFoto(){

    if(profilePath==null){
      return'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png';
      
    }else{

    return 'https://image.tmdb.org/t/p/w500/$profilePath';

    }

  }



}


