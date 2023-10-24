// Case primitiva

class Student {
  // Utilizamos comodines - Evita que haya error al estar varcia
  int? controlNum;
  String? name;
  String? apepa;
  String? apema;
  String? tel;
  String? email;
  String? photoName;

  // Creamos un constructor
  Student ({
    this.controlNum,
    this.name,
    this.apepa,
    this.apema,
    this.tel,
    this.email,
    this.photoName,
  });

  // Creamos métodos
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'controlNum': controlNum,
      'name': name,
      'apepa': apepa,
      'apema': apema,
      'tel': tel,
      'email': email,
      'photo_name': photoName
    };
    return map;
  } // Manda el objeto a cualquier elemento

  Student.fromMap(Map<String, dynamic> map) { // Recibe los parámetros
    controlNum = map['controlNUm'];
    name = map['name'];
    apepa = map['apepa'];
    apema = map['apema'];
    tel = map['tel'];
    email = map['email'];
    photoName = map['photo_name'];
  }
}
