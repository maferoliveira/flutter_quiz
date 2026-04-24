import 'package:flutter/material.dart';
import 'quiz.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 107, 11, 11), const Color.fromARGB(255, 113, 53, 53)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/fisica.png", height: 120),
                SizedBox(height: 20),
                Text(
                  "Bem-vindo ao\nQuiz de Física",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: const Color.fromARGB(255, 245, 199, 199),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: nomeController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Digite seu nome",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 68, 5, 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizPage(nome: nomeController.text),
                      ),
                    );
                  },
                  child: Text("Iniciar", style: TextStyle(color: const Color.fromARGB(255, 219, 200, 200))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}