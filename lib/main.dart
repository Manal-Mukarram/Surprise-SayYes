import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProposalApp());
}

class ProposalApp extends StatefulWidget {
  const ProposalApp({super.key});

  @override
  State<ProposalApp> createState() => _ProposalAppState();
}

class _ProposalAppState extends State<ProposalApp> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  String noButtonText = 'No'; // No Button Text
  bool heppi = false; // Controls animation

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'H♡M',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 163, 163),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 163, 163),
        body: Stack(
          children: [
            // Show only the question and buttons before they click
            if (!heppi)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Will you Marry Me?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                heppi = true; // Change to show congrats
                              });
                              _confettiController.play(); // Start confetti
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 180, 66, 58),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                noButtonText =
                                    "Yes"; // Change button text to Yes
                              });

                              // Add delay to trigger confetti after text changes
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                _confettiController.play(); // Start confetti
                                setState(() {
                                  heppi = true; // Show "Yayyy :D"
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 180, 66, 58),
                              padding: const EdgeInsets.all(20),
                            ),
                            child: Text(
                              noButtonText, // Use noButtonText variable here
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Confetti effect
            if (heppi)
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.red, Colors.pink, Colors.white],
              ),

            // Show "Yayyyy!" after clicking Yes/No
            if (heppi)
              Center(
                child: AnimatedOpacity(
                  opacity: heppi ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: const Text(
                    'Yayyyy!😘🥰',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 197, 18, 18),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
