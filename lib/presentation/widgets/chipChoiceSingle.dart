import 'package:chips_choice/chips_choice.dart';
import 'package:testing_clinicalpathways/presentation/exporter/appConstExport.dart';
import 'package:flutter/material.dart';

import '../utils/AppColors.dart';
import '../utils/ScreenSize.dart';

class SingleChipChoice<E> extends StatelessWidget {
  final String selectedValue;
  final List<E> choiceList;
  final ValueChanged<String> onChanged;
  final String Function(int index, E item) valueFn;
  final String Function(int index, E item) labelFn;
  final String Function(int index, E item) tooltipFn;

  const SingleChipChoice({super.key, required this.selectedValue, required this.choiceList, required this.onChanged, required this.valueFn, required this.labelFn, required this.tooltipFn});


  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.single(
      value: selectedValue,
      onChanged: onChanged,
      choiceItems: C2Choice.listFrom<String, E>(
        source: choiceList,
        value: valueFn,
        label: labelFn,
        tooltip: tooltipFn,
      ),
      choiceCheckmark: true,
      choiceStyle: C2ChipStyle.filled(
        overlayColor: AppColor.primaryColor,
        foregroundStyle: const TextStyle(fontWeight: FontWeight.w700),
        height: ScreenSize.height(context) * 0.04,
        color: AppColor.greyShimmer,
        selectedStyle: const C2ChipStyle(
          elevation: 2,
          backgroundColor: AppColor.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
