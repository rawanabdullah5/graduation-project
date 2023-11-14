import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:etaproject/modules/verifyPhoneNumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utiles/showToast.dart';
import 'login_choose.dart';

class PhoneScreen extends StatelessWidget {
  static String verify = "";
  static String phone = "";
  PhoneScreen({Key? key}) : super(key: key);

  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final focusPhone = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusPhone.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(65.0),
                child: Image(
                  image: AssetImage('assets/emailLogin.png'),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: IconButton(alignment: Alignment.topLeft,
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
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: SizedBox(height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+2${phoneController.text}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) {},
                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    showToast(
                                        'The provided phone number is not valid.');
                                  }
                                },
                                codeSent: (String verificationId,
                                    int? resendToken) async {
                                  PhoneScreen.verify = verificationId;
                                  PhoneScreen.phone = phoneController.text;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MyVerify(),
                                    ),
                                  );
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                              );
                            },
                            child: const Center(
                              child: Text(
                                'Send OTP',
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
