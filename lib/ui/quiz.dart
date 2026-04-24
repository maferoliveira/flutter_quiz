import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'resultado.dart';

class QuizPage extends StatefulWidget {
  final String nome;
  const QuizPage({super.key, required this.nome});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List perguntas = [];
  int index = 0;
  int pontos = 0;
  int? selecionada;

  @override
  void initState() {
    super.initState();
    carregarPerguntas();
  }

  Future<void> carregarPerguntas() async {
    final data = await rootBundle.loadString('mockup/perguntas.json');
    setState(() {
      perguntas = json.decode(data);
    });
  }

  void responder() {
    if (selecionada == null) return;

    bool acertou = selecionada == perguntas[index]['correta'];

    if (acertou) pontos++;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(acertou ? "Parabéns!" : "Ops!"),
        content: Text(acertou ? "Você acertou!" : "Você errou..."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              if (index < perguntas.length - 1) {
                setState(() {
                  index++;
                  selecionada = null;
                });
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultadoPage(
                      nome: widget.nome,
                      pontos: pontos,
                      total: perguntas.length,
                    ),
                  ),
                );
              }
            },
            child: Text("Continuar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (perguntas.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var pergunta = perguntas[index];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Pergunta ${index + 1}"),
        backgroundColor: const Color.fromARGB(255, 88, 18, 18),
        foregroundColor: const Color.fromARGB(255, 209, 182, 182),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 150, 150),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Text(pergunta['pergunta'], style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),

            RadioGroup<int>(
              groupValue: selecionada,
              onChanged: (value) {
                setState(() {
                  selecionada = value!;
                });
              },
              child: Column(
                children: List.generate(
                  pergunta['respostas'].length,
                  (i) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 196, 196),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: RadioListTile<int>(
                      title: Text(pergunta['respostas'][i]),
                      value: i + 1,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 91, 20, 20),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: responder,
              child: Text("Responder", style: TextStyle(color: const Color.fromARGB(255, 196, 174, 174))),
            ),
          ],
        ),
      ),
    );
  }
}