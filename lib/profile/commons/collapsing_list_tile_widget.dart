import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  Function? onTap;

  CollapsingListTile(
      {required this.title,
      required this.icon,
      required this.animationController,
      this.isSelected = false,
      this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 15, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: widthAnimation.isCompleted
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: <Widget>[
            widthAnimation.isDismissed
                ? Icon(
                    widget.icon,
                    color:
                        widget.isSelected ? Color(0xFF4AC8EA) : Colors.white30,
                    size: 24.0,
                  )
                : Tooltip(
                    message: widget.title,
                    child: Icon(
                      widget.icon,
                      color: widget.isSelected
                          ? Color(0xFF4AC8EA)
                          : Colors.white30,
                      size: 24.0,
                    ),
                  ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.isDismissed)
                ? Text(widget.title,
                    style: widget.isSelected
                        ? TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)
                        : TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600))
                : Container()
          ],
        ),
      ),
    );
  }
}