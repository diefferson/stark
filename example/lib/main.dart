import 'package:flutter/material.dart';
import 'package:stark/stark.dart';

void main() => runApp(MyApp());

class Api{
  Future<String> getText()async{
    return "Api return";
  }
}

class Repository{

  final Api _api;

  Repository(this._api);

  Future<String> getText() async {
     final apiResult = await _api.getText();
     return "$apiResult + Respository data";
  }
}


class ViewModel{

  final Repository _repository;
  final String _dynamicParams;

  ViewModel(this._repository, this._dynamicParams);

  Future<String> getText() async {
    final repositoryResult = await _repository.getText();
    return "$repositoryResult +  ViewModle data and  $_dynamicParams";
  }
}


class MyApp extends StatelessWidget {

  final module = {
    Single((i) => Api()),
    Single((i) => Repository(i.get())),
    Single.withParams((i, p) => ViewModel(i.get(), p["name"])),
  };

  @override
  Widget build(BuildContext context) {
    Stark.init([module]);
    return MaterialApp(
      title: 'Stark Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stark Example'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = Stark.get<ViewModel>(params: {"name": "Custom dynamic param"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: viewModel.getText(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text(snapshot.data);
            }
              return CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}
