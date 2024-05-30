import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _checkUsername() async {
    final username = _usernameController.text;
    if (username.isEmpty) {
      _showDialog('Please enter a username.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/check?username=$username'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['exists']) {
          _showDialog('User $username exists.');
        } else {
          _showDialog('User $username does not exist.');
        }
      } else {
        _showDialog('Error checking username. Please try again.');
      }
    } catch (e) {
      _showDialog('Error: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 189, 34),
        title: Text(
          'Users Checker',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 189, 34),
              Color.fromARGB(255, 235, 32, 130),
              Color.fromARGB(255, 200, 32, 251),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  labelText: 'Enter Instagram Username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _checkUsername,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 235, 32, 130),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Check',
                        style: TextStyle(color: Color.fromARGB(255, 235, 32, 130)),
                      ),
                    ),
                    SizedBox(height: 80),

                    Container(
                      child: Center(child: Text("NOTE : ",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),)),
                      
                    ),
                    
                    
                    Column(children: [
                      
                     Text("Not all the usernames are valid !",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),),
                     SizedBox(height: 30,),
                     Text("In instagram when the user deletes his account , no one can use his username.",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),),
                      Text("If you can't use a username that means that the username belongs to a deleted account",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),),
                    
                    
                      
                    ],),

                    
            ],
          
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: HomePage(),
));
