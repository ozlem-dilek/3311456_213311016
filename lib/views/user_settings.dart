import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studyapp2/views/profile.dart';

import '../services/db_country_uni.dart';

class userSettings extends StatefulWidget {
  const userSettings({Key? key}) : super(key: key);

  @override
  State<userSettings> createState() => _userSettingsState();
}

class _userSettingsState extends State<userSettings> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    TextEditingController nameControl = TextEditingController();
    TextEditingController passwordControl = TextEditingController();
    List<String>? countries = [];
    String selectedCountry = '';
    List<String> universities = [];
    String selectedUni = '';


    Future<void> loadCountries() async {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> countryList = await databaseHelper.getCountries();

      setState(() {
        countries = countryList.map((country) => country['name'].toString()).toList();
      });
    }
    print(countries);

    Future<void> loadUniversities(int countryId) async {
      DatabaseHelper databaseHelper = DatabaseHelper();
      List<Map<String, dynamic>> universityList = await databaseHelper.getUniversitiesByCountryId(countryId);

      setState(() {
        universities = universityList.map((university) => university['name'].toString()).toList();
      });
    }

    @override
    void initState() {
      super.initState();
      loadCountries();

    }

    User user = FirebaseAuth.instance.currentUser!;
    var userID = user.uid;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var usersRef = _firestore.collection('users');
    var usersdoc = usersRef.doc(userID).get();

    Future<void> updateUserInfo(String newName, String newPassword) async {
      try {
        await user.updateProfile(displayName: newName);
        await user.updatePassword(newPassword);
        print('başarıyla güncellendi');
      } catch (error) {
        print('Kullanıcı bilgileri güncellenirken bir hata oluştu: $error');
      }
    }



    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Update your infos',
                  style: TextStyle(
                    fontSize: 30
                  ),
                  ),
                  SizedBox(height: 150,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenSize.width/2-20,
                        child: TextFormField(
                          controller: nameControl,
                          decoration: InputDecoration(
                            hintText: 'Name'
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width/2-20,
                        child: TextFormField(
                          controller: passwordControl,
                          decoration: InputDecoration(
                              hintText: 'Password'
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 150,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenSize.width/2-20,
                        child: DropdownButtonFormField<String>(
                          value: selectedCountry,
                          decoration: InputDecoration(
                            labelText: 'Ülke Seçin',
                            border: OutlineInputBorder(),
                          ),
                          items: countries?.map((String country) {
                            return DropdownMenuItem<String>(
                              value: country,
                              child: Text(country),
                            );
                          }).toList(),

                          onChanged: (String? value) {
                            setState(() {
                              selectedCountry = value!;

                              selectedUni = '';
                              loadUniversities(1);
                            });
                          },
                        )

                      ),
                      SizedBox(
                        width: screenSize.width/2-20,
                        child:  DropdownButtonFormField<String>(
                          value: selectedUni,
                          decoration: InputDecoration(
                            labelText: 'Üniversite',
                          ),
                          items: universities.map((university) {
                            return DropdownMenuItem<String>(
                              value: university,
                              child: Text(university),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUni = value!;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 100,),
                  ElevatedButton(onPressed: (){

                    updateUserInfo('${nameControl}', '${passwordControl}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                    child: Text('Update'))

                ],


              ),
            ),
          ),
        ),



    );
  }
}
