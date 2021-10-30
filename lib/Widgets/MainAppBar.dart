import 'package:flutter/material.dart';

enum AppBarMode {
  menu,
  back,
}

// ignore: must_be_immutable
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarMode _appBarMode;
  final double _elevation;
  Color backgroundColor;

  MainAppBar(
      {final AppBarMode appBarMode = AppBarMode.menu,
      final elevation: 0.0,
      this.backgroundColor = Colors.white})
      : this._appBarMode = appBarMode,
        this._elevation = elevation;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: _elevation,
      backgroundColor: backgroundColor,
      title: GestureDetector(
        onTap: () => {},
        child: Container(),
      ),
      leading: _appBarMode == AppBarMode.menu
          ? GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: RotatedBox(
                  quarterTurns: 4,
                  child: Icon(
                      Icons.sort,
                      size: 30,
                  ),
              ),
            )
          : _appBarMode == AppBarMode.back
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,//Colors.accentColor
                    size: 36.0,
                  ),
                )
              : null,
      actions: [
        /*if (_appBarMode == AppBarMode.menu)
          GestureDetector(
            onTap: () => (){},
            child: Icon(
              Icons.exit_to_app,
              size: 36.0,
              color: Colors.black
            ),
          )*/
      ],
    );
  }
}
