import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlitedb/dbManager.dart';
import 'package:sqlitedb/students.dart';

import 'package:sqlitedb/convert_utility.dart';

void main() {
  runApp(const MyApp());
}

// Stateless
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

//Stful
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Students>>? Student;
  TextEditingController controlNumController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apepaController = TextEditingController();
  TextEditingController apemaController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? name = '';
  String? apepa = '';
  String? apema = '';
  String? tel = '';
  String? email = '';
  String? photoName = '';

  //Update control
  int? currentUserId;
  final formKey = GlobalKey<FormState>();

  late var dbHelper;
  late bool isUpdating;

  //Métodos de usuario
  refreshList() {
    setState(() {
      Student = dbHelper.getStudents();
    });
  }

  pickImageFromGallery() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker
        .pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640)
        .then((value) async {
      Uint8List? imageBytes = await value!.readAsBytes();
      setState(() {
        photoName = Utility.base64String(imageBytes!);
      });
    });
  }

  clearFields() {
    controlNumController.text = '';
    nameController.text = '';
    apepaController.text = '';
    apemaController.text = '';
    telController.text = '';
    emailController.text = '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBManager();
    refreshList();
    isUpdating = false;
  }

  Widget userForm() {
    return Form(
      // Formulario no debe ser constante
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            SizedBox(height: 10),
            //            TextFormField(
            //              controller: controlNumController,
            //              keyboardType: TextInputType.number, // Teclado númerico
            //              decoration: InputDecoration(
            //                labelText: 'Control number',
            //              ),
            //              validator: (val) => val!.isEmpty ? 'Enter control Number': null,
            //             onSaved: (val) => controlNumController.text = val!,

            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              // Teclado númerico
              decoration: InputDecoration(
                labelText: 'Name controller',
              ),
              validator: (val) => val!.isEmpty ? 'Enter your name' : null,
              onSaved: (val) => name = val!,
            ),

            TextFormField(
              controller: apepaController,
              keyboardType: TextInputType.text,
              // Teclado númerico
              decoration: InputDecoration(
                labelText: 'Apellido Paterno',
              ),
              validator: (val) => val!.isEmpty ? 'Enter apema' : null,
              onSaved: (val) => apepa= val!,
            ),

            TextFormField(
              controller: apemaController,
              keyboardType: TextInputType.text,
              // Teclado númerico
              decoration: InputDecoration(
                labelText: 'Apellido Materno',
              ),
              validator: (val) =>
                  val!.isEmpty ? 'Enter apellido materno' : null,
              onSaved: (val) => apema = val!,
            ),

            TextFormField(
              controller: telController,
              keyboardType: TextInputType.text,
              // Teclado númerico
              decoration: const InputDecoration(
                labelText: 'Telefono ',
              ),
              validator: (val) => val!.isEmpty ? 'Enter control Number' : null,
              onSaved: (val) => tel = val!,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.text,
              // Teclado númerico
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (val) => val!.isEmpty ? 'Enter email c' : null,
              onSaved: (val) => email = val!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: validate,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.red)),
                  child: Text(isUpdating ? "Actuailizar" : "Insertar"),
                ),
                MaterialButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.tealAccent)),
                  child: const Text("Seleciconar imagen"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Lista que se puede scrollear
  SingleChildScrollView userDataTable(List<Students>? Student) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Photo')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Paterno')),
            DataColumn(label: Text('Materno')),
            DataColumn(label: Text('Tel')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Delete')),
          ],
          rows: Student!
              .map((student) => DataRow(cells: [
                    DataCell(Container(
                      width: 80,
                      height: 120,
                      child: Utility.ImageFromBase64String(student.photo_name!),
                    )),
                    DataCell(Text(student.name!), onTap: () {
                      setState(() {
                        isUpdating = true;
                        currentUserId = student.controlNum;
                      });
                      nameController.text = student.name!;
                      apepaController.text = student.apepa!;
                      apemaController.text = student.apema!;
                      emailController.text = student.email!;
                      telController.text = student.tel!;
                    }),
                    DataCell((Text(student.apepa!))),
                    DataCell((Text(student.apema!))),
                    DataCell((Text(student.email!))),
                    DataCell((Text(student.tel!))),
                    DataCell(IconButton(
                      onPressed: () {
                        dbHelper.delete(student.controlNum);
                        refreshList();
                      },
                      icon: const Icon(Icons.delete),
                    ))
                  ]))
              .toList(),
        ));
  }

  Widget list() {
    // Método para expandir
    return Expanded(
        child: SingleChildScrollView(
      child: FutureBuilder(
        future: Student,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          // Verificamos datos
          if (snapshot.hasData) {
            print(snapshot.data);
            return userDataTable(snapshot.data);
          }
          if (!snapshot.hasData) {
            print("Data Not Found");
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (isUpdating) {
        Students student = Students(
          controlNum: currentUserId,
          name: name,
          apepa: apepa,
          apema: apema,
          tel: tel,
          email: email,
          photo_name: photoName,
        );
        dbHelper.update(student);
        isUpdating = false;
      } else {
        Students student = Students(
            controlNum: null,
            name: name,
            apepa: apepa,
            apema: apema,
            email: email,
            tel: tel,
            photo_name: photoName);
        dbHelper.save(student);
      }
      clearFields();
      refreshList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite DB'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [userForm(), list()],
      ),
    );
  }
}
