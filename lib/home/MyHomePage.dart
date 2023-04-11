import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/time/HizliOlcum.dart';
import 'package:studyapp2/time/sayiSecimi.dart';

class Goals extends StatefulWidget {

  const Goals({super.key});


  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {

  final _gorevKontrol = TextEditingController();
  List<String> _gorevler = [];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        title: Text('goals', style: const TextStyle(fontSize: 25),),
        centerTitle: true,
      ),

      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              TextFormField(
                controller: _gorevKontrol,
                decoration: InputDecoration(
                  hintText: "what are we doing today? let's write.",
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gorevler.add(_gorevKontrol.text);
                  });
                  _gorevKontrol.clear();
                },
                child: Text("let's get it done"),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                    itemCount: _gorevler.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(_gorevler[index]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ]
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTodo = '';
              return AlertDialog(
                title: Text('new goal'),
                content: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    newTodo = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _gorevler.add(newTodo);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),


      bottomNavigationBar: const mybottomappbar(),

    );
  }
}


class mybottomappbar extends StatelessWidget {
  const mybottomappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.deepPurple,
        height: 50,
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SayiSecimi(),
                    ));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 37,
                  width: 30,
                  child: Column(
                    children: const [
                      Icon(Icons.hourglass_bottom)],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Goals(),
                    ));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 37,
                  width: 30,
                  child: Column(
                    children: const [
                      Icon(Icons.menu_book_outlined)],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ElevatedButton(
                onPressed: (){Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HizliOlcum(),
                    ));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 37,
                  width: 30,
                  child: Column(
                    children: const [
                      Icon(Icons.timer)],
                  ),
                ),
              ),
            ),

          ],

        ),
      ),

    );
  }
}

class TodoItem extends StatelessWidget {
  final String title;

  const TodoItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}


