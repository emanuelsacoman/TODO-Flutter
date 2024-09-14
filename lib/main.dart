import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aula1/views/todolist.dart';
import 'package:aula1/views/createtask.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 19, 168, 198)),
        useMaterial3: true,
      ),
      home: AppTeste(),
      routes: {
        //'/': (context) => AppTeste(),
        '/listarTarefas': (context) => ListViewTasks(),
        '/createTask': (context) => FormViewTasks(),
      },
    );
  }
}

class AppTeste extends StatefulWidget {
  const AppTeste({super.key});

  @override
  State<AppTeste> createState() => _AppTesteState();
}

class _AppTesteState extends State<AppTeste> {
  File? _image;
  ImagePicker _picker = ImagePicker();
  pickImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    if(pickedFile != null){
      prefs.setString('image_path', pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  loadImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('image_path');
    if(imagePath != null){
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override 
  void initState(){
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO LIST', style: TextStyle(fontSize: 25, color: Colors.black),), backgroundColor: Color.fromARGB(255, 118, 252, 189),),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text('Emanuel', style: TextStyle(fontSize: 20),), 
            accountEmail: Text('emanuel@gmail.com'),
            currentAccountPicture: ClipOval(
              child: Container(
                height: 100,
                width: 100,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('assets/teste.png'),
                ),
              ),
            ),),
            ListTile(
              title: Text('Lista de Tarefas', style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.pushNamed(context, '/listarTarefas');
              },
              leading: Icon(Icons.list, size: 28,),
            )
        ],)
      ),
      body: Stack(children: [
        Column(
          children: [
            Image.network('https://www.yippeecode.com/wp-content/uploads/2021/10/task_managerment_512.png'),

            _image != null ? Image.file(_image!, fit: BoxFit.cover, width: 300, height: 300,) : Container(),
            ElevatedButton(onPressed: (){
              pickImage();
            }, child: Text('Selecionar Imagem da Galeria')),
          ],
        ),
          Padding(padding: EdgeInsets.all(20),
          child: Align(alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, '/createTask');
            },
          child: Icon(Icons.add),
          ),
        ))
      ],),
    );
  }
}