import 'package:flutter/material.dart';
import 'package:random_data_generator/random_data_generator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _randomDataGenerate() {
    String randomQuote = RandomData.quote();
    String ancientAnimalName = RandomData.generateAncientAnimalName();
    int number = RandomData.generateRandomIntBetween(1, 20);
    String Uuid = RandomData.generateUuid(UuidVersion.v1, UuidVariant.ncs);
    String strongPassword = RandomData.generateStrongPassword();
    int flakeUuid = RandomData.generateFlakeUuid(21);
    String Xid = RandomData.generateXid();
    String nanoId = RandomData.generateNanoId(size: 21);
    String Ulid = RandomData.generateUlid();
    String currencyNamWithSign = RandomData.generateRandomCurrencyNamWithSign();
    List<int> rgbColor = RandomData.getRandomRGBColor();

    debugPrint("randomQuote: $randomQuote"); //randomQuote: Success is not how high you have climbed, but how you make a positive difference to the world. – Roy T. Bennett
    debugPrint("ancientAnimalName: $ancientAnimalName"); //ancientAnimalName: Saber-toothed Cat
    debugPrint("number: ${number.toString()}"); //number: 18
    debugPrint("Uuid: $Uuid"); //Uuid: c620b921-de7b-1721-2e70-44d61ce683dc
    debugPrint("strongPassword: $strongPassword"); //strongPassword: u=Y2r6j#5JVG
    debugPrint("flakeUuid: ${flakeUuid.toString()}"); //flakeUuid: 1682001920
    debugPrint("Xid: $Xid"); //Xid: 1044dd9116f529ab77000000
    debugPrint("nanoId: $nanoId"); //nanoId: kJz2H4v8A4KT1IkMrzhaP
    debugPrint("Ulid: $Ulid"); //Ulid: 00lvdug4nlYH2XHRDDTGVRFA4R
    debugPrint("currencyNamWithSign: $currencyNamWithSign"); //currencyNamWithSign: Cape Verdean Escudo (₲)
    debugPrint("rgbColor: $rgbColor"); //rgbColor: [87, 145, 3]

    /*
    same as 100+ data they can generate which included UDID,UUID,NANO ID
    also generate multiple random data like Quote
    "The only way to do great work is to love what you do. – Steve Jobs",
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomDataGenerate,
        tooltip: 'Random Data Generate',
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
