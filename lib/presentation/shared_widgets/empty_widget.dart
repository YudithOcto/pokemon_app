import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/theme_colors.dart';
import 'package:pokemon_app/utils/theme_text.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback onRetry;
  EmptyWidget({@required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('We could not load data. Please try again',
              style: ThemeText.proximaBody),
          SizedBox(height: 10.0),
          InkWell(
            onTap: onRetry,
            child: Container(
              height: 38.0,
              alignment: FractionalOffset.center,
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 70.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Retry',
                style: ThemeText.proximaBody.copyWith(
                    fontWeight: FontWeight.w600, color: ThemeColors.black0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
