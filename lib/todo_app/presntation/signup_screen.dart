import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isScure = true;
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF85100),
              ),
              onPressed: ()async{
                if(formKey.currentState!.validate()){
                 final auth =  FirebaseAuth.instance;
                 auth.createUserWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value){
                   print('user registered successfully with $value');
                 }).onError((error, stackTrace) {
                   print('error $error');
                 });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Validation error'),backgroundColor: Colors.red,),);
                }

              },
              child: Text('SignUp'),
            ),

          ],
        ),
      ),
    );
  }
}
