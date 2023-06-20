import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyapp2/views/pick.dart';
import 'package:studyapp2/views/profile.dart';
import 'package:studyapp2/views/statics.dart';
import '../views/daily.dart';
import '../views/timeline.dart';



int currentPage = 1;
List<Widget> pages = [
  Timeline(),
  Daily(),
  Statics(),
  Profile(),
  Pick(),
];

class BottomBar extends StatefulWidget {
  BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}




class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){
           if(currentPage!=0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Timeline()),
                  );
                }

           setState(() {
             currentPage = 0;
           });
              },
              icon: Icon(Icons.home_outlined),
              iconSize: 31,
              color: currentPage == 0 ? Colors.pink : Color.fromRGBO(142, 159, 218, 1.0)

          ),
          IconButton(onPressed: (){

            if(currentPage!=1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Daily()),
              );

            }
            setState(() {
              currentPage = 1;
            });

          },
              icon: Icon(Icons.calendar_today_outlined),
              iconSize: 26,
              color: currentPage == 1 ? Colors.pink : Color.fromRGBO(142, 159, 218, 1.0)


          ),
          Container(
            height: 58,
            width: 58,
            child: ElevatedButton(onPressed: (){

              if(currentPage!=4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pick()),
                );
              }
              setState(() {
                currentPage = 4;

              });

            },
                style: ElevatedButton.styleFrom(
                backgroundColor: currentPage == 4 ? Colors.pink : Color.fromRGBO(142, 159, 218, 1.0),
                    shape: const CircleBorder()
                ),
                child: const Icon(Icons.add,
                  size: 29,
                )
            ),
          ),
          IconButton(onPressed: (){

            if(currentPage!=2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Statics()),
              );
            }


            setState(() {
              currentPage = 2;

            });

          },
              icon: Icon(Icons.bar_chart),
              iconSize: 30,
              color: currentPage == 2 ? Colors.pink : Color.fromRGBO(142, 159, 218, 1.0)

          ),
          IconButton(onPressed: (){

            if(currentPage!=3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            }


            setState(() {
              currentPage = 3;
            });
          },
              icon: Icon(Icons.account_circle_sharp),
              iconSize: 30,
              color: currentPage == 3 ? Colors.pink : Color.fromRGBO(142, 159, 218, 1.0)
          ),
        ],
      ),

    );;
  }
}
