import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/AcheterPage.dart';


void main() {
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'MIAGED';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: LoginPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  //tentative d'avoir le mdp visible au clic sur l'icon
  Icon iconEye = Icon(Icons.visibility);
  bool obscure = true;
  void showPassword() {
    if (obscure == true) {
      obscure = false;
      iconEye = Icon(Icons.visibility_off);
    } else {
      obscure = true;
      iconEye = Icon(Icons.visibility);
    }
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onLoginButtonPressed(BuildContext context) {
    // Récupérer les valeurs des champs de texte
    final String username = usernameController.text;
    final String password = passwordController.text;

    // Vérifier si l'utilisateur existe
    bool userExists = false; // Remplacer par la vérification en base de données

    if (username == 'admin' && password == 'admin') {
      userExists = true;
    }

    if (userExists) {
      // Rediriger l'utilisateur vers la page suivante
      //Navigator.pushReplacementNamed(context, '/home');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AcheterPage()),
      );
    } else {
      // Afficher un log dans la console et ne rien faire
      print('L\'utilisateur n\'existe pas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('MIAGED'),
        // voir pourquoi ça marche pas style: TextStyle(color: Colors.white,), // Couleur du texte du titre
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Login',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _onLoginButtonPressed(context),
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final int id;
  final String email;
  final String password;
  final String anniversaire;
  final String adresse;
  final int codePostal;
  final String ville;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.anniversaire,
    required this.adresse,
    required this.codePostal,
    required this.ville,
  });

  get login => null;

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? anniversaire,
    String? adresse,
    int? codePostal,
    String? ville,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      anniversaire: anniversaire ?? this.anniversaire,
      adresse: adresse ?? this.adresse,
      codePostal: codePostal ?? this.codePostal,
      ville: ville ?? this.ville,
    );
  }
}
