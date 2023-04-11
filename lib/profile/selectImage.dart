import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectImage extends StatelessWidget {
  final List<String> photoList = [
    'lib/assets/sasuke.jpg',
    'lib/assets/sakura.jpg',
    'lib/assets/kakashi.jpg',
    'lib/assets/naruto.jpg',
    'lib/assets/tsunade.jpg',
    'lib/assets/itachi.png',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Photo'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                var selectedImage = photoList[index];
                Navigator.of(context).pop(selectedImage);
              },
              child: ElevatedButton(
                onPressed: (){},
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(photoList[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
