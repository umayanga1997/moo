import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:moo/helper/colors.dart';
import 'package:moo/helper/fonts.dart';
import 'package:moo/helper/help_functions.dart';

class FileCard extends StatelessWidget {
  final PlatformFile? file;
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
                color: isDark(context) ? whiteColor : greenColor,
                width: 0.8,
                style: BorderStyle.solid,
              ),
            ),
          ),
          file?.path == null && fileUrl == null
              ? Positioned(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: isDark(context) ? whiteColor : greenColor,
                      fontSize: mf,
                    ),
                  ),
                )
              : file?.path != null
                  ? isImg
                      ? Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(0),
                          child: Image.file(
                            File(file?.path ?? ""),
                            fit: BoxFit.fill,
                            width: 100,
                            height: 100,
                          ),
                        )
                      : Text(
                          'File\nSelected\n${formatBytes(file!.size, 2)}',
                          style: TextStyle(
                            color: greenColor,
                            fontSize: mf,
                          ),
                          textAlign: TextAlign.center,
                        )
                  : isImg
                      ? Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(0),
                          child: Image.network(
                            fileUrl ?? "",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(
                          'File\nAvailable',
                          style: TextStyle(
                            color: greenColor,
                            fontSize: mf,
                          ),
                          textAlign: TextAlign.center,
                        ),
        ],
      ),
    );
  }
}
