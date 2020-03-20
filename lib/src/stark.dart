
import 'package:stark/src/injector.dart';
import 'module.dart';

class Stark {

    Stark._();
    static var _initialized = false;

    static init(List<Set<Bind>> modules){
      if(!_initialized) {
        _initialized = true;
        modules.forEach((binds){
          binds.forEach((bind) {
            Injector.getInjector().registerBind(bind);
          });
        });
      }
    }

    static T get<T>({String name, Map<String, dynamic> params}){
      return Injector.getInjector().get<T>(named: name, params: params);
    }

    static clear(){
      Injector.getInjector().dispose();
    }
}