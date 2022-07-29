import 'package:flutter/material.dart';
import 'dart:math';

// math library koja sadrži različite matematičke konstante i funkcije i random number generator koji nama treba
void main() {
  return runApp(const DicePage());
}

// STATEFUL WIDGET - ima dva dijela: 1. dio je klasični widget kao kod stateless, 2. STATE dio koji prati promjene i updejta izgled ekrana

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
// sve što se nalazi na ekranu a treba se promjeniti na interakciju korisnika nalazi se u _DicePageState
// imamo gumb TextButton koji reagira kada ga se pritisne i kažemo aplikaciji da promjeni state odnosno updejta varijablu
// 1. kreiramo varijablu kao int data type budući da će ona biti broj i imenujemo ju, naziv se odnosi na kocku koja je na lijevoj strani
  // varijable su nam izvan funkcije kako bismo ih mogli koristiti globalno, ako ih stavimo u funkciju onda se mogu samo unutar nje koristiti
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

// FUNKCIJA KOJOM DODAMO RANDOM BROJEVE PA JE ZATIM UBACIMO U SET STATE METODU UNUTAR ON PRESSED FUNKCIJE - ona je ASYNC, odnosno ne zna se kad će se ona dogoditi budući da čekamo da korisnik stisne gumb
  Future<void> changeDiceFace() async {
    leftDiceNumber = Random().nextInt(6) + 1;
    rightDiceNumber = Random().nextInt(6) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicee App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dicee'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                // flex: 2, služi nam za omjer, ovaj je flex 2 što znači da je duplo veći od flex 1
                // dodali smo padding na child widget Image i automatski se resizala slika kocke - kasnije smo maknuli padding budući da TextButton ima ugrađen padding
                child: TextButton(
                    // onPressed je obavezni property svakog buttona i ako nema argumenata moramo ga napisati praznog: onPressed: () {}; kao anonimnu funkciju
                    // mijenjamo STATE varijable tako da se na pritisak promjeni na broj 5, i onda nam se automatski promjeni i slika jer smo varijablu ubacili u naziv slike koju povlačimo
                    // OBAVEZNO MORAMO NAVESTI METODU SET STATE i u nju ubacimo varijablu
                    onPressed: () {
                      setState(() {
                        // funkcija Random() importana iz math librarya koja sadrži metodu .nextInt() koja daje random broj od 0 do max, a max je argumnet koji mi postavimo kao ograničenje, max broj se ne koristi, s obzirom da je sada niz brojeva od 0 do 5 napravimo još + 1 kako bi svaki broj bio veći za 1 tako da ispadne 0 + 1 je 1 a 5 + 1  je 6;
                        changeDiceFace();
                      });
                    },
                    //2. ubacujemo varijablu u izvor slike, budući da su slike pobrojane od 1-6, varijabla će zamjeniti broj, više neće biti hardcodeano
                    child: Image.asset('assets/dice$leftDiceNumber.png')),
              ),
              Expanded(
                // flex: 1, omjer, ovaj je duplo manji od flex 2
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        changeDiceFace();
                      });
                    },
                    child: Image.asset('assets/dice$rightDiceNumber.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
