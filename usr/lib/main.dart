import 'package:flutter/material.dart';

void main() {
  runApp(const GestoreAttivitaApp());
}

class GestoreAttivitaApp extends StatelessWidget {
  const GestoreAttivitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestore Attività',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SchermataPrincipale(),
      },
    );
  }
}

class SchermataPrincipale extends StatefulWidget {
  const SchermataPrincipale({super.key});

  @override
  State<SchermataPrincipale> createState() => _SchermataPrincipaleState();
}

class _SchermataPrincipaleState extends State<SchermataPrincipale> {
  final List<Attivita> _attivita = [
    Attivita(titolo: 'Fare la spesa', completata: false),
    Attivita(titolo: 'Rispondere alle email', completata: true),
    Attivita(titolo: 'Allenamento', completata: false),
    Attivita(titolo: 'Leggere un libro', completata: false),
  ];

  void _aggiungiAttivita() {
    showDialog(
      context: context,
      builder: (context) {
        String nuovoTitolo = '';
        return AlertDialog(
          title: const Text('Nuova Attività'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Inserisci il nome dell\'attività',
            ),
            onChanged: (value) {
              nuovoTitolo = value;
            },
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                setState(() {
                  _attivita.add(Attivita(titolo: value.trim(), completata: false));
                });
                Navigator.of(context).pop();
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annulla'),
            ),
            FilledButton(
              onPressed: () {
                if (nuovoTitolo.trim().isNotEmpty) {
                  setState(() {
                    _attivita.add(Attivita(titolo: nuovoTitolo.trim(), completata: false));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Aggiungi'),
            ),
          ],
        );
      },
    );
  }

  void _toggleAttivita(int index) {
    setState(() {
      _attivita[index].completata = !_attivita[index].completata;
    });
  }

  void _eliminaAttivita(int index) {
    setState(() {
      _attivita.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcola quante attività sono completate
    final completate = _attivita.where((a) => a.completata).length;
    final totali = _attivita.length;
    final progresso = totali > 0 ? completate / totali : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Le mie attività'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scheda di riepilogo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Riepilogo giornaliero',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$completate di $totali attività completate',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: progresso,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Lista delle attività
            Expanded(
              child: _attivita.isEmpty
                  ? const Center(
                      child: Text('Nessuna attività presente. Aggiungine una!'),
                    )
                  : ListView.builder(
                      itemCount: _attivita.length,
                      itemBuilder: (context, index) {
                        final attivita = _attivita[index];
                        return Dismissible(
                          key: Key(attivita.titolo + index.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            color: Theme.of(context).colorScheme.error,
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            _eliminaAttivita(index);
                          },
                          child: ListTile(
                            leading: Checkbox(
                              value: attivita.completata,
                              onChanged: (value) => _toggleAttivita(index),
                            ),
                            title: Text(
                              attivita.titolo,
                              style: TextStyle(
                                decoration: attivita.completata
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: attivita.completata
                                    ? Colors.grey
                                    : null,
                              ),
                            ),
                            onTap: () => _toggleAttivita(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _aggiungiAttivita,
        icon: const Icon(Icons.add),
        label: const Text('Nuova'),
      ),
    );
  }
}

class Attivita {
  String titolo;
  bool completata;

  Attivita({required this.titolo, this.completata = false});
}
