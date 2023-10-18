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
  refreshList(){
    setState(() {
      Student = dbHelper.getStudents();
    });
  }

  pickImageFromGallery(){
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 480, maxWidth: 640)
        .then((value) async{
          Uint8List? imageBytes = await value!.readAsBytes();
          setState(() {
            photoName = Utility.base64String(imageBytes!);
          });
    });
  }

  clearFields(){
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

  Widget userForm(){
    return const Form(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
