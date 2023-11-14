import 'dart:async';
import 'package:etaproject/cubit/cubit.dart';
import 'package:etaproject/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_choose.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);     //Alaa

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Timer(Duration(seconds: 3), () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginChoose()));
        });
        return Scaffold(
          backgroundColor: Colors.teal,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  //Icon(Icons.flash)
                  Image(
                      image: AssetImage('assets/Servei icon.png'),
                      fit: BoxFit.fill),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 270),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Help on the way',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Reross Quadratic',
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.flash_on_sharp,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
