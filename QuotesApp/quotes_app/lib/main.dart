import 'package:flutter/material.dart';
import 'quote.dart';

void main() {
  runApp(const MaterialApp(
    home: QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  const QuoteList({super.key});

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes = [
    Quote('Ezio Auditore', 'Nothing is true, everything is Permitted'),
    Quote('The Creed', 'We work in the dark to serve the light'),
    Quote('Altaïr Ibn-La\'Ahad', 'Our Creed does not command us to be free. It commands us to be wise.')
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Awesome Quotes',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: quotes.map((quote) {
          return Text('${quote.text} - ${quote.author}');
        }).toList(),
      ),
    );
  }
}