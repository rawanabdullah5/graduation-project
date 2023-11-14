import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:etaproject/modules/login_choose.dart';
import 'package:etaproject/modules/providermapscreen.dart';
import 'package:etaproject/modules/signUpWithMailAddress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cache/shared_pref.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../utiles/showToast.dart';
import 'mapScreen.dart';

class LoginScreen extends StatelessWidget {        //Alaa
  LoginScreen({Key? key}) : super(key: key);

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignIn() async {
      {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text, password: passController.text);
          var cubit = LocationCubit.get(context);          //Salma
          cubit.lngUser = null;
          cubit.info = null;
          String? modeUser = CacheHelper.getData(key: 'modeUser');
          String? uidUser = CacheHelper.getData(key: 'uIdUser');
          String? modeProvider = CacheHelper.getData(key: 'modeProvider');
          String? uidProvider = CacheHelper.getData(key: 'uIdProvider');
                                                            //Salma
          if (modeUser == 'user' && uidUser == emailController.text) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MapScreen(
                          mode: modeUser,
                          uId: uidUser,
                          email: emailController.text,
                        )),
                (route) => false);
          } else if (modeProvider == 'provider' &&
              uidProvider == emailController.text)
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ProviderMapScreen(
                          mode: modeProvider,
                          uId: uidProvider,
                        )),
                (route) => false);
          return userCredential;
        } on FirebaseAuthException catch (e) {
          showToast(e.message!);
        }
      }
    }

    return BlocProvider(
      create: (BuildContext context) => LocationCubit(),
      child: BlocConsumer<LocationCubit, LocationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              focusPassword.unfocus();
              focusEmail.unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(65.0),
                      child: Image(
                          image: AssetImage('assets/emailLogin.png'),
                          fit: BoxFit.fill),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginChoose()));
                          },
                          icon: const Icon(Icons.arrow_back_ios_sharp,
                              color: Colors.teal, size: 35)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 330, 7, 10),
                      child: BlurryContainer(
                        blur: 5,
                        color: Colors.teal.withOpacity(0.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: TextFormField(
                                controller: emailController,
                                focusNode: focusEmail,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                      Icons.mail_outline_rounded,
                                      color: Colors.teal),
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: TextFormField(
                                controller: passController,
                                focusNode: focusPassword,
                                obscureText:
                                    !LocationCubit.get(context).passwordVisible,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(30)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      LocationCubit.get(context).passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.teal,
                                    ),
                                    onPressed: () {
                                      LocationCubit.get(context)
                                          .isPasswordVisible();
                                    },
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.teal),
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  onPressed: () async {
                                    await SignIn();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xff455a64))),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
