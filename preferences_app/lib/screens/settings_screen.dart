import 'package:flutter/material.dart';
import 'package:preferences_app/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const String routerName = 'Settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool isDarkmode = false;
  int gender = 1;
  String name = 'Pedro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        drawer: SideMenu(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ajustes',
                    style:
                        TextStyle(fontSize: 45, fontWeight: FontWeight.w300)),
                Divider(),
                SwitchListTile(
                    value: isDarkmode,
                    title: Text('Darkmode'),
                    onChanged: (value) {
                      isDarkmode = value;
                      setState(() {
                        
                      });
                    }),
                Divider(),
                RadioListTile<int>(
                    value: 1,
                    groupValue: gender,
                    title: Text('Masculino'),
                    onChanged: (value) {
                      gender = value ?? 1;
                      setState(() {});
                    }),
                Divider(),
                RadioListTile<int>(
                    value: 2,
                    groupValue: gender,
                    title: Text('Femenino'),
                    onChanged: (value) {
                      gender = value ?? 2;
                      setState(() {});
                    }),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    initialValue: 'Leonardo',
                    onChanged: (value){
                      name = value;
                      setState(() {
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      helperText: 'Nombre del usuario'
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
