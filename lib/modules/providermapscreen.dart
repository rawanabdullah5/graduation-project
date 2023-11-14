import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etaproject/utiles/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'drawer_screen.dart';

class ProviderMapScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String? uId, name, mode, email;

  ProviderMapScreen({
    this.mode,
    required this.uId,
  });

  @override
  Widget build(BuildContext context) {
    final number = '+201141082464';
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        LocationCubit.get(context).updatingTheContainerBooleanByUser(uid: uId);
        LocationCubit.get(context).updatingTheButtonsBooleanByUser(uid:uId);
        var cubit = LocationCubit.get(context);

        print('uId $uId');
        print('mode $mode');

        double mediaHeight = MediaQuery.of(context).size.height;
        double mediaWidth = MediaQuery.of(context).size.height;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              'Services',
              style: TextStyle(color: Colors.white),
            ),
          ),
          drawer: DrawerPart(uId: uId!, mode: mode!),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: mediaHeight,
                width: mediaWidth,
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(30.033333, 31.233334),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    cubit.mapController1 = controller;
                  },
                  markers: cubit.markers,
                ),
              ),

              // SizedBox(
              //   height: mediaHeight * 0.5,
              // ),
              Positioned(
                height: mediaHeight * 0.5,
                right: 0.0,
                top: mediaHeight * 0.3,
                child: InkWell(
                    onTap: () async {
                      cubit.getPermission();
                      cubit.getLatAndLong(
                        mode: mode,
                        uId: uId,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 20,
                      child:
                          Icon(Icons.location_searching, color: Colors.white),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 450, 5, 10),
                child: Visibility(visible: LocationCubit.get(context).ContainerShowen,
                    child: Container(
                      decoration: BoxDecoration(color:Colors.teal.shade100,borderRadius: BorderRadius.circular(10),border: Border.all(width: 5,color: Colors.teal)),
                      height: (MediaQuery.of(context).size.height)/4,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ListView(
                          children:<Widget>[
                            const DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Center(child: Text('User Data')),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  const DefaultTextStyle(style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,fontSize: 16),child: Text(
                                    'User name: ',
                                  ),
                                  ),
                                  DefaultTextStyle(style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,color: Colors.black),child:Text(
                                    '${LocationCubit.get(context).userName}',
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  const DefaultTextStyle(style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,fontSize: 16),child: Text(
                                    'Phone number: ',
                                  ),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width/3.7,),
                                  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white),onPressed:()async{
                                    await FlutterPhoneDirectCaller.callNumber(LocationCubit.get(context).userPhone);
                                  }, child: Row(children: [
                                    Icon(Icons.call,size: 20,color: Colors.teal,),
                                    Text(' Call',style: TextStyle(color: Colors.teal),)
                                  ],))
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  const DefaultTextStyle(
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,fontSize: 16),
                                    child: Text('Car type: '),
                                  ),
                                  DefaultTextStyle(
                                      style: const TextStyle(color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      child: Text(
                                        '${LocationCubit.get(context).userCarType}',
                                      )

                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15,
                            ),
                            Row(
                              children: const <Widget>[
                                DefaultTextStyle(style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,fontSize: 16),child: Text(
                                  'Estimated time arrival: ',
                                ),
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black
                                  ),
                                  child: Text(
                                    '10 MIN',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: const <Widget>[
                                DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,fontSize: 16),
                                  child: Text(
                                    'Distance : ',
                                  ),
                                ),
                                DefaultTextStyle(style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),child:Text(
                                  '5.7 KM',
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                const DefaultTextStyle(style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,fontSize: 16),child:Text(
                                  'Required Service: ',
                                ),
                                ),
                                DefaultTextStyle(style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black),child: Text(
                                  'JumpStart',
                                ),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 50, 20),
                                    child: ElevatedButton(onPressed: ()async{
                                      LocationCubit.get(context).isDataContainerShowen();
                                      LocationCubit.get(context).changingDataInFireStore(uid: uId);
                                      LocationCubit.get(context).isServiceButtonsShowen();
                                      QuickAlert.show(
                                        title: 'Payment',
                                          barrierDismissible:false,
                                          confirmBtnColor:Colors.green,
                                          confirmBtnText: 'Collected',
                                          context: context,
                                          type: QuickAlertType.success,
                                          widget: Column(children: const [Center(child: Text('Cash to be collected in Egyptian pounds is')),
                                            SizedBox(height: 5,),
                                            Text('90',style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),)
                                          ],),
                                          onConfirmBtnTap: (){
                                            Navigator.pop(context);
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.success,
                                              barrierDismissible:false,
                                              confirmBtnColor: Colors.green,
                                              confirmBtnText: 'Rate',
                                              text: 'Please rate the client',
                                              widget: RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                unratedColor: Colors.green.shade100,
                                                itemPadding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: Colors.green,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            );
                                          }
                                      );}, child: const Text('Service has been made ')),
                                  ),
                                  // SizedBox(width: MediaQuery.of(context).size.width/1.7,),
                                  ElevatedButton(onPressed:(){QuickAlert.show(title: 'Are you Sure',
                                    context: context,
                                    type: QuickAlertType.confirm,
                                    text: 'that you want to Cancel this request?',
                                    confirmBtnText: 'Yes',
                                    cancelBtnText: 'No',cancelBtnTextStyle: const TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 18),
                                    confirmBtnColor: Colors.teal,
                                    onConfirmBtnTap: () =>{
                                    Navigator.pop(context),
                                    LocationCubit.get(context).isServiceButtonsShowen(),
                                      LocationCubit.get(context).isDataContainerShowen(),
                                      LocationCubit.get(context).changingDataInFireStore(uid: uId),
                                    },);
                                  }, child: const Text('Cancel'),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Visibility(
                          visible: LocationCubit.get(context).ButtonsShowen,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                backgroundColor: Colors.teal),
                            child: Row(
                              children: const [
                                Icon(Icons.arrow_upward_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Select the type of service',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Serif')),
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                context: context,
                                builder: (BuildContext context) =>
                                    SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              bottom: 15.0,
                                              right: 20,
                                              left: 20),
                                          child: Row(
                                            children: [
                                              BackButton(
                                                onPressed: () {
                                                  //Navigator.pop(context);
                                                },
                                              ),
                                              const Text(
                                                  'Select the type of service',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: 'Serif')),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 350,
                                        child: SingleChildScrollView(
                                          child: GridView.builder(
                                              itemCount: cubit.services.length,
                                              shrinkWrap: true,
                                              primary: false,
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (index == 2) {
                                                      showModalBottomSheet(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            30.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            30.0))),
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              15.0,
                                                                          bottom:
                                                                              15.0,
                                                                          right:
                                                                              20,
                                                                          left:
                                                                              20),
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      BackButton(
                                                                    onPressed:
                                                                        () {
                                                                     // Navigator.pop(context);
                                                                    },
                                                                  )),
                                                              ListView.builder(
                                                                shrinkWrap: true,
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                itemBuilder: (context,
                                                                    emergencyIndex) {
                                                                  return GestureDetector(
                                                                      onTap: () {
                                                                        cubit.isServiceClicked(
                                                                            uId:
                                                                                uId,
                                                                            model: cubit.emergencyItems[
                                                                                emergencyIndex],
                                                                            serviceName: cubit
                                                                                .emergencyItems[
                                                                                    emergencyIndex]
                                                                                .name,
                                                                            emergencyIndex:
                                                                                emergencyIndex);
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                                .all(
                                                                            10.0),
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Card(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                            color: cubit.selectedIndex2 == emergencyIndex
                                                                                ? Colors.teal
                                                                                : Colors.white70,
                                                                            child:
                                                                                Container(
                                                                              width:
                                                                                  160,
                                                                              height:
                                                                                  180,
                                                                              child:
                                                                                  Padding(
                                                                                padding: const EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Image(
                                                                                      width: 100,
                                                                                      height: 120,
                                                                                      image: AssetImage(cubit.emergencyItems[emergencyIndex].image),
                                                                                    ),
                                                                                    Text(
                                                                                      cubit.emergencyItems[emergencyIndex].name,
                                                                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Serif'),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                                  //fire stations
                                                                },
                                                                itemCount: cubit
                                                                    .emergencyItems
                                                                    .length,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      cubit.isServiceClicked(
                                                        model:
                                                            cubit.services[index],
                                                        serviceName: cubit
                                                            .services[index].name,
                                                        uId: uId,
                                                        serviceIndex: index,
                                                      );
                                                    }
                                                  },
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0)),
                                                    color: cubit.selectedIndex1 ==
                                                            index
                                                        ? Colors.teal
                                                        : Colors.white70,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            width: 80,
                                                            height: 100,
                                                            child: Image(
                                                              image: AssetImage(
                                                                  cubit
                                                                      .services[
                                                                          index]
                                                                      .image),
                                                            )),
                                                        Text(
                                                          cubit.services[index]
                                                              .name,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontFamily:
                                                                  'Serif'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(visible: LocationCubit.get(context).ButtonsShowen,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal),
                            onPressed: () async {
                              var snap =await FirebaseFirestore.instance.collection('user').doc('Salma@gmail.com').get();
                              showToast("Searching for nearby requests");
    Timer(Duration(seconds: 3), () {QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  widget: Column(
                                    children: <Widget>[
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 500),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'User name: ',
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '${snap.data()!['name']}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 500),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Car type: ',
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '${snap.data()!['car type']}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Estimated time arrival: ',
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '10 MIN',
                                            style: TextStyle(
                                                fontSize: 17, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Distance : ',
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '5.7 KM',
                                            style: TextStyle(
                                                fontSize: 17, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Required Service: ',
                                            style: TextStyle(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'JumpStart',
                                            style: TextStyle(
                                                fontSize: 17, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onConfirmBtnTap: () async{
                                    LocationCubit.get(context).GettingUserData(uid: 'Salma@gmail.com');
                                    LocationCubit.get(context).isDataContainerShowen();
                                    LocationCubit.get(context).changingDataInFireStore(uid: uId);
                                    LocationCubit.get(context).isServiceButtonsShowen();
                                    Navigator.pop(context);
                                  },
                                  textColor: Colors.teal,
                                  confirmBtnText: 'Accept',
                                  cancelBtnText: 'Reject',
                                  confirmBtnColor: Colors.teal,
                                  title: 'Request',
                              );
    });
                              // providersUid.add(uId!);
                            },
                            child: const Text("Ready")),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
