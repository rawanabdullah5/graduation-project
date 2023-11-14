import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etaproject/cubit/cubit.dart';
import 'package:etaproject/modules/providermapscreen.dart';
import 'package:etaproject/modules/signInWithMailAddress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../cache/shared_pref.dart';
import '../components/constants.dart';
import '../utiles/showToast.dart';
import 'mapScreen.dart';

class HomeScreen extends StatefulWidget {
  String? uId;
  HomeScreen({this.uId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RegExp phoneRegExp =
  RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$');
  RegExp licRegExp =
  RegExp(r'^([1-3]{1})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})[0-9]{3}([0-9]{1})[0-9]{1}$');
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  final phoneController = TextEditingController();
  final confPasswordController = TextEditingController();
  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();
  final licController = TextEditingController();
  final focusName = FocusNode();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();
  final focusConfPassword = FocusNode();
  final focusPhone = FocusNode();
  final focusLic = FocusNode();
  final focusCarType = FocusNode();
  final focusCarModel = FocusNode();

  bool _confPasswordVisible = false;
  bool _passwordVisible = false;
  bool containerVisibility = false;
  late UserCredential response;

  var formKey = GlobalKey<FormState>();

  signUp() async {
    try {
      if (passController.text != confPasswordController.text) {
        showToast('The password Not Match.');
      } else if (nameController.text.isEmpty) {
        showToast('Name Can/t be empty');
      } else if (phoneController.text.isEmpty) {
        showToast('Phone Can/t be empty');
      } else if (!phoneRegExp
          .hasMatch(phoneController.text!)) {
        showToast('Enter the correct phone number');
      } else if (emailController.text.isEmpty) {
        showToast('Email can/t be empty');
      } else if (!emailRegExp.hasMatch(emailController.text)) {
        showToast('Enter a correct email');
      } else if (confPasswordController.text.isEmpty) {
        showToast('Password Can/t be empty');
      } else if (confPasswordController.text.length < 8) {
        showToast('Enter a password with length at least 8');
      } else if (carModelController.text.isEmpty) {
        showToast('Car Model Can/t be empty');
      } else if (carTypeController.text.isEmpty) {
        showToast('Car Type Can/t be empty');
      } else if (licController.text.isEmpty) {
        showToast('Licence Can/t be empty');
      } else if (!licRegExp
          .hasMatch(licController.text!)) {
        showToast('Enter the correct License number');
      } else if (modes == null) {
        showToast("please select one of the options");
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: confPasswordController.text);
        FirebaseFirestore.instance
            .collection(modes)
            .doc(emailController.text)
            .set({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'car model': carModelController.text,
          'car type': carTypeController.text,
          'license': licController.text,
          'ContainerShowen' : containerVisibility,
          'ServiceDone' : containerVisibility,
        }, SetOptions(merge: true));
        showToast("signed up successfully");
        if (modes == 'provider') {
          await CacheHelper.saveStringData(
              key: 'uIdProvider', value: emailController.text);
          await CacheHelper.saveStringData(key: 'modeProvider', value: modes);
          await CacheHelper.saveStringData(
              key: 'nameProvider', value: nameController.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ProviderMapScreen(
                        uId: emailController.text,
                        mode: modes,
                      )),
              (route) => false);
        } else if (modes == 'user') {
          await CacheHelper.saveStringData(
              key: 'uIdUser', value: emailController.text);
          await CacheHelper.saveStringData(key: 'modeUser', value: modes);
          await CacheHelper.saveStringData(
              key: 'nameUser', value: nameController.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreen(
                        uId: emailController.text,
                        mode: modes,
                        name: nameController.text,
                        email: emailController.text,
                      )),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'notMatch') {
        showToast('The password Not Match.');
      } else {
        showToast(e.message!);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusEmail.unfocus();
        focusConfPassword.unfocus();
        focusName.unfocus();
        focusPassword.unfocus();
        focusPhone.unfocus();
        focusCarModel.unfocus();
        focusCarType.unfocus();
        focusLic.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Stack(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(65.0),
                  child: Image(
                      image: AssetImage('assets/SignupEmail.png'),
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: IconButton(alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: TextFormField(
                            controller: nameController,
                            focusNode: focusName,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: Colors.teal),
                              labelText: 'Name',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 17),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: TextFormField(
                            controller: phoneController,
                            focusNode: focusPhone,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(12)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.call_outlined,
                                  color: Colors.teal),
                              labelText: 'Phone number',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 17),
                            ),
                          ),
                        ),
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
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.email_outlined,
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
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.teal),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 17),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible =
                                        !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: TextFormField(
                            controller: confPasswordController,
                            focusNode: focusConfPassword,
                            obscureText: !_confPasswordVisible,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.teal),
                              labelText: 'Confirm your password',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 17),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _confPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _confPasswordVisible =
                                        !_confPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15, 10, 10, 10),
                                child: TextFormField(
                                  controller: carTypeController,
                                  focusNode: focusCarType,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.teal),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.car_repair_outlined,
                                        color: Colors.teal),
                                    labelText: 'Car type',
                                    labelStyle: const TextStyle(
                                        color: Colors.teal,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5, 10, 15, 10),
                                child: TextFormField(
                                  controller: carModelController,
                                  focusNode: focusCarModel,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.teal),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.car_crash_outlined,
                                        color: Colors.teal),
                                    labelText: 'Car model',
                                    labelStyle: const TextStyle(
                                        color: Colors.teal,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: TextFormField(
                            controller: licController,
                            focusNode: focusLic,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.circular(30)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal),
                                  borderRadius:
                                      BorderRadius.circular(100)),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                  Icons.insert_drive_file_outlined,
                                  color: Colors.teal),
                              labelText: 'License',
                              labelStyle: const TextStyle(
                                  color: Colors.teal, fontSize: 17),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        RadioListTile(
                            activeColor: Colors.teal,
                            title: const Text(
                              'User',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            value: 'user',
                            groupValue: modes,
                            onChanged: (value) {
                              setState(() {
                                modes = value;
                                print(modes);
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: RadioListTile(
                              activeColor: Colors.teal,
                              title: Text(
                                'Provider',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              contentPadding: EdgeInsets.zero,
                              value: 'provider',
                              groupValue: modes,
                              onChanged: (value) {
                                setState(() {
                                  modes = value;
                                  print(modes);
                                });
                              }),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: SizedBox(height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30)),
                              ),
                              onPressed: () async {
                                var cubit = LocationCubit.get(context);
                                cubit.info = null;
                                cubit.lngUser = null;

                                response = signUp();

                                // That's it to display an alert, use other properties to customize.
                              },
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
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
  }
}
