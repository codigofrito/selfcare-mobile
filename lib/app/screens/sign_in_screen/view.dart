import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/shared/components/social_sign_in_buttons/view.dart';

import 'controller.dart';

class SignInScreen extends GetView<SignInScreenController> {
  @override
  Widget build(BuildContext context) {
    
    return Obx(
      () => Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: SizedBox(
                          height: Get.width * .3,
                          child: Hero(
                            tag: 'logo',
                            child: SvgPicture.asset(
                              'assets/images/brand/logo.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     top: 40,
                    //     left: 40,
                    //     right: 40,
                    //     bottom: 20,
                    //   ),
                    //   child: FittedBox(
                    //     fit: BoxFit.scaleDown,
                    //     child: Text(
                    //       "Entre com suas credenciais:",
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //       textAlign: TextAlign.start,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 40.0,
                    //   ),
                    //   child: Obx(
                    //     () => Form(
                    //       key: controller.loginFormkey,
                    //       child: Column(
                    //         children: <Widget>[
                    //           TextFormField(
                    //             validator: controller.validateLogin,
                    //             controller: controller.userLoginController,
                    //             keyboardType: TextInputType.emailAddress,
                    //             cursorColor: Theme.of(context).cursorColor,
                    //             decoration: InputDecoration(
                    //               border: OutlineInputBorder(),
                    //               labelText: 'Email',
                    //               prefixIcon: Icon(
                    //                 Icons.email,
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           TextFormField(
                    //             controller: controller.userPasswordController,
                    //             validator: controller.validatePassword,
                    //             keyboardType: TextInputType.visiblePassword,
                    //             obscureText: controller.isPasswordHiden,
                    //             cursorColor: Theme.of(context).cursorColor,
                    //             decoration: InputDecoration(
                    //               border: OutlineInputBorder(),
                    //               labelText: 'Senha',
                    //               prefixIcon: Icon(
                    //                 Icons.lock,
                    //               ),
                    //               suffixIcon: GestureDetector(
                    //                 child: controller.isPasswordHiden
                    //                     ? Icon(
                    //                         Icons.visibility,
                    //                       )
                    //                     : Icon(
                    //                         Icons.visibility_off,
                    //                       ),
                    //                 onTap: () =>
                    //                     controller.togglePasswordHiddenState(),
                    //               ),
                    //             ),
                    //             onChanged: (String value) {
                    //               controller.isWrongCrendentials = false;
                    //             },
                    //           ),
                    //           SizedBox(height: 20),
                    //           ClipRRect(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(10)),
                    //             child: MaterialButton(
                    //               height: 50,
                    //               minWidth: Get.width - 50,
                    //               color: Theme.of(context).primaryColor,
                    //               textColor: Colors.white,
                    //               child: Text(
                    //                 "Entrar",
                    //                 style: TextStyle(
                    //                   fontSize: 20.0,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //               onPressed: () {
                    //                 if (controller.loginFormkey.currentState
                    //                     .validate()) {
                    //                   focusNode.unfocus();
                    //                   controller.signInWithEmailAndPassword();
                    //                 }
                    //               },
                    //               splashColor: Colors.blue[900],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 50,
                    //   child: Center(child: Text("- ou entre com -")),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                              tag: "${SocialNetwork.google}Icon",
                              child: SignInButton(
                                Buttons.Google,
                                text: "Entrar com Google",
                                buttonWidth: 180,
                                onPressed: () => controller.signInWithGoogle(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Hero(
                              tag: "${SocialNetwork.facebook}Icon",
                              child: SignInButton(
                                Buttons.Facebook,
                                text: "Entrar com Facebook",
                                buttonWidth: 180,
                                onPressed: () =>
                                    controller.signInWithFacebook(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: !controller.isScreenLoading,
            child: AnimatedOpacity(
              opacity: controller.isScreenLoading ? 0.8 : 0,
              duration: Duration(milliseconds: 200),
              child: Container(
                color: Colors.white,
                height: Get.height,
                width: Get.width,
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                    backgroundColor: Colors.transparent,
                    strokeWidth: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
