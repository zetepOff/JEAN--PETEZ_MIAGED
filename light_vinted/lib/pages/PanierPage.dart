import 'package:flutter/material.dart';
import '../main.dart';

import 'AcheterPage.dart';

class PanierPage extends StatefulWidget {
  final List<Vetement> vetements;

  const PanierPage({Key? key, required this.vetements}) : super(key: key);

  @override
  _PanierPageState createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  List<Vetement> _vetementsSelectionnes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier'),
      ),
      body: ListView.builder(
        itemCount: widget.vetements.length,
        itemBuilder: (BuildContext context, int index) {
          final vetement = widget.vetements[index];
          return ListTile(
            leading: Image.network(vetement.image),
            title: Text(vetement.titre),
            subtitle: Text('Taille : ${vetement.taille}, Prix : ${vetement.prix} €'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _vetementsSelectionnes.remove(vetement);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Total : ${_calculeTotal()} €'),
        ),
      ),
    );
  }

  double _calculeTotal() {
    double total = 0;
    for (var vetement in _vetementsSelectionnes) {
      total += vetement.prix;
    }
    return total;
  }
}
