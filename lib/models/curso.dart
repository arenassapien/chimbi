class Curso{
  late int id;
  late String name,section;

  Curso({required this.id,required this.name,required this.section});


  factory Curso.fromJson(Map<String, dynamic> parsedJson){
    //print(DateTime.parse(parsedJson['fechaPrestamo'].toString()));
    return Curso(
       id: int.parse(parsedJson['id'].toString()),
      name: parsedJson['name'].toString(),
      section: parsedJson['section'].toString()
    );
  }


  Map toJson(){
    return{
      'id':id,
      'name':name,
      'section':section
    };
  }
}