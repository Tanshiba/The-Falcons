import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Badges extends StatelessWidget {
  final Widget? child;
  final int value;
  final Color color;
  const Badges({
    Key? key,
    required this.child,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child!,
        Positioned(
          right: 8,
          top: 8,
          child:  Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color
            ),
            constraints: const BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(value == null ? '': value.toString(), textAlign: TextAlign.center, style:  const TextStyle(fontSize: 10,),),
          ),
        )
      ],
    );
  }
}
