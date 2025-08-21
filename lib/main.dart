import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menú Principal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green, 
          foregroundColor: Colors.white, 
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, 
            foregroundColor: Colors.white, 
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CounterScreen())),
              child: const Text("Contador"),
            ),
            const SizedBox(height: 20), 

            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DynamicListScreen())),
              child: const Text("Lista Dinámica"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RowColScreen())),
              child: const Text("Row & Column"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CreativeScreen())),
              child: const Text("Pantalla Nueva"),
            ),
          ],
        ),
      ),
    );
  }
}


class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contador"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Valor: $counter", style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => counter++),
                  child: const Text("Sumar"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => setState(() {
                    if (counter > 0) counter--;
                  }),
                  child: const Text("Restar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicListScreen extends StatefulWidget {
  const DynamicListScreen({super.key});

  @override
  State<DynamicListScreen> createState() => _DynamicListScreenState();
}

class _DynamicListScreenState extends State<DynamicListScreen> {
  final List<String> items = [];

  void _addItem() {
    setState(() {
      items.add("Elemento ${items.length + 1}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Dinámica"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: _addItem, child: const Text("Agregar elemento")),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) => ListTile(
                leading: const Icon(Icons.star),
                title: Text(items[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowColScreen extends StatelessWidget {
  const RowColScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Row y Column"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ColoredBoxWidget(color: Colors.red),
              SizedBox(width: 10),
              ColoredBoxWidget(color: Colors.green),
            ],
          ),
          const SizedBox(height: 20),
          const Center(child: ColoredBoxWidget(color: Colors.blue)),

          const SizedBox(height: 40),

          const ListTile(
            leading: Icon(Icons.home, color: Colors.green),
            title: Text("Element 1"),
          ),
          const ListTile(
            leading: Icon(Icons.search, color: Colors.green),
            title: Text("Element 2"),
          ),
        ],
      ),
    );
  }
}

class ColoredBoxWidget extends StatelessWidget {
  final Color color;
  const ColoredBoxWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      color: color,
    );
  }
}

class CreativeScreen extends StatefulWidget {
  const CreativeScreen({super.key});

  @override
  State<CreativeScreen> createState() => _CreativeScreenState();
}

class _CreativeScreenState extends State<CreativeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla nueva"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Formulario", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),

          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nombre",
              prefixIcon: Icon(Icons.person, color: Colors.green),
            ),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Apellido",
              prefixIcon: Icon(Icons.badge, color: Colors.green),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              final nombre = _nameController.text;
              final apellido = _lastNameController.text;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hola $nombre $apellido mira estos gatitos para alegrar tu día :)")),
              );
            },
            child: const Text("Enviar"),
          ),

          const SizedBox(height: 30),

          const Text("Galería de Imágenes", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUSWjnSd77lh-vRDBbCR0LfDCWgAaLHB-0kw&s", fit: BoxFit.cover),
          const SizedBox(height: 10),
          Image.network("https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg", fit: BoxFit.cover),
          const SizedBox(height: 10),
          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQala6Xlg2jirjn2Je0XT3K2rj-fXpGjLZQQ&s", fit: BoxFit.cover),
        ],
      ),
    );
  }
}
