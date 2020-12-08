//import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';

class SignInScreenController extends GetxController {
  final GoogleSignIn _googleSignInInstance = GoogleSignIn();
  final FacebookLogin _facebookLoginInstance = FacebookLogin();

  final loginFormkey = GlobalKey<FormState>();

  RxBool _isScreenLoading = false.obs;
  Rx<GlobalKey<FormState>> loginFormKey = GlobalKey<FormState>().obs;
  RxBool _isPasswordHiden = true.obs;
  RxBool _isWrongCrendentials = false.obs;

  Rx<TextEditingController> _userLoginController = TextEditingController().obs;
  Rx<TextEditingController> _userPasswordController =
      TextEditingController().obs;
  TextEditingController get userLoginController => _userLoginController.value;
  TextEditingController get userPasswordController =>
      _userPasswordController.value;

  bool get isScreenLoading => this._isScreenLoading.value;

  bool get isPasswordHiden => this._isPasswordHiden.value;
  set isPasswordHiden(bool newValue) {
    this._isPasswordHiden.value = newValue;
  }

  bool get isWrongCrendentials => this._isWrongCrendentials.value;
  set isWrongCrendentials(bool newValue) {
    this._isWrongCrendentials.value = newValue;
  }

  togglePasswordHiddenState() {
    this._isPasswordHiden.value = !this._isPasswordHiden.value;
  }

  String validatePassword(String fieldText) {
    return fieldText.length == 0
        ? 'Informe uma senha antes de continuar!'
        : null;
  }

  String validateLogin(String fieldText) {
    return fieldText.length == 0
        ? 'Informe um email antes de continuar!'
        : !fieldText.contains('@') && !fieldText.contains('.')
            ? "Email inválido!"
            : null;
  }

  signInWithEmailAndPassword() {
    _isScreenLoading.value = true;
    Future.delayed(Duration(milliseconds: 2000), () async {
      //TRATAR O LOGIN AQUI

      // await Get.find<SessionUser>().sigIn();

      _isScreenLoading.value = false;

      Get.offAll(
        SplashScreen(),
        binding: SplashScreenBind(),
        duration: Duration(milliseconds: 500),
        transition: Transition.fadeIn,
        curve: Curves.easeInBack,
      );
    });
  }

  Future<void> signInWithGoogle() async {
    _isScreenLoading.value = true;

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    if (!googleUser.isNullOrBlank) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      UserCredential firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );

      await Get.find<SessionUser>()
          .signIn(firebaseUser.user.displayName, firebaseUser.user.uid,
              firebaseUser.user.photoURL)
          .whenComplete(() {
        Get.offAll(
          SplashScreen(),
          binding: SplashScreenBind(),
          duration: Duration(milliseconds: 500),
          transition: Transition.fadeIn,
          curve: Curves.easeInBack,
        );
      });
    } else {
      _isScreenLoading.value = false;
    }

    _googleSignInInstance.signOut();
  }

  Future<void> signInWithFacebook() async {
    final result = await _facebookLoginInstance.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );

    if (result.status == FacebookLoginStatus.Success) {
      
      _isScreenLoading.value = true;

      final accessToken = result.accessToken.token;

      if (!accessToken.isNullOrBlank) {
        UserCredential firebaseUser =
            await FirebaseAuth.instance.signInWithCredential(
          FacebookAuthProvider.credential(result.accessToken.token),
        );

        await Get.find<SessionUser>()
            .signIn(firebaseUser.user.displayName, firebaseUser.user.uid,
                firebaseUser.user.photoURL)
            .whenComplete(() {
          Get.offAll(
            SplashScreen(),
            binding: SplashScreenBind(),
            duration: Duration(milliseconds: 500),
            transition: Transition.fadeIn,
            curve: Curves.easeInBack,
          );
        });
      } else {
        _isScreenLoading.value = false;
      }

      _facebookLoginInstance.logOut();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    await Firebase.initializeApp();
  }
}

enum SocialNetwork { google, facebook }
