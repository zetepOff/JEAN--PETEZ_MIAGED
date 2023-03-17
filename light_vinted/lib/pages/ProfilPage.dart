import 'package:flutter/material.dart';

import '../main.dart';

class ProfilPage extends StatefulWidget {
  final User user;

  const ProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late TextEditingController _adresseController;
  late TextEditingController _codePostalController;
  late TextEditingController _villeController;
  late TextEditingController _anniversaireController;

  @override
  void initState() {
    super.initState();
    _adresseController = TextEditingController(text: widget.user.adresse);
    _codePostalController =
        TextEditingController(text: widget.user.codePostal.toString());
    _villeController = TextEditingController(text: widget.user.ville);
    _anniversaireController =
        TextEditingController(text: widget.user.anniversaire);
  }

  @override
  void dispose() {
    _adresseController.dispose();
    _codePostalController.dispose();
    _villeController.dispose();
    _anniversaireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login: ${widget.user.login}'),
            SizedBox(height: 16),
            TextField(
              controller: _adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _codePostalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Code postal'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _villeController,
              decoration: InputDecoration(labelText: 'Ville'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _anniversaireController,
              decoration: InputDecoration(labelText: 'Anniversaire'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _onValiderPressed,
              child: Text('Valider'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onDeconnecterPressed,
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }

  void _onValiderPressed() {
    final user = widget.user.copyWith(
      adresse: _adresseController.text,
      //codePostal: int.parse(_codePostalController.text),
      ville: _villeController.text,
      anniversaire: _anniversaireController.text,
    );
    //DatabaseHelper.instance.updateUser(user);
  }

  void _onDeconnecterPressed() {
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }
}