import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconWidget extends StatelessWidget {
  final String icon;
  final String label;
  final Color backgroundIconColor;
  final Color iconColor;
  final void Function()? onTap;
  const CustomIconWidget({
    super.key, required this.icon, required this.label, required this.backgroundIconColor, required this.iconColor, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundIconColor,
            // border: Border.all(
            //   color:backgroundIconColor,
            //     width: 3.0.w
            // ),
            borderRadius: BorderRadius.all(
                Radius.circular(16)),
          ),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: SizedBox(
                height: 40.h,
                width: 40.w,
                  child: Image.asset(icon)),
            ),
          ),
        ),
        SizedBox(height: 4.h,),
        Text(
          label,
          style: TextStyle(color: Colors.black,fontSize: 10.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
