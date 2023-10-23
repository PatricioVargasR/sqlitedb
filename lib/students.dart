// Case primitiva

class Students {
  // Utilizamos comodines - Evita que haya error al estar varcia
  int? controlNum;
  String? name;
  String? apepa;
  String? apema;
  String? tel;
  String? email;
  String? photo_name;

  // Creamos un constructor
  Students ({
    this.controlNum,
    this.name,
    this.apepa,
    this.apema,
    this.tel,
    this.email,
    this.photo_name,
  });

  // Creamos métodos
  Map<String,dynamic> toMap(){
    var map = <String, dynamic>{
      'controlNum': controlNum,
      'name': name,
      'apepa': apepa,
      'apema': apema,
      'tel': tel,
      'email': email,
      'photo_name': photo_name
    };
    return map;
  } // Manda el objeto a cualquier elemento

  Students.fromMap(Map<String, dynamic> map) { // Recibe los parámetros
    controlNum = map['controlNUm'];
    name = map['name'];
    apepa = map['apepa'];
    apema = map['apema'];
    tel = map['tel'];
    email = map['email'];
    photo_name = map['photo_name'];
  }
}
