import 'package:bookihub/src/shared/utils/exports.dart';

class CustomButton extends StatelessWidget {
 const CustomButton({
    super.key,
    this.title,
    this.bgColor = blue,
    this.onPressed
  });
  final String? title;
  final Color? bgColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .07,
      width: MediaQuery.sizeOf(context).width *1,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor)),
        child: Text(title!),
      ),
    );
  }
}