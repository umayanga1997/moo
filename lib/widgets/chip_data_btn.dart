import 'package:flutter/material.dart';
import 'package:moo/controllers/language_controller.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/widgets/widget.dart';
import 'package:provider/provider.dart';

class ChipDataButton extends StatelessWidget {
  final String dataKey;
  final String title;
  const ChipDataButton({Key? key, required this.title, required this.dataKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            curve: Curves.linear,
            opacity: context.watch<LanguageController>().lanSearchKey == dataKey
                ? 1
                : 0,
            child: ClipWidget(
              title: title,
              bgColor: greenColor,
              isBorder: false,
            ),
          ),
          context.watch<LanguageController>().lanSearchKey == dataKey
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    context.read<LanguageController>().changeSearchKey(dataKey);
                    // Theme.of(context).chipTheme.copyWith(
                    //       backgroundColor: whiteColor,
                    //       brightness: Brightness.light,
                    //       labelStyle: TextStyle(
                    //         color: greenColor,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         side: BorderSide(
                    //           color: greenColor,
                    //         ),
                    //       ),
                    //     );
                  },
                  child: ClipWidget(
                    title: title,
                    isBorder: true,
                  ),
                ),
        ],
      ),
    );
  }
}
