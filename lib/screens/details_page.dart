import 'package:flutter/material.dart';
import 'package:rijksbook/domain.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.art}) : super(key: key);

  final Art art;

  static void go(BuildContext context, {required Art art}) => Navigator.of(context)
      .push<void>(MaterialPageRoute<void>(builder: (BuildContext context) => DetailsPage(art: art)));

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Hello world')),
      );
}
