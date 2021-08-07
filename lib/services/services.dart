import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_filman/end_points/endpoint.dart';
import 'package:flutter_app_filman/entitis/people.dart';
import 'package:flutter_app_filman/models/people_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServicesData {
  //Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final GoogleSignIn _googleSignIns = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      var akun = await _googleSignIns.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await akun!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("akun $akun");
      return userCredential.user;
    } catch (error) {
      print(error);
    }
  }

  Future<User?> authenticate() async {
    var user = await FirebaseAuth.instance.currentUser;
    print("uid $user");
    return user;
  }

  Future<String> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    return 'sukses';
  }

  //Dio
  final dio = Dio();

  Future<List<People>?> getPeople() async {
    try {
      final response = await dio.get(EndPoint.ApiPeople);
      print('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        print('data piple ${response.data['results']}');
        return (response.data['results'] as List)
            .map((val) => PeopleModel.fromJson(val))
            .toList();
      } else {
        print('data people null');
      }
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //SQFLite
  Future<Database> initializeDBUser() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Database.db');
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE User ( 
                  id $idType, 
                  uid $textType,
                  name $textType,
                  email $textType
                )
            ''');
    });
  }

  Future<Database> initializeDBPeople() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Database.db');
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE People ( 
                  id $idType, 
                  name $textType,
                  height $textType,
                  mass $textType,
                  hair_color $textType,
                  skin_color $textType,
                  eye_color $textType,
                  birth_year $textType,
                  gender $textType,
                  homeworld $textType
                )
            ''');
    });
  }

  Future<Database> initializeDBFavorit() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Database.db');
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Favorit ( 
                  id $idType, 
                  idPeople $integerType, 
                  name $textType,
                  height $textType,
                  mass $textType,
                  hair_color $textType,
                  skin_color $textType,
                  eye_color $textType,
                  birth_year $textType,
                  gender $textType,
                  homeworld $textType,
                )
            ''');
    });
  }


  Future<int> insertDataFromApi(List<People> peoples) async {
    int result = 1;
    final Database db = await initializeDBPeople();
    print('peoples $peoples');
    peoples.forEach((element) async {
      // People _people = PeopleModel.fromJson(element);
      await db.insert(
          'People', element.toMap()
          );
    });
    return result;
  }

  Future<int> insertData(Map<String, dynamic> peoples) async {
    int result = 0;
    final Database db = await initializeDBPeople();
    print('peoples $peoples');
    // for (var task in tasks) {
    //   result = await db.insert('Task', task.toMap());
    // }
    result = await db.insert('People', peoples);
    return result;
  }

  Future<List<People>> retrievePeople() async {
    final Database db = await initializeDBPeople();
    final List<Map<String, Object?>> queryResult =
    await db.query('People');
    return queryResult.map((val) => PeopleModel.fromJson(val)).toList();
  }

  Future<int> updatePeople(Map<String, dynamic> data, int id) async {
    final Database db = await initializeDBPeople();
    return await db.update('People', data, where: 'id = ?', whereArgs: [id]);
  }
}
