import 'package:flutter/material.dart';

class CenteredCircularProgress extends StatelessWidget {
  final String message;
  final double size;

  const CenteredCircularProgress({
    Key key,
    this.message = 'Carregando',
    this.size = 64.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: size,
            width: size,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            message ?? '',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }
}
