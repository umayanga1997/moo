import 'package:flutter/material.dart';
import 'package:moo/controllers/category_controller.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:provider/provider.dart';

class CircleDataCard extends StatefulWidget {
  final String title;
  final String dataKey;
  final String image;
  const CircleDataCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.dataKey})
      : super(key: key);

  @override
  State<CircleDataCard> createState() => _CircleDataCardState();
}

class _CircleDataCardState extends State<CircleDataCard> {
  final Duration _duration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          children: [
            AnimatedOpacity(
              opacity: context.watch<Categorycontroller>().catSearchKey ==
                      widget.dataKey
                  ? 0
                  : 1,
              duration: _duration,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<Categorycontroller>()
                      .changeSearchKey(widget.dataKey);
                },
                child: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        // semanticContainer: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          "assets/images/${widget.image.toString()}",
                          fit: BoxFit.cover,
                          width: 75,
                          height: 75,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline4?.fontSize,
                            letterSpacing: 0.6,
                            color: Theme.of(context).textTheme.headline4?.color,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: context.watch<Categorycontroller>().catSearchKey ==
                      widget.dataKey
                  ? 1
                  : 0,
              duration: _duration,
              child: AnimatedContainer(
                duration: _duration,
                alignment: Alignment.center,
                // transform: Matrix4.identity()..rotateY(320),
                // ..setEntry(2, 2, 0.05),
                transformAlignment: Alignment.center,
                curve: Curves.linear,
                height: context.watch<Categorycontroller>().catSearchKey ==
                        widget.dataKey
                    ? 80
                    : 0,
                width: context.watch<Categorycontroller>().catSearchKey ==
                        widget.dataKey
                    ? 80
                    : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: greenColor,
                ),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: mf,
                    letterSpacing: 0.6,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ));
  }
}
