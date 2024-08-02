import 'package:flutter/material.dart';

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
      home: const AppTeste(),
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
      body: Column(
        children: [
          Card(color: Color.fromARGB(255, 248, 248, 248), elevation: 2, child: Padding(padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tarefa 1', style: TextStyle(fontSize: 18, color: Colors.black),),
                      Radio(value: true, groupValue: '', onChanged: (value){}),
                    ]
                  ),
                  Text('Descrição da Tarefa', style: TextStyle(fontSize: 16, color: Colors.black),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: (){
                        print('Delete icon');
                      }, icon: Icon(Icons.delete), color: Colors.red,), 
                      IconButton(onPressed: (){
                        print('Edit icon');
                      }, icon: Icon(Icons.edit), color: Colors.blue,)
                    ]
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}