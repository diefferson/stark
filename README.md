# stark  ![](./reator.png)

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
  stark: 0.0.2
```

## Usage example

Import `stark`

```dart
import 'package:stark/stark.dart';
```

### Modules definition
```dart
import 'package:stark/stark.dart';

final appModule = {
    single((i) => Api()), 
    single<Repository>((i) => MyRepository(i.get())),
    factory((i) => UseCase(i.get())), 
    factoryWithParams((i, p) => ViewModel(i.get(), p["dynamicParam"])),
};
```

### Initialize Stark 
```dart

//You can pass a list with many modules
Stark.init([
  appModule,
  domainModule,
  presentationModule
]);

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

## Singleton definition
```dart
import 'package:stark/stark.dart';

final myModule = {
    single((i) => Api(i.get())), 
};
```

## Factory definition
```dart
import 'package:stark/stark.dart';

final myModule = {
    factory((i) => UseCase()), 
};
```

## Named injections
```dart
import 'package:stark/stark.dart';

final myModule = {
    single((i) => Api(), named: "DEFAULT"), 
    single((i) => Api(), named: "EXTERNAL"), 
};


// to get named injections
Stark.get<Api>(named: "DEFAULT");

```

## Dynamic params
```dart
import 'package:stark/stark.dart';

final myModule = {
    singleWithParams((i,p) => Api(p["token"])), 
    factoryWithParams((i,p) => MyPresenter(p["view"])), 
};


// to get with dynamic params
Stark.get<Api>(params: { "token" : "Bearer asdasdad"})
Stark.get<MyPresenter>(params: { "view" : this})

```

## Scoped injections

- When you define a scope for an injection, you can dipose it by associating it with a Scope Widget or manually using Stark.disposeScope (name)
- If your injected class implements Disposable interface the dispose method is called before discard instance.

```dart
import 'package:stark/stark.dart';

final myModule = {
    single((i) => LoginViewModel(i.get<>()), scope: "Login" ), 
};

...
 
//Using Scope widget the "Login" scope is disposed when widget is disposed
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Scope(  
      name: "Login",
      child: LoginWidgetScreen()
    )
  );
}

class LoginViewModel implements Disposable {
    @override
    dispose(){
      //this method is called when the "Login" scope is diposed, use to dispose your RX Subjects or Streams
    }
}


//Or You can dispose manually using:
Stark.disposeScope("Login");

```

## License

Copyright 2020 The Stark Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
