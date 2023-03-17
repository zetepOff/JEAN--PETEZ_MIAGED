import 'package:flutter/material.dart';
import '../main.dart';
import 'DetailVetementPage.dart';
import 'PanierPage.dart';
import 'ProfilPage.dart';

class AcheterPage extends StatefulWidget {
  // var user;

  //User admin = User(id: 0, email: "admin@miaged.com", password: "admin", anniversaire: "01/01/1111", adresse: "MIAGED", codePostal: 06111, ville: "MIAGECITY");

  // AcheterPage({required this.admin});

  @override
  _AcheterPageState createState() => _AcheterPageState();
}

class _AcheterPageState extends State<AcheterPage> {
  List<Vetement> _vetements = [];

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    AcheterPage(),
    PanierPage(),
    ProfilPage(
      user: admin,
    ),
  ];

  static var admin = User(
      id: 0,
      email: "admin@miaged.com",
      password: "admin",
      anniversaire: "01/01/1111",
      adresse: "MIAGED",
      codePostal: 06111,
      ville: "MIAGECITY");

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _widgetOptions[index]),
    );


  }

  @override
  void initState() {
    super.initState();
    _getVetements();
  }

  void _getVetements() async {
    List<Vetement> vetements =
        []; //await DatabaseHelper.instance.getVetements();
    setState(() {
      _vetements = vetements;
    });
  }

  List<Vetement> vetements = [
  Vetement(
    id: 1,
    titre: 'Chemise à carreaux',
    description: 'Une belle chemise à carreaux pour homme',
    image: 'https://picsum.photos/200',
    taille: 'L',
    prix: 25.0,
  ),
  Vetement(
    id: 2,
    titre: 'Robe noire',
    description: 'Une robe noire élégante pour femme',
    image: 'https://picsum.photos/200',
    taille: 'M',
    prix: 35.0,
  ),
  Vetement(
    id: 3,
    titre: 'Veste en cuir',
    description: 'Une veste en cuir pour homme',
    image: 'https://picsum.photos/200',
    taille: 'XL',
    prix: 80.0,
  ),
];

List<Vetement> _vetementsSelectionnes = [];

void _ajouterAuPanier(Vetement vetement) {
  setState(() {
    _vetementsSelectionnes.add(vetement);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Acheter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _vetements.length,
        itemBuilder: (BuildContext context, int index) {
          Vetement vetement = _vetements[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailVetementPage(vetement: vetement),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(vetement.image),
                  Text(vetement.titre),
                  Text(vetement.taille),
                  Text(vetement.prix.toString()),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Acheter",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Panier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

//class vetements
class Vetement {
  final int id;
  final String titre;
  final String description;
  final String image;
  final String taille;
  final double prix;

  Vetement({
    required this.id,
    required this.titre,
    required this.description,
    required this.image,
    required this.taille,
    required this.prix,
  });

  factory Vetement.fromJson(Map<String, dynamic> json) {
    return Vetement(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      image: json['image'],
      taille: json['taille'],
      prix: json['prix'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'image': image,
      'taille': taille,
      'prix': prix,
    };
  }
}
