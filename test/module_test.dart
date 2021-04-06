import 'package:flutter_test/flutter_test.dart';
import 'package:stark/src/injector.dart';
import 'package:stark/src/module.dart';

import 'mocks.dart';
import 'widget_mock.dart';

void main() {
  final Injector injector = Injector.getInjector();

  setUp(() {
    injector.dispose();
  });

  test(
      'Given Bind was declared as a single, should allwaye returns the same instance',
      () {
    final bind = single((i) => TestClass());

    injector.registerBind<dynamic>(bind);

    final TestClass firstInstance = bind.get(injector);
    final TestClass secondInstance = bind.get(injector);

    expect(firstInstance, secondInstance);
  });

  test(
      'Given Bind was declared with params, should returns the instance with this param',
      () {
    final bind = factoryWithParams((i, p) => TestClass(param: p?['param']));

    injector.registerBind<dynamic>(bind);

    final TestClass? firstInstance =
        bind.get(injector, null, <String, dynamic>{'param': 'firstInstance'});
    final TestClass? secondInstance =
        bind.get(injector, null, <String, dynamic>{'param': 'secondInstance'});

    expect(firstInstance?.param, 'firstInstance');
    expect(secondInstance?.param, 'secondInstance');
  });

  test(
      'Given Bind was declared as a factory, should allwaye returns a new instance',
      () {
    final Bind bind = factory((i) => TestClass());

    injector.registerBind<dynamic>(bind);

    final TestClass firstInstance = bind.get(injector);
    final TestClass secondInstance = bind.get(injector);

    expect(firstInstance, isNot(equals(secondInstance)));
  });

  test(
      'Given a Bind was declared as a single with a component, should return the same instance while the component lives',
      () {
    final Bind bind = single<TestClass>((i) => TestClass());

    final component = WidgetMockState();

    injector.registerBind<dynamic>(bind);

    final TestClass firstInstance = bind.get(injector, component);
    final TestClass secondInstance = bind.get(injector, component);
    final TestClass thirdInstance = bind.get(injector);

    expect(firstInstance, secondInstance);
    expect(firstInstance, thirdInstance);

    injector.disposeComponent(component);

    final TestClass fourhInstance = bind.get(injector, component);

    expect(fourhInstance, isNot(equals(firstInstance)));
  });

  test('Single Bind should instantiante bind with correct atributes', () {
    final FactoryFunc<TestClass> factoryFunc = (i) => TestClass();
    final bind = single(factoryFunc, named: 'Single');

    expect(bind.isSingleton, true);
    expect(bind.factoryFunc, factoryFunc);
    expect(bind.factoryFuncParams, null);
    expect(bind.name, 'Single');
    expect(bind.type, TestClass);
  });

  test('Factory Bind should instantiante bind with correct atributes', () {
    final FactoryFunc<TestClass> factoryFunc = (i) => TestClass();
    final bind = factory(factoryFunc, named: 'Factory');

    expect(bind.isSingleton, false);
    expect(bind.factoryFunc, factoryFunc);
    expect(bind.factoryFuncParams, null);
    expect(bind.name, 'Factory');
    expect(bind.type, TestClass);
  });

  test(
      'Single with params Bind should instantiante bind with correct atributes',
      () {
    final FactoryFuncParams<TestClass> factoryFuncParams =
        (i, p) => TestClass(param: p?['param']);
    final bind =
        singleWithParams(factoryFuncParams, named: 'Single with params');

    expect(bind.isSingleton, true);
    expect(bind.factoryFunc, null);
    expect(bind.factoryFuncParams, factoryFuncParams);
    expect(bind.name, 'Single with params');
    expect(bind.type, TestClass);
  });

  test(
      'Factory with params Bind should instantiante bind with correct atributes',
      () {
    final FactoryFuncParams<TestClass> factoryFuncParams =
        (i, p) => TestClass(param: p?['param']);
    final bind =
        factoryWithParams(factoryFuncParams, named: 'Factory with params');

    expect(bind.isSingleton, false);
    expect(bind.factoryFunc, null);
    expect(bind.factoryFuncParams, factoryFuncParams);
    expect(bind.name, 'Factory with params');
    expect(bind.type, TestClass);
  });
}
