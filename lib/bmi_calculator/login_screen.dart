
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/todo_app/presntation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bmi_calculator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
   TextEditingController emailcontroller = TextEditingController();
   TextEditingController passwordcontroller = TextEditingController();
  var _groupValue = 0;
  final formKey = GlobalKey<FormState>();
  bool isScure = true;


  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor:Color(0xFFFD8B59),

      appBar: AppBar(
        title: Text('MyApp'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),

            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LogIn',
                      style: Theme.of(context).textTheme.headlineLarge,
                      ),
                  SizedBox(
                   height: 15,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://b2731202.smushcdn.com/2731202/wp-content/uploads/2022/02/enterprise-data-management-solutions-brief-01-1536x853.jpg?lossy=1&strip=1&webp=1'),
                      radius: 75,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFEE4D8),
                      ),
                      validator: (String? m) {
                        return (emailcontroller.text.isEmpty  ? 'you must fill this field.' : null);
                  },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: isScure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isScure = !isScure;

                              });
                            },
                            icon: isScure?   Icon(Icons.visibility) :  Icon(Icons.visibility_off) ,
                        ),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFFEE4D8),
                      ),
                      validator: (String? n) {
                       if(passwordcontroller.text.isEmpty){
                         return 'you must fill this field';
                       }else if(passwordcontroller.text.length <= 6){
                         return 'weak password';
                       }else if (!passwordcontroller.text.contains('@') && !passwordcontroller.text.contains('_')&&!passwordcontroller.text.contains('-')){
                         return 'password must have special charcter';
                       }else{return null;}
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _groupValue,
                          value: 0,
                          onChanged: (dynamic t){
                            setState(() {
                              _groupValue = t;
                            });
                          },
                        ),
                        Text(
                            'Male'
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: _groupValue,
                          value: 1,
                          onChanged: (dynamic t){
                            setState(() {
                              _groupValue = t;
                            });
                          },
                        ),
                        Text(
                            'Female'
                        ),
                      ],
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF85100),
                      ),
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          final prefs = await SharedPreferences.getInstance();

                          final auth = FirebaseAuth.instance;
                          auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {
                            prefs.setBool('isLogin', true);
                            prefs.setString('name', emailcontroller.text);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return HomeScreen();
                            }));
                          }).onError((error, stackTrace){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$error'),backgroundColor: Colors.red,),);
                          });

                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Validation error'),backgroundColor: Colors.red,),);
                        }

                    },
                        child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
      );
  }
  // initStorage()async{
  //   prefs = await SharedPreferences.getInstance();
  //   isLogin = prefs.getBool('isLogin') ?? false;
  //
  // }
}

