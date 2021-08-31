part of 'widgets.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final String prefixIconUrl;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.isPassword = false,
    required this.label,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.prefixIconUrl,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEmpty = true;
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Text
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              widget.label,
              style: mediumTextStyle,
            ),
          ),

          // Text Field
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Prefix
                Container(
                  width: 18,
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset(widget.prefixIconUrl),
                ),

                // TextField
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    validator: widget.validator,
                    controller: widget.controller,
                    style: regularTextStyle,
                    cursorColor: orangeColor,
                    obscureText: widget.isPassword ? isHidden : false,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                      hintStyle: hintTextStyle,
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        setState(() {
                          isEmpty = false;
                        });
                      } else if (value == '') {
                        setState(() {
                          isEmpty = true;
                        });
                      }
                    },
                  ),
                ),

                // Suffix
                isEmpty
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          if (widget.isPassword) {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          } else {
                            setState(() {
                              isEmpty = true;
                              widget.controller.text = '';
                            });
                          }
                        },
                        child: widget.isPassword
                            ? isEmpty
                                ? SizedBox()
                                : isHidden
                                    ? Icon(
                                        Icons.visibility,
                                        size: 18,
                                        color: blackColor1,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size: 18,
                                        color: blackColor1,
                                      )
                            : Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: blackColor1,
                              ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
