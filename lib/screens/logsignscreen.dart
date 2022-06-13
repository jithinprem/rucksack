import 'package:flutter/material.dart';


class LogSignScreen extends StatefulWidget {
  static String id = 'loginscreen';
  LogSignScreen({Key? key}) : super(key: key);

  @override
  State<LogSignScreen> createState() => _LogSignScreenState();
}

class _LogSignScreenState extends State<LogSignScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.shopping_cart),
            title: Text('Welcome   Login/SignUp'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Admission No.',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('impressed');
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                    },
                    child: Text('signUp')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
