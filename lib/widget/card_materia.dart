import 'package:flutter/material.dart';

class CardMateria extends StatelessWidget {
  final String nombreMateria;
  final String siglaMateria;
  final String grupoMateria;
  final String numAula;
  final String numModulo;
  final String dia;
  final String horaInit;
  final String horaFin; 
  const CardMateria({super.key, required this.nombreMateria, required this.siglaMateria, required this.grupoMateria, required this.numAula, required this.numModulo, required this.dia, required this.horaInit, required this.horaFin});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$nombreMateria $siglaMateria $grupoMateria'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horario: ${horaInit.substring(0,5)} - ${horaFin.substring(0,5)}',
            style: const TextStyle(
              fontSize: 18
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            'Aula: $numAula',
            style: const TextStyle(
              fontSize: 18
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            'Modulo: $numModulo',
            style: const TextStyle(
              fontSize: 18
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}