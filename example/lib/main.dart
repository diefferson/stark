import 'package:flutter/material.dart';
import 'package:stark/stark.dart';

void main() => runApp(MyApp());

// API: here you could call http requests with Dio as example
class Api {
  Future<String> getText() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 500));
    return 'example Api async return';
  }
}

// Interface to your repository implementations
abstract class Repository {
  Future<String> getText();
}

// Implementation of Repository with Api as injected parameter
class MyRepository implements Repository {
  MyRepository(this._api);
  final Api _api;

  @override
  Future<String> getText() async {
    final apiResult = await _api.getText();
    return apiResult;
  }
}

// Implementation of presenter with injected repository
class Presenter extends StarkPresenter {
  Presenter(this._repository);

  final Repository _repository;

  Future<String> getText() async {
    final repositoryResult = await _repository.getText();
    return repositoryResult;
  }
}

class MyApp extends StatelessWidget {
  //Example of a StarkModule
  final module = Module()
    ..single((i) => Api())
    ..single<Repository>((i) => MyRepository(i.get()))
    ..singleWithParams((i, p) => Presenter(i.get()));

  @override
  Widget build(BuildContext context) {
    //Initializing Start
    Stark.init([module], logger: Logger(level: Level.DEBUG));

    //Normal material App
    return MaterialApp(
      title: 'Stark Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stark Example'),
    );
  }
}

class MyHomePage extends StarkWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StarkState<MyHomePage, Presenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<String>(
          // you could call presenter directly
          future: presenter.getText(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data ?? '');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
