import 'package:aula1/models/task_model.dart';
import 'package:aula1/services/task_service.dart';
import 'package:flutter/material.dart';

class Createtask extends StatefulWidget {
  final Task? task;
  final int? index;
  const Createtask({super.key, this.task, this.index});

  @override
  State<Createtask> createState() => _CreatetaskState();
}

class _CreatetaskState extends State<Createtask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TaskService taskService = TaskService();
  
@override
  void initState() {
    if(widget.task != null){
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text(
      'Create Task',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
    backgroundColor: Color.fromARGB(255, 118, 252, 189),
  ),
  body: Padding(
    padding: EdgeInsets.all(10),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Campo Obrigatório';
              }
              return null;
            },
            onChanged: (value){
              print(_titleController.text);
            },
            decoration: InputDecoration(
              labelText: 'Título da Tarefa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _descriptionController,
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Campo Obrigatório';
              }
              return null;
            },
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            onChanged: (value){
              print(_descriptionController.text);
            },
            decoration: InputDecoration(
              labelText: 'Descrição da Tarefa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20), 
          ElevatedButton(
            onPressed: () async {

              if (_formKey.currentState!.validate()) {
                String titleNewTask = _titleController.text;
                String descriptionNewTask = _descriptionController.text;
                if(widget.task != null && widget.index != null){
                  await taskService.editTask(widget.index!, titleNewTask, descriptionNewTask, widget.task!.isDone!);
                }else{
                  await taskService.saveTask(titleNewTask, descriptionNewTask, false);
                }
                Navigator.pop(context);
              }
            },
            child: Text('Salvar Tarefa'),
          ),
        ],
      ),
    ),
  ),
);

  }
}