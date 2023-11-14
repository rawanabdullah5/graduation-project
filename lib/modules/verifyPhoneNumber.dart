import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etaproject/components/constants.dart';
import 'package:etaproject/modules/phone-Registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'Phone_Login.dart';
import 'mapScreen.dart';

class MyVerify extends StatelessWidget {
  static var code = "";MyVerify({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection("users").doc("phone");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(45.0),
              child: Image(
                image: AssetImage('assets/EnterOTP.png'),
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
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Text('Enter The OTP Code Sent To This Number',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Serif',
                              color: Colors.teal)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      Icons.arrow_circle_down_sharp,
                      size: 30,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '+2${PhoneScreen.phone}',
                      style: const TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Pinput(
                      defaultPinTheme: PinTheme(
                          height: 70,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5))),
                      length: 6,
                      showCursor: true,
                      onChanged: (value) {
                        MyVerify.code = value;
                      },
                      onCompleted: (pin) => print(pin),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: SizedBox(height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: PhoneScreen.verify,
                                    smsCode: MyVerify.code);
                            UserCredential userCred =
                                await auth.signInWithCredential(credential);
                            if (userCred.additionalUserInfo?.isNewUser != true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => MapScreen(
                                    mode: modes,
                                    uId: PhoneScreen.phone,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      phoneRegister(),
                                ),
                              );
                            }
                          },
                          child: const Center(
                            child: Text('Confirm',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Serif',
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  PhoneScreen()),
                          ModalRoute.withName('/'),
                        );
                      },
                      child: const Text('Edit Phone Number ?',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Serif',
                              color: Colors.teal)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
