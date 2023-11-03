import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

extension ButtonExtension on CustomButton{
 loading(bool isLoading) {
    return isLoading
        ?  const CustomButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ))
        : this;
  }
  
}