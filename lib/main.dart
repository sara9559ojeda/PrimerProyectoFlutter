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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
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
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DynamicListScreen())),
              child: const Text("Lista Dinámica"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RowColScreen())),
              child: const Text("Row & Column"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CreativeScreen())),
              child: const Text("Pantalla Creativa"),
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
            leading: Icon(Icons.home, color: Colors.deepPurple),
            title: Text("Element 1"),
          ),
          const ListTile(
            leading: Icon(Icons.search, color: Colors.deepPurple),
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
        title: const Text("Pantalla Creativa"),
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
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 15),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Apellido",
              prefixIcon: Icon(Icons.badge),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              final nombre = _nameController.text;
              final apellido = _lastNameController.text;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Hola $nombre $apellido mira estos gatitos para alegrar tu dia :'3")),
              );
            },
            child: const Text("Enviar"),
          ),

          const SizedBox(height: 30),

          const Text("Galería de Imágenes", 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Image.network("https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.wikipedia.org%2Fwiki%2FGato_atigrado&psig=AOvVaw3GQl7W8owy-yQzmiVZm1-w&ust=1755821899375000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCOC0xbbQmo8DFQAAAAAdAAAAABAf", fit: BoxFit.cover),
          const SizedBox(height: 10),
          Image.network("https://www.anicura.es/cdn-cgi/image/f=auto,fit=cover,w=640,h=640,g=auto,sharpen=1/AdaptiveImages/powerinit/52437/_SNI2031.jpg?stamp=a2efc90c9d13cd9fdc0f5f7a2e3b2231238dc8cf", fit: BoxFit.cover),
          const SizedBox(height: 10),
          Image.network("https://picsum.photos/300/202", fit: BoxFit.cover),
        ],
      ),
    );
  }
}
