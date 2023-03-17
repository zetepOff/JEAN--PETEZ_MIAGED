import 'package:flutter/material.dart';

import 'AcheterPage.dart';

class DetailVetementPage extends StatelessWidget {
  final Vetement vetement;

  DetailVetementPage({required this.vetement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vetement.titre),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(vetement.image),
            SizedBox(height: 16.0),
            Text(
              'Titre: ${vetement.titre}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Taille: ${vetement.taille}'),
            SizedBox(height: 8.0),
            Text('Prix: ${vetement.prix} €',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}