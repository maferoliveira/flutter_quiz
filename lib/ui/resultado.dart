import 'package:flutter/material.dart';
import 'splash.dart';

class ResultadoPage extends StatelessWidget {
  final String nome;
  final int pontos;
  final int total;

  const ResultadoPage({
    super.key,
    required this.nome,
    required this.pontos,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    int erros = total - pontos;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 144, 39, 39), const Color.fromARGB(255, 187, 161, 161)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                "Resultado Final",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                "$nome, você acertou $pontos de $total",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text("Erros: $erros", style: TextStyle(color: Colors.white70)),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SplashPage()),
                  );
                },
                child: Text("Recomeçar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}