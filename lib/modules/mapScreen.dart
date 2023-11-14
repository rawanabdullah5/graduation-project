import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'drawer_screen.dart';

class MapScreen extends StatelessWidget {
  bool visabilty = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String? uId, name, mode, email;

  MapScreen({required this.mode, required this.uId, this.name, this.email});
  @override
  Widget build(BuildContext context) {
    final number = '+201141082464';
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        LocationCubit.get(context).updatingTheContainerBoolean(uid: "aa.alaaaemad@gmail.com");
        LocationCubit.get(context).updatingTheButtonsBoolean(uid: "aa.alaaaemad@gmail.com");
        LocationCubit.get(context).GettingProviderData(uid: "aa.alaaaemad@gmail.com");

        var cubit = LocationCubit.get(context);
        print('uId $uId');
        print('mode $mode');
        double mediaHeight = MediaQuery.of(context).size.height;
        double mediaWidth = MediaQuery.of(context).size.height;
        // if(LocationCubit.get(context).getservice==true){
        //   QuickAlert.show(
        //       title: 'Payment',
        //       barrierDismissible:false,
        //       confirmBtnColor:Colors.green,
        //       confirmBtnText: 'Collected',
        //       context: context,
        //       type: QuickAlertType.success,
        //       widget: Column(children: const [Center(child: Text('Cash to be collected in Egyptian pounds is')),
        //         SizedBox(height: 5,),
        //         Text('120',style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),)
        //       ],),
        //       onConfirmBtnTap: (){
        //         Navigator.pop(context);
        //         QuickAlert.show(
        //           context: context,
        //           type: QuickAlertType.success,
        //           barrierDismissible:false,
        //           confirmBtnColor: Colors.green,
        //           confirmBtnText: 'Rate',
        //           text: 'Please rate the client',
        //           widget: RatingBar.builder(
        //             initialRating: 3,
        //             minRating: 1,
        //             direction: Axis.horizontal,
        //             allowHalfRating: false,
        //             itemCount: 5,
        //             unratedColor: Colors.green.shade100,
        //             itemPadding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
        //             itemBuilder: (context, _) => const Icon(
        //               Icons.star,
        //               color: Colors.green,
        //             ),
        //             onRatingUpdate: (rating) {
        //               print(rating);
        //             },
        //           ),
        //         );
        //       }
        //   );
        // }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(
              'My Current Location',
              style: TextStyle(color: Colors.white),
            ),
          ),
          drawer: DrawerPart(mode: mode!, uId: uId!),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                height: mediaHeight,
                width: mediaWidth,
                child: GoogleMap(
                  // polylines: Set<Polyline>.of([polyline]),
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
              if (cubit.info != null)
                Positioned(
                    bottom: 550,
                    right: 0,
                    left: 0,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Card(
                              elevation: 6,
                              color: Color(0xff99EDC3),
                              child: ListTile(
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  title: Text(
                                    cubit.info!.totalDuration,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  leading: Icon(
                                    Icons.access_time_filled,
                                    size: 30,
                                  )),
                              margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            )),
                        SizedBox(
                          width: 30,
                        ),
                        Flexible(
                            flex: 1,
                            child: Card(
                              elevation: 6,
                              color: Color(0xff99EDC3),
                              child: ListTile(
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  title: Text(
                                    cubit.info!.totalDistance,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  leading: Icon(
                                    Icons.directions_car_filled,
                                    size: 30,
                                  )),
                              margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            )),
                      ],
                    )),
              Positioned(
                height: mediaHeight * 0.5,
                right: 0.0,
                top: mediaHeight * 0.3,
                child: InkWell(
                    onTap: () async {
                      await cubit.getPermission();
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
                child: Visibility(
                    visible:
                        LocationCubit.get(context).ContainerShownInUser,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 5, color: Colors.teal)),
                      height: (MediaQuery.of(context).size.height) / 4,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ListView(
                          children: <Widget>[
                            const DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Center(child: Text('Provider Data')),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  const DefaultTextStyle(
                                    style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    child: Text(
                                      'Provider name: ',
                                    ),
                                  ),
                                  DefaultTextStyle(
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    child: Text(
                                      '${LocationCubit.get(context).providerName}',
                                    ),
                                  ),
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    child: Text(
                                      'Phone number: ',
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () async {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(LocationCubit.get(context).providerPhone);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            size: 20,
                                            color: Colors.teal,
                                          ),
                                          Text(
                                            ' Call',
                                            style:
                                                TextStyle(color: Colors.teal),
                                          )
                                        ],
                                      ))
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    child: Text('Car type: '),
                                  ),
                                  DefaultTextStyle(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      child: Text(
                                        '${LocationCubit.get(context).providerCarType}',
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: const <Widget>[
                                DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  child: Text(
                                    'Estimated time arrival: ',
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  child: Text(
                                    'Distance : ',
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  child: Text(
                                    '12 KM',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                const DefaultTextStyle(
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  child: Text(
                                    'The presented Service: ',
                                  ),
                                ),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  child: Text(
                                    'JumpStart',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width/1.7,),
                                  // Padding(
                                  //   padding: const EdgeInsets.fromLTRB(
                                  //       0, 20, 50, 20),
                                  //   child: ElevatedButton(
                                  //       onPressed: () {
                                  //         LocationCubit.get(context)
                                  //             .isDataContainerShowen();
                                  //         LocationCubit.get(context)
                                  //             .isServiceButtonsShowen();
                                  //         QuickAlert.show(
                                  //             title: 'Payment',
                                  //             barrierDismissible: false,
                                  //             confirmBtnColor: Colors.green,
                                  //             confirmBtnText: 'Collected',
                                  //             context: context,
                                  //             type: QuickAlertType.success,
                                  //             widget: Column(
                                  //               children: const [
                                  //                 Center(
                                  //                     child: Text(
                                  //                         'Cash to be collected in Egyptian pounds is')),
                                  //                 SizedBox(
                                  //                   height: 5,
                                  //                 ),
                                  //                 Text(
                                  //                   '120',
                                  //                   style: TextStyle(
                                  //                       fontSize: 25,
                                  //                       color: Colors.green,
                                  //                       fontWeight:
                                  //                           FontWeight.bold),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //             onConfirmBtnTap: () {
                                  //               Navigator.pop(context);
                                  //               QuickAlert.show(
                                  //                 context: context,
                                  //                 type: QuickAlertType.success,
                                  //                 barrierDismissible: false,
                                  //                 confirmBtnColor: Colors.green,
                                  //                 confirmBtnText: 'Rate',
                                  //                 text:
                                  //                     'Please rate the client',
                                  //                 widget: RatingBar.builder(
                                  //                   initialRating: 3,
                                  //                   minRating: 1,
                                  //                   direction: Axis.horizontal,
                                  //                   allowHalfRating: false,
                                  //                   itemCount: 5,
                                  //                   unratedColor:
                                  //                       Colors.green.shade100,
                                  //                   itemPadding:
                                  //                       const EdgeInsets
                                  //                               .fromLTRB(
                                  //                           4, 4, 4, 0),
                                  //                   itemBuilder: (context, _) =>
                                  //                       const Icon(
                                  //                     Icons.star,
                                  //                     color: Colors.green,
                                  //                   ),
                                  //                   onRatingUpdate: (rating) {
                                  //                     print(rating);
                                  //                   },
                                  //                 ),
                                  //               );
                                  //             });
                                  //         ;
                                  //       },
                                  //       child: const Text(
                                  //           'Service has been made ')),
                                  // ),
                                  // SizedBox(width: MediaQuery.of(context).size.width/1.7,),
                                  ElevatedButton(
                                    onPressed: () {
                                      QuickAlert.show(
                                        title: 'Are you Sure',
                                        context: context,
                                        type: QuickAlertType.confirm,
                                        text:
                                            'that you want to Cancel this request?',
                                        confirmBtnText: 'Yes',
                                        cancelBtnText: 'No',
                                        cancelBtnTextStyle: const TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        confirmBtnColor: Colors.teal,
                                        onConfirmBtnTap: () => {
                                          Navigator.pop(context),
                                          // LocationCubit.get(context)
                                          //     .isServiceButtonsShowen(),
                                          LocationCubit.get(context).isDataContainerShowenInUser(),
                                        LocationCubit.get(context).changingDataInFireStoreByUser(uid: 'aa.alaaaemad@gmail.com'),
                                          LocationCubit.get(context).updatingTheContainerBoolean(uid:'aa.alaaaemad@gmail.com' ),
                                        },
                                      );
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
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
                          visible: LocationCubit.get(context).ButtonsShowenInUser,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                backgroundColor: Colors.teal),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_upward_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Select the type of service',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Serif')),
                              ],
                            ),
                            onPressed: () async {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
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
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                const Text(
                                                    'Select the type of service',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Serif')),
                                              ],
                                            )),
                                        SizedBox(
                                          height: 350,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  primary: false,
                                                  padding: const EdgeInsets.only(
                                                      left: 20, right: 20),
                                                  mainAxisSpacing: 5,
                                                  crossAxisSpacing: 5,
                                                  crossAxisCount: 2,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        {
                                                          showModalBottomSheet<
                                                              void>(
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            30.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            30.0))),
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                SizedBox(
                                                              height: 200,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 15,
                                                                        right: 20,
                                                                        left: 20),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          BackButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ), //back button
                                                                    Container(
                                                                      height: 60,
                                                                      width: 250,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(
                                                                                  30.0)),
                                                                          color: Colors
                                                                              .grey[300]),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                10),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text('Tow Truck',
                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                              SizedBox(
                                                                                width: 20,
                                                                              ),
                                                                              Text('350 - 400 EG',
                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 15,
                                                                    ), //space
                                                                    SizedBox(
                                                                      height: 50,
                                                                      width: 150,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          cubit.connection(
                                                                              context);

                                                                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestScreen(uId: uId,service: 'Tow truck',)));
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                                                            backgroundColor: Colors.teal),
                                                                        child: Text(
                                                                            'Request',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: 'Serif')),
                                                                      ),
                                                                    ), //Request Button
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),
                                                        color: Colors.white70,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                width: 80,
                                                                height: 100,
                                                                child:
                                                                    const Image(
                                                                  image: AssetImage(
                                                                      'assets/new-tow.png'),
                                                                )),
                                                            const Text(
                                                              "Tow Truck",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Serif'),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ), // Tow Truck
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'Winch',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '450 - 500 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        Navigator.pop(context);
                                                                        Navigator.pop(context);
                                                                        QuickAlert.show(context: context, type: QuickAlertType.loading,title: 'Searching',text: 'For nearby providers',showCancelBtn: true,);
                                                                        print(
                                                                            'uidProvider is ${FirebaseAuth.instance.currentUser?.email} ');
                                                                        await cubit
                                                                            .getDistanceMatrix(
                                                                                context);
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'user')
                                                                            .doc(
                                                                                uId)
                                                                            .set({
                                                                          'message':
                                                                              'need help'
                                                                        }, SetOptions(merge: true));
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: const [
                                                              SizedBox(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/new-win.png'),
                                                                  )),
                                                              Text(
                                                                "winch",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), // Winch
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
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
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 15.0,
                                                                        bottom:
                                                                            15.0,
                                                                        right: 20,
                                                                        left: 20),
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )),
                                                                SizedBox(
                                                                  height: 350,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child: Column(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () =>
                                                                                  {
                                                                            showModalBottomSheet(
                                                                              shape:
                                                                                  const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                                                                              context:
                                                                                  context,
                                                                              builder: (BuildContext context) =>
                                                                                  SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20, left: 20),
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: BackButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        )),
                                                                                    SizedBox(
                                                                                      height: 200,
                                                                                      child: Text("Fire stations near me"),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          },
                                                                          child: Card(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                              color: Colors.white70,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                        width: 150,
                                                                                        height: 120,
                                                                                        child: Image(
                                                                                          image: AssetImage('assets/fire-truck.png'),
                                                                                        )),
                                                                                    Text(
                                                                                      "Fire Stations",
                                                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Serif'),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )), //fire stations
                                                                        ), //Fire Station
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () =>
                                                                                  {
                                                                            showModalBottomSheet(
                                                                              shape:
                                                                                  const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                                                                              context:
                                                                                  context,
                                                                              builder: (BuildContext context) =>
                                                                                  SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20, left: 20),
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: BackButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        )),
                                                                                    const SizedBox(
                                                                                      height: 200,
                                                                                      child: Text("Hospitals near me"),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          },
                                                                          child: Card(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                              color: Colors.white70,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                        width: 150,
                                                                                        height: 120,
                                                                                        child: Image(
                                                                                          image: AssetImage('assets/hospital.png'),
                                                                                        )),
                                                                                    Text(
                                                                                      "Hospitals",
                                                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Serif'),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )), //fire stations
                                                                        ), //Hospitals
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () =>
                                                                                  {
                                                                            showModalBottomSheet(
                                                                              shape:
                                                                                  const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                                                                              context:
                                                                                  context,
                                                                              builder: (BuildContext context) =>
                                                                                  SingleChildScrollView(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20, left: 20),
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: BackButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                        )),
                                                                                    SizedBox(
                                                                                      height: 200,
                                                                                      child: Text("Police stations near me"),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          },
                                                                          child: Card(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                              color: Colors.white70,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: const [
                                                                                    SizedBox(
                                                                                        width: 150,
                                                                                        height: 120,
                                                                                        child: Image(
                                                                                          image: AssetImage('assets/police-station.png'),
                                                                                        )),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    Text(
                                                                                      "Police Stations",
                                                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Serif'),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )), //fire stations
                                                                        ), //Police Station
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child:
                                                                      const Image(
                                                                    image: AssetImage(
                                                                        'assets/front-line (1).png'),
                                                                  )),
                                                              Text(
                                                                "Emergency",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), //Emergency
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'First Aid',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '150 - 200 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child:
                                                                      const Image(
                                                                    image: AssetImage(
                                                                        'assets/first-aid-kit (1).png'),
                                                                  )),
                                                              Text(
                                                                "First Aid",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), // first aid
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'Fuel',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '260 - 350 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child:
                                                                      const Image(
                                                                    image: AssetImage(
                                                                        'assets/fuel.png'),
                                                                  )),
                                                              Text(
                                                                "Fuel",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), // fuel
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'JumpStart',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '50 - 120 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () async{
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                            QuickAlert.show(context: context, type: QuickAlertType.loading,title: 'Searching',text: 'For nearby providers',);
                                                                          },
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/battery.png'),
                                                                  )),
                                                              Text(
                                                                "JumpStart",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), // jumpstart
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'Key Lockout',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '70 - 140 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child:
                                                                      const Image(
                                                                    image: AssetImage(
                                                                        'assets/key.png'),
                                                                  )),
                                                              Text(
                                                                "Key Lockout",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), // key lockout
                                                    GestureDetector(
                                                      onTap: () => {
                                                        showModalBottomSheet<
                                                            void>(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30.0))),
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            height: 200,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 15,
                                                                      right: 20,
                                                                      left: 20),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        BackButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ), //back button
                                                                  Container(
                                                                    height: 60,
                                                                    width: 250,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: const BorderRadius
                                                                                .all(
                                                                            Radius.circular(
                                                                                30.0)),
                                                                        color: Colors
                                                                                .grey[
                                                                            300]),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                                'Tire Change',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                            SizedBox(
                                                                              width:
                                                                                  20,
                                                                            ),
                                                                            Text(
                                                                                '300 - 450 EG',
                                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Serif')),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ), //space
                                                                  SizedBox(
                                                                    height: 50,
                                                                    width: 150,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  50.0)),
                                                                          backgroundColor:
                                                                              Colors.teal),
                                                                      child: Text(
                                                                          'Request',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w600,
                                                                              fontFamily: 'Serif')),
                                                                    ),
                                                                  ), //Request Button
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      },
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.white70,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                  width: 80,
                                                                  height: 100,
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        'assets/tire.png'),
                                                                  )),
                                                              Text(
                                                                "Tire Change",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'Serif'),
                                                              )
                                                            ],
                                                          )),
                                                    ), //Tire Change
                                                  ],
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
                            },
                          ),
                        ),
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
