import 'package:flutter/material.dart';

import 'editor.dart';

/// Provides necessary layout for [ZefyrEditor].
class ZefyrScaffold extends StatefulWidget {
  final Widget child;
  final String custommode;
  final String customscrollmode;

  const ZefyrScaffold(
      {Key key, this.child, this.custommode, this.customscrollmode})
      : super(key: key);

  static ZefyrScaffoldState of(BuildContext context) {
    final _ZefyrScaffoldAccess widget =
        context.inheritFromWidgetOfExactType(_ZefyrScaffoldAccess);
    return widget.scaffold;
  }

  @override
  ZefyrScaffoldState createState() {
    return ZefyrScaffoldState(
        custommode: custommode, customscrollmode: customscrollmode);
  }
}

class ZefyrScaffoldState extends State<ZefyrScaffold> {
  WidgetBuilder _toolbarBuilder;
  String custommode;
  String customscrollmode;
  ZefyrScaffoldState({this.custommode, this.customscrollmode});

  void showToolbar(WidgetBuilder builder) {
    setState(() {
      _toolbarBuilder = builder;
    });
  }

  //bhkim
  void settoolbarBuilder(WidgetBuilder builder) {
    _toolbarBuilder = builder;
  }

  void hideToolbar() {
    if (_toolbarBuilder != null) {
      setState(() {
        _toolbarBuilder = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final toolbar =
        (_toolbarBuilder == null) ? Container() : _toolbarBuilder(context);
    //bhkim
    if (customscrollmode == "noscroll") {
      return _ZefyrScaffoldAccess(
        scaffold: this,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            //bhkim
            toolbar,
            widget.child,
          ],
        ),
      );
    } else {
      return _ZefyrScaffoldAccess(
        scaffold: this,
        child: Column(
          children: <Widget>[
            //bhkim
            toolbar,
            Expanded(child: widget.child),
          ],
        ),
      );
    }
  }
}

class _ZefyrScaffoldAccess extends InheritedWidget {
  final ZefyrScaffoldState scaffold;

  _ZefyrScaffoldAccess({Widget child, this.scaffold}) : super(child: child);

  @override
  bool updateShouldNotify(_ZefyrScaffoldAccess oldWidget) {
    return oldWidget.scaffold != scaffold;
  }
}
