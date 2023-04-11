import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/profile/selectImage.dart';
import 'package:studyapp2/home/MyHomePage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key,}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _yaziKontrol = TextEditingController();
  final List<String> _yazi = [];
  Image varsayilan = Image.asset('lib/assets/itachi.png');
  @override
  Widget build(BuildContext context) {
    Object? name = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            ElevatedButton(
              child: Container(
                height: 120,
                width: 120,
                child: varsayilan,),
              onPressed: () async {
                final selectedPhoto = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectImage(),
                  )).then((selectedPhoto) {
                  if (selectedPhoto != null){
                    setState(() {
                      varsayilan = Image.asset(selectedPhoto);
                    });
                  };
                });


            },),
            SizedBox(height: 7,),
             Text(name!.toString(), style: TextStyle(fontSize: 30, letterSpacing: 5, )),
            SizedBox(height: 6,),
          ],
        ),
        centerTitle: true,
      ),
      body:
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                   TextFormField(
                     controller: _yaziKontrol,
                    decoration: InputDecoration(
                    hintText: 'hey,  how do you feel today?',
                    ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                    onPressed: () {
                    setState(() {
                    _yazi.add(_yaziKontrol.text);
                    });
                    _yaziKontrol.clear();
                    },
                    child: Text('share'),
                    ),
                  SizedBox(height: 16.0),
                  Expanded(
                  child: ListView.builder(
                      itemCount: _yazi.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
                                child: Row(
                                  children: [
                                    Text('@'+ name.toString(),
                                      style: TextStyle(
                                        letterSpacing: 2,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold

                                      )

                                    ),
                                  ],
                                ),
                              ),

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
                                      title: Text(_yazi[index]),
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

      bottomNavigationBar: mybottomappbar(),


      );
    }
  }
