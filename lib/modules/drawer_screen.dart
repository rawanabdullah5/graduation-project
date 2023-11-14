import 'package:etaproject/modules/providermapscreen.dart';
import 'package:etaproject/modules/signInWithMailAddress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cache/shared_pref.dart';
import '../components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class DrawerPart extends StatelessWidget {
  String uId, mode;
  DrawerPart({required this.mode, required this.uId});
  @override
  Widget build(BuildContext context) {
    String? emailUser = CacheHelper.getData(key: 'uIdUser');
    String? nameUser = CacheHelper.getData(key: 'nameUser');
    String? emailProvider = CacheHelper.getData(key: 'uIdProvider');
    String? nameProvider = CacheHelper.getData(key: 'nameProvider');

    var cubit = LocationCubit.get(context);
    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Drawer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            uId == emailUser
                ? UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.teal),
                    accountName: Text(nameUser!),
                    accountEmail: Text(emailUser!),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(
                        nameUser[0].toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ))
                : UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.teal),
                    accountName: Text(nameProvider!),
                    accountEmail: Text(emailProvider!),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Text(
                        nameProvider[0].toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    )),
            buildDrawerItem(
              cubit.screensByDrawer,
              cubit.drawerIcons,
              context,
            ),
            SwitchListTile(
              value: cubit.isDark,
              onChanged: (val) {
                cubit.changeMood(context);
              },
              title: const Text('Theme',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              activeColor: Colors.teal,
              secondary: const Icon(Icons.nightlight),
            ),
            ListTile(
                title: const Text('log out',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                leading: const Icon(Icons.logout, size: 30),
                onTap: () async {
                  if (mode == 'provider') {
                    cubit.selectedIndex1 = -1;
                    cubit.selectedIndex2 = -1;
                  }

                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderMapScreen(
                                  mode: mode,
                                  uId: uId,
                                )));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  child: const Text('Provider mode')),
            ),
          ],
        ));
      },
    );
  }
}
