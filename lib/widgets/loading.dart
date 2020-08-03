import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    Color oxff7878;
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(oxff7878),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
