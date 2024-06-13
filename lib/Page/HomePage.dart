import 'dart:async';

import 'package:app_asistencia_docente/config/api/api_servicio.dart';
import 'package:app_asistencia_docente/config/theme/paletaColors.dart';
import 'package:app_asistencia_docente/provider/user_provider.dart';
import 'package:app_asistencia_docente/widget/card_materia.dart';
import 'package:app_asistencia_docente/widget/drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool changeView = true;
  late Timer _timer;
  List<dynamic> data = [];
  bool load = true;


  void logout() {
    context.go('/login');
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHorario(context);
    _timer = Timer(const Duration(seconds: 2), 
      () {
        setState(() {
          load = !load;
        });
      },
    );
  }

  void onTapDrawer(){
    setState(() {
      context.pop();
      changeView = !changeView;
    });
  }

  Future<void> getHorario(BuildContext context)async{
    try {
      final response = await dio.get(
        '/horario'
      );
      data = response.data;
      for (var element in data) {
        print(element);
      }
      
    } on DioException catch (e) {
        if(e.response != null){
          print('headers: ${e.response!.headers}');
          print('requestOptions: ${e.response!.requestOptions}');
          print('data: ${e.response!.data}');
        }
    } 
  }

  void reset (){
    setState(() {
      load = true;
    }); 
    getHorario(context);
    _timer = Timer(const Duration(seconds: 2), 
      () {
        setState(() {
          load = !load;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerView(onTap: onTapDrawer,),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Center(
            child: Text(
              'DOCENTECHECK',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontSize: 23),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.black,
              )
            ),
          ],
        ),
        body: (data.isEmpty || load) 
          ? const Center(child: CircularProgressIndicator(),)
          :
            (changeView)
            ? _HorarioView(data: data,onPressed: reset,)
            : const _LicenciaView()
    );
  }
}

class _HorarioView extends StatelessWidget {
  final List<dynamic> data;
  final void Function()? onPressed;
  _HorarioView({
    super.key, required this.data, this.onPressed,
  });

  List<String> dias = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min  ,
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width  * 0.3),
                  child: const Text(
                    'Horario',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 35
                    ),
                  ),
                ),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.replay_outlined))
              ]
            ),  
            const Divider(
              thickness: 3,
              color: widgetColor,
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              color: backgroundColor2,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Lunes',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[0] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20,),
            Container(
              color: backgroundColor2,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Martes',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[1] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20,),
            Container(
              color: backgroundColor2,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Miercoles',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[2] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20,),
            Container(
              color: backgroundColor2,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Jueves',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[3] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20,),
            Container(
              color: backgroundColor2,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Viernes',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[4] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 20,),
            Container(
              color: backgroundColor2,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Sabado',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final userCodigo = data[index]['grupo']['docente']['user']['codigo'];
                final codigoProvider = Provider.of<UserProvider>(context).codigo;
                if(dias[5] == data[index]['dias']['nombre'] && userCodigo == codigoProvider) {
                  return CardMateria(
                    nombreMateria: data[index]['grupo']['materia']['nombre'], 
                    siglaMateria: data[index]['grupo']['materia']['sigla'], 
                    grupoMateria: data[index]['grupo']['nombre'], 
                    numAula: data[index]['aula']['numero'], 
                    numModulo: data[index]['aula']['modulo']['numero'], 
                    dia: dias[index], 
                    horaInit: data[index]['horaInicio'], 
                    horaFin: data[index]['horaFinal']
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}


List<String> options = [
  'Enfermedad',
  'Problemas de Salud',
  'Problemas Personales',
  'Emergencia Familiares',
  'Fallecimiento de un Familiar',
  'Tramites Administrativos',
  'Problemas Legales',
  'Otro'
];

class _LicenciaView extends StatefulWidget {
  const _LicenciaView({super.key});

  @override
  State<_LicenciaView> createState() => _LicenciaViewState();
}

class _LicenciaViewState extends State<_LicenciaView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String currentOption = options[0];
  String motivoValue = options[0];
  DateTime selectedDateInit = DateTime.now();
  DateTime selectedDateFin = DateTime.now();
  late TextEditingController textController;
  late TextEditingController textFromController;


  Future<void> licencia ()async{
    print(motivoValue);
    print(selectedDateFin.toString().substring(0,10));
    print(selectedDateInit.toString().substring(0,10));
    try {
      final idDocente = Provider.of<UserProvider>(context, listen: false).id;
      await dio.post(
        '/solicitud/enviar',
        data: {
          "fechaInicio": selectedDateInit.toString().substring(0,10),
          "fechaFin": selectedDateFin.toString().substring(0,10),
          "motivo": motivoValue,
          "estado": false,
          "idDocente": int.parse(idDocente) 
        },
      );
    } on DioException catch (e) {
        if(e.response != null){
          print('headers: ${e.response!.headers}');
          print('requestOptions: ${e.response!.requestOptions}');
          print('data: ${e.response!.data}');
        }
    } 
  }

  void resertValue(){
    setState(() {
      currentOption = options[0];
      motivoValue = currentOption;
      textController.clear();
      textFromController.clear();
      selectedDateInit = DateTime.now();
      selectedDateFin = DateTime.now();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      textController = TextEditingController();
      textFromController = TextEditingController();
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
    textFromController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(5)
    );


    return Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _formKey,
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'Solicitar Licencia',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontSize: 35),
                        ),
                      ),
                      const Divider(
                        thickness: 3,
                        color: widgetColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: backgroundColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Motivo',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontSize: 25
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              title: Text(options[index]),
                              value: options[index],
                              groupValue: currentOption,
                              onChanged: (value) {
                                setState(() {
                                  currentOption = value.toString();
                                  motivoValue = currentOption;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      if (currentOption == 'Otro')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: textController,
                            onSubmitted: (String value) {
                              setState(() {
                                motivoValue = textController.text;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Escriba el motivo en especifico',
                            ),
                          ),
                        ),
          
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: backgroundColor2,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Duracion de la Licencia',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                fontSize: 25
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Center(
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('${selectedDateInit.day}/${selectedDateInit.month}/${selectedDateInit.year}'),
                                ElevatedButton.icon(
                                  onPressed: () async{
                                    final DateTime? dateTime = await showDatePicker(
                                      context: context, 
                                      initialDate: selectedDateInit,
                                      firstDate: DateTime(2000), 
                                      lastDate: DateTime(3000)
                                    );
                                    if(dateTime != null){
                                      setState(() {
                                        selectedDateInit = dateTime;
                                      });
                                    }
                                  },
                                  label: const Text('Fecha Inicio'), 
                                  icon: const Icon(Icons.calendar_month_rounded),  
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('${selectedDateFin.day}/${selectedDateFin.month}/${selectedDateFin.year}'),
                                ElevatedButton.icon(
                                  onPressed: () async{
                                    final DateTime? dateTime = await showDatePicker(
                                      context: context, 
                                      initialDate: selectedDateFin,
                                      firstDate: DateTime(2000), 
                                      lastDate: DateTime(3000)
                                    );
                                    if(dateTime != null){
                                      setState(() {
                                        selectedDateFin = dateTime;
                                      });
                                    }
                                  },
                                  label: const Text('Fecha Fin'), 
                                  icon: const Icon(Icons.calendar_month_rounded),  
                                ),
                              ],
                            )
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              final isValid = _formKey.currentState!.validate();
                              if(!isValid) return;
                              licencia();
                              resertValue();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Formulario Enviado'))
                              );
                            }, 
                        
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
                            ),
                            child: const Text(
                              'Enviar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
    );
  }
}