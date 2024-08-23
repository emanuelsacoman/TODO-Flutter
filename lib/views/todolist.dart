import 'package:aula1/models/task_model.dart';
import 'package:aula1/services/task_service.dart';
import 'package:aula1/views/createtask.dart';
import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  TaskService taskService = TaskService();
  List<Task> tasks = [];

  getAllTasks() async {
    tasks = await taskService.getTasks();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO LIST', style: TextStyle(fontSize: 25, color: Colors.black),), backgroundColor: Color.fromARGB(255, 118, 252, 189),), 
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index){
          return
          Card(color: Color.fromARGB(255, 248, 248, 248), elevation: 2, child: Padding(padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tasks[index].title.toString(), style: TextStyle(fontSize: 18, color: Colors.black),),
                      Radio(value: true, groupValue: tasks[index].isDone, onChanged: (value){
                        if(value != null){
                          taskService.editTask(index, tasks[index].title!, tasks[index].description!, value);
                        }
                        setState(() {
                          tasks[index].isDone = value;
                        });
                      }),
                    ]
                  ),
                  Text(tasks[index].description.toString(), style: TextStyle(fontSize: 16, color: Colors.black),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () async{
                        await taskService.deleteTask(index);
                        getAllTasks();                    
                      }, icon: Icon(Icons.delete), color: Colors.red,), 
                      IconButton(onPressed: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Createtask(
                          task: tasks[index], index: index
                        )),).then((value) => getAllTasks());

                      }, icon: Icon(Icons.edit), color: Colors.blue,)
                    ]
                  )
                ],
              ),
            )
          );
        }
      )
    );
  }
}