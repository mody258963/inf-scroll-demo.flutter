import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();
  final List<String> _counter =
      List.generate(17, (index) => 'item ${index + 1}');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    
  }

  void loadData() {
    setState(() {
      _counter.addAll(['item t', 'item c', 'item q']);
    });
  }

  void _scrollListener() {
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent 
        ) {
      Future.delayed(Duration(seconds: 1), () {
        loadData();
      });
    }
  }
  //   void _scrollListener() {
  //   if (_scrollController.offset >=
  //           _scrollController.position.maxScrollExtent &&  // This means the user has scrolled to the bottom of the list and the position is not out of range (not overscrolling)
  //       _scrollController.position.outOfRange) {
  //     Future.delayed(Duration(seconds: 1), () {
  //       loadData();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Infinite Scroll Example'),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: _counter.length + 1, // +1 for loading indicator
          itemBuilder: (context, index) {
            if (index < _counter.length) {
              final item = _counter[index];
              return ListTile(
                title: Text(item),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ));
  }
}
