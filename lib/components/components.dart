import 'package:flutter/material.dart';

import '../cubit/cubit.dart';
Widget defaultFormField({
  required TextEditingController controller
  , required TextInputType ? type,
  Function (String)? onsubmit,
  Function (String) ? onchanged,
  required FormFieldValidator<String>?validate,
  required IconData prefix,
  required String label,
  bool  isPassword =false,
  IconData ?suffix,
  bool readonly=false,
  GestureTapCallback? onTap,
  final VoidCallback? suffixPressed,

})=>Container(width: 270,
  child:   TextFormField(
    readOnly:readonly ,style: TextStyle(height:0.8),
    onTap:onTap ,
    validator: validate,
    obscureText:isPassword ,
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(fillColor: Colors.white,filled: true,
        labelText: label,
        prefixIcon: Icon(prefix),suffixIcon:suffix !=null ? IconButton(icon: Icon(suffix),
          onPressed: suffixPressed,): null ,
        border:  OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25.0))),
    onFieldSubmitted:onsubmit ,
    onChanged: onchanged
    ,),
);
Widget buildDrawerItem(screensByDrawer,drawerIcons,context,)
{
  var cubit=LocationCubit.get(context);
  return  ListView.builder(padding: EdgeInsetsDirectional.zero,
    shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
    itemBuilder:(context,index)=> ListTile(
      title: Text(
        '${cubit.screensByDrawer[index]}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      leading: Icon(cubit.drawerIcons[index]),
    ) ,
    itemCount: cubit.screensByDrawer.length,
  );
}

