



import 'package:flutter/material.dart';

/// Defines grid parameters
class GridBackgroundParams {
  /// square size
  final double gridSquare;

  /// thickness of lines
  final double gridThickness;

  /// how many vertical or horizontal lines to draw the marked lines
  final int secondarySquareStep;

  /// grid background color
  final Color backgroundColor;

  /// grid lines color
  final Color gridColor;

  const GridBackgroundParams({
    this.gridSquare = 20.0,
    this.gridThickness = 0.3,
    this.secondarySquareStep = 5,
    this.backgroundColor = Colors.white,
    this.gridColor = Colors.black12,
  });
}