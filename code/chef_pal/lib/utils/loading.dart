// written by: Shahir
// tested by:
// debugged by:
// Loading widget

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key, @required this.size}) : super(key: key);
  final size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SpinKitCircle(
          color: Colors.orange,
          size: MediaQuery.of(context).size.width / size,
          duration: Duration(milliseconds: 2000),
        ),
      ),
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      color: Colors.white,
    );
  }
}
