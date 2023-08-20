import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});
  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double amount = 0;
  final TextEditingController textEditingController = TextEditingController();

  void convert() {
    amount = double.parse(textEditingController.text) * 900;
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.blue, width: 1.0, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Currency Converter',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Convert Your USD to Naira',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(height: 20),
              // Currency converter title
              Text(
                "₦${amount != 0 ? amount.toStringAsFixed(2) : amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              // Input field
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: 'Enter amount in USD',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                  prefixIcon: Icon(Icons.monetization_on_sharp),
                  prefixIconColor: Colors.black54,
                  filled: true,
                  fillColor: Colors.black12,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                controller: textEditingController,
              ),
              const SizedBox(height: 20),
              // Convert button
              ElevatedButton(
                onPressed: convert,
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
