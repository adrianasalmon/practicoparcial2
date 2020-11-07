import 'package:flutter/material.dart';
import 'package:practicoparcial2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practicoparcial2/studentlist.dart';
import 'package:practicoparcial2/addstudent.dart';
void main() => runApp(PracticoParcial2());

class PracticoParcial2 extends StatelessWidget {
  const PracticoParcial2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StudentApp de Adriana",
      debugShowCheckedModeBanner: false,
      home: Inicio(),
    );
  }
}
class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text(
           "Student",
           style: TextStyle(color: Colors.white),
         ),
         backgroundColor: Colors.purple,
         actions: <Widget>[
           FlatButton(
             onPressed: (){
              sharedPreferences.clear();
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
             }, 
             child: Text("Log Out", style: TextStyle(color: Colors.white)),
             ),
         ],
       ),
       body: Center(
         child: StudentsListView(),
       ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.purple,
        label: Text(
          "Add Student",
        ),
        icon: Icon(
          Icons.add,
          color: Color(0xFFFFFBE6),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}