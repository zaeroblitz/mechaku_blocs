part of 'widgets.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String textButton;
  final Function() onPressed;

  CustomAlertDialog(
    this.title,
    this.content,
    this.textButton,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: mediumTextStyle),
      content: Text(
        content,
        style: regularTextStyle,
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            width: 100,
            text: textButton,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
