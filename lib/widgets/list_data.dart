import 'package:flutter/material.dart';
import 'package:moo/widgets/widget.dart';

enum WidgetType { circle, textbutton }

class ListData extends StatelessWidget {
  final String listTitle;
  final EdgeInsets padding;
  final List<dynamic> items;
  final WidgetType widgetType;
  const ListData(
      {Key? key,
      required this.listTitle,
      this.padding = const EdgeInsets.all(10),
      required this.items,
      required this.widgetType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              listTitle,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline2!.fontSize,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.headline2!.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: widgetType == WidgetType.circle
                ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: items.length,
                      addAutomaticKeepAlives: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CircleDataCard(
                          dataKey: items[index].key,
                          image: items[index].image,
                          title: items[index].title,
                        );
                      },
                    ),
                  )
                : SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: items.length,
                      addAutomaticKeepAlives: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChipDataButton(
                          dataKey: items[index].key,
                          title: items[index].data,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
