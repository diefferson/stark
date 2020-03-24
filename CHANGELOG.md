## [0.0.1] - First version

## [0.0.2] - Scoped Dependencies
    
# When you define a scope for an injection, you can dipose it by associating it with a Scope Widget or manually using Stark.disposeScope (name)
# If your injected class implements Disposable interface the dispose method is called before discard instance.

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
