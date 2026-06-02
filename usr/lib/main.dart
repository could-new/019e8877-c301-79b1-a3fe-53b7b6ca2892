import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const WpHunterApp());
}

class WpHunterApp extends StatelessWidget {
  const WpHunterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WP HUNTER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF05060A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF30d158),
          secondary: Color(0xFFff2d55),
          surface: Color(0xFF0f1219),
          background: Color(0xFF05060A),
        ),
        textTheme: GoogleFonts.ibmPlexMonoTextTheme(ThemeData.dark().textTheme).copyWith(
          bodyMedium: GoogleFonts.ibmPlexMono(color: const Color(0xFFe5e5ea), fontSize: 13),
          titleLarge: GoogleFonts.ibmPlexMono(color: const Color(0xFF30d158), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0a0c13),
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF0f1219),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: Color(0xFF1c1c1e)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WpHunterHome(),
      },
    );
  }
}

class WpHunterHome extends StatefulWidget {
  const WpHunterHome({super.key});

  @override
  State<WpHunterHome> createState() => _WpHunterHomeState();
}

class _WpHunterHomeState extends State<WpHunterHome> {
  final TextEditingController _urlController = TextEditingController();
  final List<String> _logs = [];
  bool _isScanning = false;

  void _startScan() {
    if (_urlController.text.isEmpty) return;
    setState(() {
      _isScanning = true;
      _logs.clear();
      _logs.add("[*] Inizializzazione scansione su ${_urlController.text}...");
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _logs.add("[+] Risoluzione IP target..."));
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _logs.add("[+] Verifica presenza WordPress: Trovato (v6.4.2)"));
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _logs.add("[!] Enumerazione plugin vulnerabili..."));
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      setState(() {
        _logs.add("[+] API REST abilitate: /wp-json/");
        _logs.add("[-] xmlrpc.php disabilitato o bloccato.");
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() {
        _logs.add("[+] Ricerca completata. Generazione report...");
        _isScanning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.security, color: Color(0xFF30d158)),
            const SizedBox(width: 12),
            Text('WP HUNTER // TARGET FINDER', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          const SizedBox(width: 16),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildControlPanel(),
                  const SizedBox(height: 16),
                  _buildTerminalPanel(),
                  const SizedBox(height: 16),
                  _buildTargetInfoPanel(),
                ],
              ),
            );
          } else {
            // Desktop/Tablet layout
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildControlPanel(),
                        const SizedBox(height: 16),
                        Expanded(child: _buildTerminalPanel()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: _buildTargetInfoPanel(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("/// TARGET SETUP", style: TextStyle(color: Color(0xFFff2d55), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: "https://example.com",
                labelText: "URL Target",
                prefixIcon: const Icon(Icons.language),
                filled: true,
                fillColor: const Color(0xFF0a0c13),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1c1c1e))),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF1c1c1e))),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF30d158))),
              ),
              style: const TextStyle(color: Color(0xFF30d158)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _isScanning ? null : _startScan,
                icon: _isScanning 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.radar),
                label: Text(_isScanning ? "SCANSIONE IN CORSO..." : "INIZIA SCANSIONE"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFff2d55),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTerminalPanel() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF0a0c13),
              border: Border(bottom: BorderSide(color: Color(0xFF1c1c1e))),
            ),
            child: const Text("/// TERMINAL OUTPUT", style: TextStyle(color: Color(0xFF30d158), fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF05060A),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  Color textColor = const Color(0xFFe5e5ea);
                  if (log.startsWith("[+]")) textColor = const Color(0xFF30d158);
                  else if (log.startsWith("[-]")) textColor = const Color(0xFFff2d55);
                  else if (log.startsWith("[!]")) textColor = Colors.orange;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      log,
                      style: TextStyle(color: textColor, fontFamily: 'IBM Plex Mono'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetInfoPanel() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF0a0c13),
              border: Border(bottom: BorderSide(color: Color(0xFF1c1c1e))),
            ),
            child: const Text("/// TARGET INFO", style: TextStyle(color: Color(0xFF64d2ff), fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("CMS", "WordPress"),
                _buildInfoRow("Version", "6.4.2"),
                _buildInfoRow("Theme", "twentytwentyfour"),
                _buildInfoRow("Plugins", "7 Detected"),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFF1c1c1e)),
                const SizedBox(height: 8),
                const Text("VULNERABILITÀ", style: TextStyle(color: Color(0xFFff2d55))),
                const SizedBox(height: 8),
                _buildVulnBadge("High", "REST API User Enum"),
                _buildVulnBadge("Medium", "Outdated Plugin (Contact Form 7)"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF8e8e93))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVulnBadge(String severity, String desc) {
    final color = severity == "High" ? const Color(0xFFff2d55) : Colors.orange;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, size: 14, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(desc, style: TextStyle(color: color, fontSize: 12))),
        ],
      ),
    );
  }
}
