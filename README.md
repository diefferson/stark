# stark  ![logo](./reator.jpg)

## What is Stark?
A pragmatic lightweight dependency injection framework for Dart developers.

## Some info

This project is based on [koin](https://github.com/InsertKoinIO/koin)

This implementation *does not* rely on the dart reflection apis (mirrors) and favours a simple factory based approach.
This increases the performance and simplicity of this implementation.

Any help is appreciated! Comment, suggestions, issues, PR's!

## Getting Started

In your flutter or dart project add the dependency:

```yml
dependencies:
  ...
  stark: 0.0.1
```

## Usage example

Import `stark`

```dart
import 'package:stark/stark.dart';
```

### Create a Module
```dart
import 'package:stark/stark.dart';

final appModule = {
    Single((i) => Api()), //Singleton definition
    Single((i) => Repository(i.get())), //Singleton definition with injection parameters
    Factory((i) => UseCase(i.get())) , //Factory definition
    Factory.withParams((i, p) => ViewModel(i.get(), p["dynamicParam"])), //Factory definition with dynamic params
};
```

### Initialize Stark in your initial class or Widget (for Flutter)
```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    //You can pass a list with many modules
    Stark.init([appModule]);

    return MaterialApp(
      ...
    );
  }
}
```


### Getting a inject instance

```dart
class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  final _loginViewModel = Stark.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
   
    return  Container(
        ...
    );
  }
}
```

## Features and bugs
Please send feature requests and bugs at the issue tracker.
