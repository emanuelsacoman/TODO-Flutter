import 'package:flutter/material.dart';
import 'package:aula1/views/todolist.dart';
import 'package:aula1/views/createtask.dart';

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
        '/listarTarefas': (context) => Todolist(),
        '/createTask': (context) => Createtask(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO LIST', style: TextStyle(fontSize: 25, color: Colors.black),), backgroundColor: Color.fromARGB(255, 118, 252, 189),),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text('Emanuel', style: TextStyle(fontSize: 20),), 
            accountEmail: Text('emanuel@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),

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