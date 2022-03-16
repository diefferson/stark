## [0.0.1] - First version

## [0.0.2] - Scoped Dependencies
    
- When you define a scope for an injection, you can dipose it by associating it with a Scope Widget or manually using Stark.disposeScope (name)
- If your injected class implements Disposable interface the dispose method is called before discard instance.

```dart

final myModule ={
  single((i) => Api(),scoped: "MyScope"),
};

Scope(
  name: "MyScope",
  child: MyWidget() // widget to associate the scope
) // Use scope with a normal Widget.


//To dispose a scope manually uses:
Stark.diposeScope("MyScope");

```
## [0.0.3] - Scope dispose fix

## 1.0.0 - First stable relase 

## 2.0.0 - KoinComponent
## 2.0.1 - Null Sefaty

## 2.0.1 - Type error fixes

## 2.0.3 - New Injectable State and refactor disposable interface
## 2.0.4 - refactor disposable interface


## 3.0.3 - Arch components


