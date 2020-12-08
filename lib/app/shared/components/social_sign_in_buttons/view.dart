library social_signin_buttons;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Buttons {
  Google,
  Facebook,
  Microsoft,
  LinkedIn,
  Twitter,
  GitHub,
  Apple,
  Email,
}

class SignInButton extends StatelessWidget {
  final Function onPressed;
  final Buttons button;
  final String text;
  final ShapeBorder shape;
  final double buttonWidth;
  final double buttonHeight;

  SignInButton(
    this.button, {
    @required this.onPressed,
    this.text,
    this.shape,
    this.buttonWidth,
    this.buttonHeight,
  })  : assert(button != null),
        assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    switch (button) {
      case Buttons.Email:
        return Btn(
          key: ValueKey("Email"),
          text: text ?? "Entre com o Email",
          icon: Icons.email,
          onPressed: onPressed,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,
          shape: shape,
        );
      case Buttons.Google:
        return Btn(
          key: ValueKey("Google"),
          text: text ?? "Entre com o Google",
          image: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: AssetImage(
                  'assets/images/utils/google_icon.png',
                ),
                height: 25.0,
              ),
            ),
          ),
          onPressed: onPressed,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.Facebook:
        return Btn(
          key: ValueKey("Facebbok"),
          text: text ?? "Entre com o Facebook",
          icon: FontAwesomeIcons.facebookF,
          onPressed: onPressed,
          backgroundColor: Color(0xFF3B5998),
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.GitHub:
        return Btn(
          key: ValueKey("Github"),
          text: text ?? "Entre com o Github",
          icon: FontAwesomeIcons.github,
          onPressed: onPressed,
          backgroundColor: Color(0xFF444444),
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.Apple:
        return Btn(
          key: ValueKey("Apple"),
          text: text ?? "Entre com o Apple",
          icon: FontAwesomeIcons.apple,
          onPressed: onPressed,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.LinkedIn:
        return Btn(
          key: ValueKey("LinkedIn"),
          text: text ?? "Entre com o LinkedIn",
          icon: FontAwesomeIcons.linkedin,
          onPressed: onPressed,
          backgroundColor: Color(0xFF007BB6),
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.Microsoft:
        return Btn(
          key: ValueKey("Microsoft"),
          text: text ?? "Entre com o Microsoft",
          image: Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image(
                image: AssetImage(
                  'assets/images/utils/microsoft_icon.png',
                ),
                height: 27.0,
              ),
            ),
          ),
          onPressed: onPressed,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );
      case Buttons.Twitter:
        return Btn(
          key: ValueKey("Twitter"),
          text: text ?? "Entre com o Twitter",
          icon: FontAwesomeIcons.twitter,
          onPressed: onPressed,
          backgroundColor: Color(0xFF1DA1F2),
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: shape,
          buttonWidth: buttonWidth,
          buttonHeight: buttonHeight,
        );

      default:
        return SizedBox(); 
    }
  }
}

class Btn extends StatelessWidget {
  final Color textColor, backgroundColor, iconColor;
  final Function onPressed;
  final String text;
  final IconData icon;
  final Widget image;
  final ShapeBorder shape;
  final double buttonWidth;
  final double buttonHeight;
  Btn({
    Key key,
    this.backgroundColor,
    this.onPressed,
    this.text,
    this.icon,
    this.textColor,
    this.iconColor,
    this.image,
    this.shape,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: key,
      onPressed: onPressed,
      color: backgroundColor,
      shape: shape ?? ButtonTheme.of(context).shape,
      padding: const EdgeInsets.all(12),
      child: Container(
        width: buttonWidth ?? 0,
        height: buttonHeight ?? 0,
        constraints: BoxConstraints(
          minWidth: buttonWidth == null ? 210 : 0,
          minHeight: buttonHeight == null ? 20 : 0,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: image != null
                    ? image
                    : FittedBox(
                                          child: Icon(
                          icon,
                          size: 23,
                          color: this.iconColor,
                        ),
                    ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: textColor,
                  fontSize: 14,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
