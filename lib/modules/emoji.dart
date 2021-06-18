import 'package:flutter/material.dart';

class EmojiView extends StatefulWidget {
  final double left;
  final double top;
  final Function ontap;
  final Function(DragUpdateDetails) onpanupdate;
  final Function(DraggableDetails) onpanend;
  final double fontsize;
  final Image value;
  final TextAlign align;
  
  const EmojiView(
      {Key key,
      this.left,
      this.top,
      this.ontap,
      this.onpanupdate,
      this.fontsize,
      this.value,
      this.align,
      this.onpanend})
      : super(key: key);
  @override
  _EmojiViewState createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.left,
        top: widget.top,
        child: GestureDetector(
        onTap: widget.ontap,
       onPanUpdate: widget.onpanupdate,
       // child: Image.network(widget.value, height: widget.fontsize,)
        child: Image(image: widget.value.image, height:widget.fontsize),
    ),
      );
  }
}
