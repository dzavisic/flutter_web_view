import 'package:flutter/material.dart';
import 'package:flutter_web_view_private/shared/interfaces/orientation.interface.dart';

OrientationType orientationType = OrientationType();

Widget xsSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 10,
    );
  }
  return const SizedBox(
    height: 10,
  );
}

Widget sSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 20,
    );
  }
  return const SizedBox(
    height: 20,
  );
}

Widget mSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 30,
    );
  }
  return const SizedBox(
    height: 30,
  );
}

Widget mlSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 40,
    );
  }
  return const SizedBox(
    height: 40,
  );
}

Widget lSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 60,
    );
  }
  return const SizedBox(
    height: 60,
  );
}

Widget xlSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 90,
    );
  }
  return const SizedBox(
    height: 90,
  );
}

Widget xxlSpacing(orientation) {
  if (orientation == orientationType.Horizontal) {
    return const SizedBox(
      width: 130,
    );
  }
  return const SizedBox(
    height: 130,
  );
}