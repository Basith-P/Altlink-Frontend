import 'dart:io';

import 'package:altlink/core/config/theme/app_colors.dart';
import 'package:altlink/core/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSelector extends ConsumerWidget {
  const ImageSelector({super.key, required ValueNotifier<File?> imageNotifier})
      : _imageNotifier = imageNotifier;

  final ValueNotifier<File?> _imageNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: _imageNotifier,
            builder: (_, image, __) {
              if (image != null) {
                return Image.file(image,
                    fit: BoxFit.cover, width: double.infinity);
              }
              return const SizedBox.shrink();
            },
          ),
          Center(
            child: IconButton(
              onPressed: () async {
                final picker = ref.read(imagePickerProvider);
                final image = await picKImageFromGallery(picker);
                if (image != null) {
                  _imageNotifier.value = image;
                }
              },
              icon: const Icon(FluentIcons.image_add_24_regular),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.bgDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
