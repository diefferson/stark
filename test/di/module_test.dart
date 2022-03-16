import 'package:flutter_test/flutter_test.dart';
import 'package:stark/src/di/injector.dart';
import 'package:stark/src/di/module.dart';

import '../mocks.dart';
import '../widget_mock.dart';

void main() {
  final Injector injector = Injector.getInjector();
  setUp(() {
    injector.dispose();
  });

  test(
      'Given Bind was declared as a single, should allwaye returns the same instance',
      () {
    final module = Module()..single((i) => TestClass());

    injector.registerModule(module);

    final TestClass firstInstance = injector.get();
    final TestClass secondInstance = injector.get();

    expect(firstInstance, secondInstance);
  });

  test(
      'Given Bind was declared with params, should returns the instance with this param',
      () {
    final module = Module()
      ..factoryWithParams((i, p) => TestClass(param: p?['param']));

    injector.registerModule(module);

    final TestClass firstInstance =
        injector.get(params: <String, dynamic>{'param': 'firstInstance'});
    final TestClass secondInstance =
        injector.get(params: <String, dynamic>{'param': 'secondInstance'});

    expect(firstInstance.param, 'firstInstance');
    expect(secondInstance.param, 'secondInstance');
  });

  test(
      'Given Bind was declared as a factory, should allwaye returns a new instance',
      () {
    final module = Module()..factory((i) => TestClass());

    injector.registerModule(module);

    final TestClass firstInstance = injector.get();
    final TestClass secondInstance = injector.get();

    expect(firstInstance, isNot(equals(secondInstance)));
  });

  test(
      'Given a Bind was declared as a single with a component, should return the same instance while the component lives',
      () {
    final module = Module()..single<TestClass>((i) => TestClass());

    final component = WidgetMockState();

    injector.registerModule(module);

    final TestClass firstInstance = injector.get(component: component);
    final TestClass secondInstance = injector.get(component: component);
    final TestClass thirdInstance = injector.get();

    expect(firstInstance, secondInstance);
    expect(firstInstance, thirdInstance);

    injector.disposeComponent(component);

    final TestClass fourhInstance = injector.get(component: component);

    expect(fourhInstance, isNot(equals(firstInstance)));
  });

  test('Single Bind should instantiante bind with correct atributes', () {
    final factoryFunc = (i) => TestClass();
    final module = Module()..single(factoryFunc, named: 'Single');

    expect(module.binds[0].isSingleton, true);
    expect(module.binds[0].factoryFunc, factoryFunc);
    expect(module.binds[0].factoryFuncParams, null);
    expect(module.binds[0].name, 'Single');
    expect(module.binds[0].type, TestClass);
  });

  test('Factory Bind should instantiante bind with correct atributes', () {
    final factoryFunc = (i) => TestClass();
    final module = Module()..factory(factoryFunc, named: 'Factory');

    expect(module.binds[0].isSingleton, false);
    expect(module.binds[0].factoryFunc, factoryFunc);
    expect(module.binds[0].factoryFuncParams, null);
    expect(module.binds[0].name, 'Factory');
    expect(module.binds[0].type, TestClass);
  });

  test(
      'Single with params Bind should instantiante bind with correct atributes',
      () {
    final factoryFuncParams = (i, p) => TestClass(param: p?['param']);
    final module = Module()
      ..singleWithParams(factoryFuncParams, named: 'Single with params');

    expect(module.binds[0].isSingleton, true);
    expect(module.binds[0].factoryFunc, null);
    expect(module.binds[0].factoryFuncParams, factoryFuncParams);
    expect(module.binds[0].name, 'Single with params');
    expect(module.binds[0].type, TestClass);
  });

  test(
      'Factory with params Bind should instantiante bind with correct atributes',
      () {
    final factoryFuncParams = (i, p) => TestClass(param: p?['param']);
    final module = Module()
      ..factoryWithParams(factoryFuncParams, named: 'Factory with params');

    expect(module.binds[0].isSingleton, false);
    expect(module.binds[0].factoryFunc, null);
    expect(module.binds[0].factoryFuncParams, factoryFuncParams);
    expect(module.binds[0].name, 'Factory with params');
    expect(module.binds[0].type, TestClass);
  });
}
