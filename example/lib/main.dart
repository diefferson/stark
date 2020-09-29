import 'package:flutter/material.dart';
import 'package:stark/stark.dart';

void main() => runApp(MyApp());

class Api {
  Future<String> getText() async {
    return 'Api return';
  }
}

abstract class Repository {
  Future<String> getText();
}

class MyRepository implements Repository {
  MyRepository(this._api);
  final Api _api;

  @override
  Future<String> getText() async {
    final apiResult = await _api.getText();
    // ignore: prefer_single_quotes
    return "$apiResult + Respository data";
  }
}

class ViewModel {
  ViewModel(this._repository, this._dynamicParams);

  final Repository _repository;
  final String _dynamicParams;

  Future<String> getText() async {
    final repositoryResult = await _repository.getText();
    return '$repositoryResult +  ViewModle data and  $_dynamicParams';
  }
}

class MyApp extends StatelessWidget {
  final module = {
    single((i) => Api(), scope: ''),
    single<Repository>((i) => MyRepository(i.get())),
    singleWithParams((i, p) => ViewModel(i.get(), p['name'])),
  };

  @override
  Widget build(BuildContext context) {
    Stark.init([module]);
    return MaterialApp(
      title: 'Stark Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stark Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with StarkComponent {
  final ViewModel viewModel = Stark.get<ViewModel>(
      params: <String, dynamic>{'name': 'Custom dynamic param'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: viewModel.getText(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
