import 'package:flutter/material.dart';

class ColorDetailPage extends StatelessWidget {
  ColorDetailPage(
      {required this.color, required this.title, this.materialIndex: 500});
  final MaterialColor color; // QnAAppearance // 넘겨줄 때 Colors.red 로 넘겨주었슴. 색깔 하나 넘겨주었으니 MatericalColor 로 해야지.
  final String title;
  final int materialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          '$title[$materialIndex]',
        ),
      ),
      body: Container(
        color: color[materialIndex], // 여기보면 알겠지만 색깔 하나에도 배열의 값이 존재한다. 배열로 채도를 조정한다는 뜻인가보다.
      ),
    );
  }
}
