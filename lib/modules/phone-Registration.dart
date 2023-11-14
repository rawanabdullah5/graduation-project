import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../utiles/showToast.dart';
import 'mapScreen.dart';

class phoneRegister extends StatefulWidget {
  const phoneRegister({super.key});

  @override
  State<phoneRegister> createState() => _phoneRegisterState();
}

class _phoneRegisterState extends State<phoneRegister> {
  RegExp phoneRegExp =
  RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$');
  RegExp licRegExp =
  RegExp(r'^([1-3]{1})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})[0-9]{3}([0-9]{1})[0-9]{1}$');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final carTypeController = TextEditingController();
  final carModelController = TextEditingController();
  final licController = TextEditingController();

  final registerKey = GlobalKey<FormState>();

  final focusName = FocusNode();
  final focusPhone = FocusNode();
  final focusLic = FocusNode();
  final focusCarType = FocusNode();
  final focusCarModel = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusName.unfocus();
        focusPhone.unfocus();
        focusLic.unfocus();
        focusCarModel.unfocus();
        focusCarType.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(65.0),
                child: Image(
                  image: AssetImage('assets/SignupEmail.png'),
                  fit: BoxFit.fill,
                ),
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
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextFormField(
                          controller: nameController,
                          focusNode: focusName,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Colors.teal),
                            labelText: 'Name',
                            labelStyle: const TextStyle(
                                color: Colors.teal, fontSize: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextFormField(
                          controller: phoneController,
                          focusNode: focusPhone,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.call_outlined,
                                color: Colors.teal),
                            labelText: 'Phone number',
                            labelStyle: const TextStyle(
                                color: Colors.teal, fontSize: 17),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 10, 15),
                              child: TextFormField(
                                controller: carTypeController,
                                focusNode: focusCarType,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  prefixIcon: const Icon(
                                      Icons.car_repair_outlined,
                                      color: Colors.teal),
                                  labelText: 'Car type',
                                  labelStyle: const TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
                              child: TextFormField(
                                controller: carModelController,
                                focusNode: focusCarModel,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.teal),
                                      borderRadius: BorderRadius.circular(10)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                      Icons.car_crash_outlined,
                                      color: Colors.teal),
                                  labelText: 'Car model',
                                  labelStyle: const TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                          controller: licController,
                          focusNode: focusLic,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.teal),
                                borderRadius: BorderRadius.circular(10)),
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
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: SizedBox(height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              if (nameController.text.isEmpty) {
                                showToast('Name Can/t be empty');
                              } else if (phoneController.text.isEmpty) {
                                showToast('Phone Can/t be empty');
                              } else if (!phoneRegExp
                                  .hasMatch(phoneController.text!)) {
                                showToast('Enter the correct phone number');
                              } else if (carModelController.text.isEmpty) {
                                showToast('Car Model Can/t be empty');
                              } else if (carTypeController.text.isEmpty) {
                                showToast('Car Type Can/t be empty');
                              } else if (licController.text.isEmpty) {
                                showToast('Licence Can/t be empty');
                              } else if (!licRegExp
                                  .hasMatch(licController.text!)) {
                                showToast('Enter the correct License number');
                              } else {
                                FirebaseFirestore.instance
                                    .collection(modes)
                                    .doc(phoneController.text)
                                    .set({
                                  'name': nameController.text,
                                  'phone': phoneController.text,
                                  'car model': carModelController.text,
                                  'car type': carTypeController.text,
                                  'license': licController.text,
                                }, SetOptions(merge: true));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => MapScreen(
                                      mode: modes,
                                      uId: phoneController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      )
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
