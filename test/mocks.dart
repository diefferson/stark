import 'package:mockito/mockito.dart';
import 'package:stark/src/di/injector.dart';

class TestClass {
  TestClass({this.param});

  final String? param;
}

class InjectorMock extends Mock implements Injector {}
