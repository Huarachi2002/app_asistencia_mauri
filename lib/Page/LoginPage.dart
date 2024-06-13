import 'package:app_asistencia_docente/config/api/api_servicio.dart';
import 'package:app_asistencia_docente/config/theme/paletaColors.dart';
import 'package:app_asistencia_docente/provider/user_provider.dart';
import 'package:app_asistencia_docente/widget/custom_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String codigo_text = '';
  String errorMessage = '';
  String errorPassword = '';
  String password_text = '';

  Future<void> loginUser() async{
    try {
      print('$codigo_text $password_text');
      final response = await dio.post(
        '/auth/login',
        data: { 
          'codigo': codigo_text,
          'contraseña': password_text,
        },
      );
      // print(response.data);

      final idUser = response.data['data']['userDetails']['id'];
      final tokenUser = response.data['data']['token'];
      context.read<UserProvider>().changeUserEmail(newCodigo: codigo_text, newId: idUser.toString(), newToken: tokenUser );
      context.go('/home');

    }on DioException catch (e) {
        print('data: ${e.response!.data}');
        print('headers: ${e.response!.headers}');
        print('requestOptions: ${e.response!.requestOptions}');
        if(e.response != null){
          setState(() {
            // if(e.response!.data['meta']['message'] == 'Datos incorrectos'){
            //   errorMessage = e.response!.data['errors']['details'][0];
            // }else{
            //   errorPassword = 'Contraseña incorrecta';
            // }
          });
        }
    } 
  }

  void onChangedCorreo (String value)  {
    codigo_text = value;
  }
  void onChangedPassword (String value)  {
    password_text = value;
  }


  String? validatorInput (String? value){
    if(value == null || value.isEmpty || value.trim().isEmpty ) return 'Campo requerido';
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text( 
                  'Login', 
                  style: TextStyle(
                    fontFamily: AutofillHints.language,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 28
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text( 
                  'Docente App', 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 22
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
                      child: Card(
                        elevation: 7,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              CustomFormField(
                                validator: validatorInput,
                                errorMessage: errorMessage, 
                                label: 'Codigo', 
                                hint: '1234', 
                                obscureText: false,
                                onChanged: onChangedCorreo,
                                color: Colors.transparent,
                                icon: const Icon(Icons.numbers_rounded),
                              ),
                              const SizedBox(height: 20,),
                              CustomFormField(
                                validator: validatorInput,
                                errorMessage: errorPassword, 
                                label: 'Contraseña', 
                                hint: '', 
                                obscureText: true,
                                onChanged: onChangedPassword,
                                color: Colors.transparent,
                                icon: const Icon(Icons.vpn_key),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if(!isValid) return;
                          loginUser();
                        }, 
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
                        ),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}