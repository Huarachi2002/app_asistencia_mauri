import 'package:app_asistencia_docente/config/theme/paletaColors.dart';
import 'package:app_asistencia_docente/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class DrawerView extends StatelessWidget {
  final Function()? onTap;
  const DrawerView({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context, onTap)
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context)  {
  final user = Provider.of<UserProvider>(context, listen: false);
  return Container(
  color: backgroundColor2,
  padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top, bottom: 10),
  child: Column(
    children: [
      const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/User_Icon.png')
      ),
      const SizedBox(height: 12,),
      Text(
        user.codigo,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          fontSize: 20
        ),
      ),
    ],
   ),
  );
}


Widget buildMenuItems(BuildContext context,Function()? onTap) => Container(
  padding: const EdgeInsets.all(24),
  child: Wrap(
    runSpacing: 16,
    children: [
      ListTile(
        leading: const Icon(Icons.calendar_month),
        title: const Text('Carga Horaria'),
        onTap: onTap,
      ),
      ListTile(
        leading: const Icon(Icons.assignment),
        title: const Text('Solicitar Licencia'),
        onTap: onTap,
      ),
      
    ],
  ),
);