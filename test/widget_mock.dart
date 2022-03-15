import 'package:flutter/widgets.dart';

import 'package:stark/src/arch/stark_component.dart';

class WidgetMock extends StatefulWidget {
  @override
  WidgetMockState createState() => WidgetMockState();
}

class WidgetMockState extends State<WidgetMock> with StarkComponent {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
