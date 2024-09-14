import 'package:aula1/models/task_model.dart';
import 'package:aula1/services/task_service.dart';
import 'package:flutter/material.dart';

class FormViewTasks extends StatefulWidget {
  final Task? task;
  final int? index;
  const FormViewTasks({super.key, this.task, this.index});

  @override
  State<FormViewTasks> createState() => _FormViewTasksState();
}

class _FormViewTasksState extends State<FormViewTasks> {
  String _priority = 'média';
  bool _isEdit = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TaskService TasksService = TaskService();

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
      _priority =
          widget.task!.priority != null ? widget.task!.priority! : "Baixa";
      _isEdit = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _isEdit
              ? Text('Editar tarefa')
              : Text('Criação de tarefas'),
          backgroundColor: Color.fromARGB(255, 118, 252, 189),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(_titleController.text);
                    },
                    decoration: InputDecoration(
                        label: Text('Titulo da tarefa'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  )),
              Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório!';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(_titleController.text);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    minLines: null,
                    decoration: InputDecoration(
                        label: Text('Descrição da tarefa'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  )),
              SizedBox(height: 15),
              Text('Prioridade'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                      value: 'baixa',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _priority = value;
                            print(_priority);
                          }
                        });
                      }),
                  Text('Baixa'),
                  Radio<String>(
                      value: 'média',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _priority = value;
                            print(_priority);
                          }
                        });
                      }),
                  Text('Média'),
                  Radio<String>(
                      value: 'alta',
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _priority = value;
                            print(_priority);
                          }
                        });
                      }),
                  Text('Alta')
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String titleNewTask = _titleController.text;
                      String descriptionNewTask = _descriptionController.text;
                      String priorityNew = _priority;

                      if (widget.task != null && widget.index != null) {
                        await TasksService.editTask(
                            widget.index!, titleNewTask, descriptionNewTask, widget.task!.isDone!, priorityNew);
                      } else {
                        await TasksService.saveTask(
                            titleNewTask, descriptionNewTask, false, priorityNew);
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: _isEdit
                      ? Text('Alterar tarefa')
                      : Text('Salvar tarefa'))
            ],
          ),
        ));
  }
}