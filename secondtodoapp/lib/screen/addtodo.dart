import 'package:flutter/material.dart';
import 'package:secondtodoapp/Data/data.dart';
import 'package:secondtodoapp/models/model.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllertitle = TextEditingController();
    TextEditingController controllerdesc = TextEditingController();
    AppBar myappbar = AppBar(
      title:
          const Text('B\'Jew Todo App', style: TextStyle(color: Colors.black)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    double heightbody = MediaQuery.of(context).size.height -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    double widthbody = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controllertitle.text.isNotEmpty ||
              controllerdesc.text.isNotEmpty) {
            Dataprefs.saveData(Todo(
                    id: DateTime.now().toString(),
                    title: controllertitle.text.isEmpty
                        ? 'No ttile'
                        : controllertitle.text,
                    desc: controllerdesc.text.isEmpty
                        ? 'No Desc'
                        : controllerdesc.text)
                .toMap());
          }
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      appBar: myappbar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: widthbody,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 209, 206, 206)),
              child: TextField(
                controller: controllertitle,
                maxLines: 3,
                maxLength: 20,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                    hintText: 'Do something jew !',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: widthbody,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 209, 206, 206),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controllerdesc,
                maxLines: 3,
                maxLength: 20,
                style: const TextStyle(fontSize: 10, color: Colors.black),
                decoration: const InputDecoration(
                    hintText: 'Do something jew !',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
