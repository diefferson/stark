# stark  ![](./reator.png)


- **[What is Stark?](#what-is-stark)**
- **[Some info](#some-info)**  
- **[Getting Started](#getting-started)**  
  - [Usage example](#usage-example)
  - [Modules definition](#modules-definition)
  - [Initialize Stark](#initialize-stark)
  - [Getting a inject instance](#getting-a-inject-instance)
- **Reference**
  - [Singleton definition](#singleton-definition)
  - [Factory definition](#factory-definition)
  - [Named injections](#named-injections)
  - [Dynamic params](#dynamic-params)
  - [Scoped injections](#scoped-injections)
  - [Disposable Interface](#disposable-interface)
  - [Arch Components](#arch-components)

## What is Stark?
A pragmatic lightweight dependency injection framework for Dart developers.

## Some info

This implementation *does not* rely on the dart reflection apis (mirrors) and favours a simple factory based approach.
This increases the performance and simplicity of this implementation.

Any help is appreciated! Comment, suggestions, issues, PR's!

## Getting Started

In your flutter or dart project add the dependency:

```yml
dependencies:
  ...
  stark: 3.0.1
```

## Usage example

Import `stark`

```dart
import 'package:stark/stark.dart';
```

### Modules definition
```dart
import 'package:stark/stark.dart';

final appModule = Module() 
    ..single((i) => Api())
    ..single<Repository>((i) => MyRepository(i.get()))
    ..factory((i) => UseCase(i.get())),
    ..factoryWithParams((i, p) => ViewModel(i.get(), p["dynamicParam"]));

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

#### Initialize Stark with logger
```dart
Stark.init([...], logger: Logger());
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

## Singleton definition:
```dart
import 'package:stark/stark.dart';

final myModule = Module()
    ..single((i) => Api(i.get())); 

```

### Single with dynamic param:
```dart
import 'package:stark/stark.dart';

final myModule = Module()
  ..singleWithParams((i,p) => Api(p["token"]));
```

## Factory definition
```dart
import 'package:stark/stark.dart';

final myModule = Module()
  ..factory((i) => UseCase());
```
### Factory with dynamic param:
```dart
import 'package:stark/stark.dart';

final myModule = Module()
  ..factoryWithParams((i,p) => Api(p["token"]));
```

## Named injections
```dart
import 'package:stark/stark.dart';

final myModule = Module()
  ..single((i) => Api(), named: "DEFAULT")
  ..single((i) => Api(), named: "EXTERNAL");


// to get named injections
Stark.get<Api>(named: "DEFAULT");

```

## Dynamic params
```dart
import 'package:stark/stark.dart';

final myModule = Module()
  ..singleWithParams((i,p) => Api(p["token"]))
  ..factoryWithParams((i,p) => MyPresenter(p["view"]));


// to get with dynamic params
Stark.get<Api>(params: { "token" : "Bearer asdasdad"})
Stark.get<MyPresenter>(params: { "view" : this})

```

## Scoped injections

- You can mix your class with Stark component to associate the injection life time to your widget:

```dart
class _MyHomePageState extends State<MyHomePage> with StarkComponent {
  ViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    //View model instance will destroyed when this widget state call dispose.
    _viewModel = get<ViewModel>(
        params: <String, dynamic>{'name': 'Custom dynamic param'});
  }
...
 ````

### Disposable Interface
Stark provides a Disposable interface, when a injection that implements this interface is will be dispose the method dispose is called, is very nice to viewModels for example:
```dart

class LoginViewModel implements Disposable {
    @override
    dispose(){
      //this method is called when the LoginViewModel is diposed, use to dispose your RX Subjects or Streams
    }
}

```


### Arch Components
You could use `StarkPresenter` and `StarkState` or `StartkWidget` pro get a injected and scoped presenter in your statefull widget: 

```dart

class MyPresenter extends StarkPresenter {
   final text = 'Hello World';
}

class MyWidget extends StarkWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends StarkState<MyWidget, MyPresenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        presenter.text
      )
    );
  }
}

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
