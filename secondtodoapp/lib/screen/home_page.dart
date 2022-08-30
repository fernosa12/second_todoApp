import 'package:flutter/material.dart';
import 'package:secondtodoapp/Data/data.dart';
import 'package:secondtodoapp/models/model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void searchTodo(String query) {
    final todoFilter = dataTodo.where((todo) {
      final todoTitle = todo.title.toLowerCase();
      final input = query;
      return todoTitle.contains(input);
    }).toList();
    setState(() {
      todos = todoFilter;
    });
  }

  List<Todo> todos = [];

  List<Map<String, dynamic>> saveData = [];
  void getSaveData() async {
    var data = await Dataprefs.getData();
    setState(() {
      todos = data.map((e) => Todo.fromMap(e)).toList();
    });
  }

  @override
  void initState() {
    getSaveData();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    AppBar myappbar = AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://img.freepik.com/premium-vector/man-avatar-profile-round-icon_24640-14044.jpg?w=2000'),
        ),
      ),
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text('B\'Jew Todo App', style: TextStyle(color: Colors.black)),
          if (isOpen)
            TextField(
              onChanged: searchTodo,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Silahkan cari di sini ler !',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.grey,
                filled: true,
              ),
            ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            isOpen = !isOpen;
            setState(() {});
          },
          icon: Icon(isOpen ? Icons.close : Icons.search),
          color: Colors.black,
        ),
      ],
      elevation: 0,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    );
    double heightbody = MediaQuery.of(context).size.height -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    double widthbody = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addtodo').then((_) {
            getSaveData();
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: myappbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Padding(
                padding: EdgeInsets.only(right: 120, top: 60, left: 30),
                child: Text(
                  'Hello jew please do something !',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            // ignore: sized_box_for_whitespace
            todos.isNotEmpty
                ? SizedBox(
                    width: widthbody,
                    height: heightbody * 0.8,

                    // color: Colors.amber,
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        borderradius:
                        BorderRadius.circular(10);
                        color:
                        Colors.black;
                        final todo = todos[index];
                        return Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.red]),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: CheckboxListTile(
                            secondary: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Dataprefs.removeData(todo.id);
                                    getSaveData();
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                )),
                            value: todo.isCompleted,
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            subtitle: Text(
                              todo.desc,
                              style: TextStyle(
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: Colors.black),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) async {
                              await Dataprefs.editData(todo.id, value ?? false);
                              getSaveData();
                            },
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    child: const Center(child: Text('Do something jew !')),
                  )
          ],
        ),
      ),
    );
  }
}
