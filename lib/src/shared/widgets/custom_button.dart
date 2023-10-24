import 'package:bookihub/src/shared/utils/exports.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.title,
    this.onPressed
  });
  final String? title;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .07,
      width: MediaQuery.sizeOf(context).width *1,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(blue)),
        child: Text(title!),
      ),
    );
  }
}