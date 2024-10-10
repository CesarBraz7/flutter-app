import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tarefas = [];
  List<bool> tarefasConcluidas = [];
  TextEditingController tarefaController = TextEditingController();

  void adicionarTarefa() {
    setState(() {
      if (tarefaController.text.isNotEmpty) {
        tarefas.add(tarefaController.text);
        tarefasConcluidas.add(false);
        tarefaController.clear();
      }
    });
  }

  void atualizarTarefa(int index, bool valor) {
    setState(() {
      tarefasConcluidas[index] = valor;
      if (valor) {
        String tarefaCompleta = tarefas.removeAt(index);
        bool statusCompleto = tarefasConcluidas.removeAt(index);
        tarefas.add(tarefaCompleta);
        tarefasConcluidas.add(statusCompleto);
      } else {
        String tarefaNaoCompleta = tarefas.removeAt(index);
        bool statusNaoCompleto = tarefasConcluidas.removeAt(index);
        tarefas.insert(0, tarefaNaoCompleta);
        tarefasConcluidas.insert(0, statusNaoCompleto);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tarefaController,
              decoration: InputDecoration(
                labelText: 'Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarTarefa,
              child: Text('Cadastrar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tarefas[index],
                      style: TextStyle(
                        decoration: tarefasConcluidas[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: tarefasConcluidas[index],
                      onChanged: (bool? valor) {
                        if (valor != null) {
                          atualizarTarefa(index, valor);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}