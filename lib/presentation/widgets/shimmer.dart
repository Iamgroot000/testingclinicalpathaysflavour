
import 'package:auto_size_text/auto_size_text.dart';
import 'package:testing_clinicalpathways/presentation/exporter/appConstExport.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/AppColors.dart';
import '../utils/ScreenSize.dart';


///LOADING SHIMMER
class ShimmerForLoading extends StatelessWidget {
  const ShimmerForLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: ScreenSize.width(context) * 0.17,
      child: Shimmer.fromColors(
          baseColor: AppColor.greyShimmer,
          highlightColor: AppColor.white,
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration:  BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      height: ScreenSize.height(context) * 0.25,
                    ),
                    const SizedBox(height: 10,),
                  ],
                );
              })
      ),
    );
  }
}

