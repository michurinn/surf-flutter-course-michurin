import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/sight_details.dart';

void showDetailsBottomSheet(BuildContext context, Place element) =>
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => DraggableScrollableSheet(
        expand: true,
        snap: true,
        maxChildSize: 0.95,
        minChildSize: 0.9,
        initialChildSize: 0.95,
        builder: (context, scrollController) => SightDetails(
          sight: element,
          scrollController: scrollController,
        ),
      ),
    );
