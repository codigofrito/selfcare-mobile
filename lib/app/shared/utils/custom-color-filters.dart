import 'package:flutter/material.dart';

class CustomColorFilter {
  static ColorFilter softGreyscale = ColorFilter.matrix(<double>[
    0.6,
    0.6,
    0.6,
    0,
    0,
    0.6,
    0.6,
    0.6,
    0,
    0,
    0.6,
    0.6,
    0.6,
    0,
    0,
    0,
    0,
    0,
    0.8,
    0,
  ]);

  static ColorFilter greyscale = ColorFilter.matrix(<double>[
    1.5,
    1.5,
    1.5,
    0,
    0,
    1.5,
    1.5,
    1.5,
    0,
    0,
    1.5,
    1.5,
    1.5,
    0,
    0,
    0,
    0,
    0,
    0.95,
    0,
  ]);
}
