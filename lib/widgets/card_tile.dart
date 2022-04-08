
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final String? cardTitle;
  final IconData? icon;
  final Color? iconBgColor;
  final String? mainText;
  final String? subText;

  const CardTile(
      {Key? key,
        this.cardTitle,
        this.icon,
        this.iconBgColor,
        this.mainText,
        this.subText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return FittedBox(
      child: SizedBox(
        height: _media.height / 5.0,
        width: _media.width / 5.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Material(
              elevation: 10,
              color: Colors.white,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: _media.height / 5.5,
                width: _media.width / 6.0,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      cardTitle!,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      child: Text(
                        mainText!,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Divider(),
                    Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: Text(
                            subText!,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 40,
              child: Material(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(4),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: _media.height / 18,
                  width: _media.width / 20,
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}