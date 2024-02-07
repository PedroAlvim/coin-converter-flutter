import 'package:coin_converter/src/repositories/coin_converter_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final _coinConverterRepository = CoinConverterRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(
                labelText: 'Valor em Real',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(
                labelText: 'Valor em dolar',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _converterCoin(double.parse(_controller1.text));
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _converterCoin(double amount) {
    _coinConverterRepository
        .getCoinValue(amount)
        .then((result) => {
              if (result.successful)
                {_controller2.text = result.data.toString()}
              else
                {
                  // todo tratar erro
                }
            })
        .catchError((error, stackTrace) {
      // todo tratar erro
    });
  }
}
