import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';

class FileCard extends StatelessWidget {
  final File? file;
  final String? fileUrl;
  final bool isImg;
  final String name;
  final Function onSelect;
  const FileCard(
      {Key? key,
      required this.file,
      required this.fileUrl,
      required this.isImg,
      required this.name,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: btnColor,
                width: 0.8,
                style: BorderStyle.solid,
              ),
            ),
          ),
          file?.path == "" && fileUrl == null
              ? Positioned(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: btnColor,
                      fontSize: mf,
                    ),
                  ),
                )
              : fileUrl != null
                  ? isImg
                      ? Image.network(
                          fileUrl ?? "",
                          width: double.infinity,
                          fit: BoxFit.contain,
                        )
                      : Text(
                          'Download\nURL\navailable',
                          style: TextStyle(
                            color: btnColor,
                            fontSize: mf,
                          ),
                          textAlign: TextAlign.center,
                        )
                  : Image.file(
                      file!,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
        ],
      ),
    );
  }
}
