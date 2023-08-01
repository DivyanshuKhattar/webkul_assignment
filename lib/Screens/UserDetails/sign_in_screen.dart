import 'package:dummy_assignment/CommonClasses/common_widgets.dart';
import 'package:dummy_assignment/CommonClasses/custom_toast.dart';
import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:dummy_assignment/Resources/shared_pref_data.dart';
import 'package:dummy_assignment/Resources/string_constants.dart';
import 'package:dummy_assignment/Resources/styling.dart';
import 'package:dummy_assignment/Screens/Dashboard/dashboard_screen.dart';
import 'package:dummy_assignment/Screens/UserDetails/login_screen.dart';
import 'package:dummy_assignment/DatabaseHelper/user_data_helper.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool showPassword1 = false;
  UserDataHelper userDataHelper = UserDataHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight*0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: deviceHeight*0.12,
                    width: deviceWidth*0.48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset("assets/webkul_logo.png", fit: BoxFit.fill,).image,
                      ),
                      borderRadius: BorderRadius.circular(40)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 30, 15, 10),
                    child: Text(
                      StringConstants().signUp,
                      style: CustomStyle.twentySemiBoldBlackText,
                    ),
                  ),

                  /// name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 15, 0),
                    child: Row(
                      children: [
                        const Icon(Icons.face),
                        SizedBox(
                          width: deviceWidth*0.03,
                        ),
                        Text(
                          StringConstants().username,
                          style: CustomStyle.fourteenNormalBlackText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 11),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Field Required";
                        }
                        return null;
                      },
                      cursorColor: greenColor,
                      keyboardType: TextInputType.text,
                      style: CustomStyle.fourteenNormalBlackText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightGreyColor.withOpacity(0.2),
                        border: CustomStyle.textFieldBorder,
                        focusedBorder: CustomStyle.textFieldBorder,
                        enabledBorder: CustomStyle.textFieldBorder,
                        contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                        hintText: "Enter Name here...",
                        hintStyle: CustomStyle.fourteenNormalLightBlackText,
                      ),
                    ),
                  ),

                  /// email
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 15, 15, 0),
                    child: Row(
                      children: [
                        const Icon(Icons.email_outlined),
                        SizedBox(
                          width: deviceWidth*0.03,
                        ),
                        Text(
                          StringConstants().email,
                          style: CustomStyle.fourteenNormalBlackText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 11),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Field Required";
                        }
                        else if(!value.contains("@") && !value.contains(".")){
                          return "Invalid Email";
                        }
                        return null;
                      },
                      cursorColor: greenColor,
                      keyboardType: TextInputType.emailAddress,
                      style: CustomStyle.fourteenNormalBlackText,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightGreyColor.withOpacity(0.2),
                        border: CustomStyle.textFieldBorder,
                        focusedBorder: CustomStyle.textFieldBorder,
                        enabledBorder: CustomStyle.textFieldBorder,
                        contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                        hintText: "Enter Email here...",
                        hintStyle: CustomStyle.fourteenNormalLightBlackText,
                      ),
                    ),
                  ),

                  /// password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 15, 15, 0),
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outlined),
                        SizedBox(
                          width: deviceWidth*0.03,
                        ),
                        Text(
                          StringConstants().password,
                          style: CustomStyle.fourteenNormalBlackText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 20),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Field Required";
                        }
                        return null;
                      },
                      obscureText: !showPassword,
                      cursorColor: greenColor,
                      keyboardType: TextInputType.text,
                      style: CustomStyle.fourteenNormalBlackText,
                      decoration: InputDecoration(
                        suffixIcon: showPassword == false
                        ? GestureDetector(
                          onTap: (){
                            setState(() {
                              showPassword = true;
                            });
                          },
                          child: Icon(Icons.visibility_outlined, color: lightGreyColor,),
                        )
                        : GestureDetector(
                          onTap: (){
                            setState(() {
                              showPassword = false;
                            });
                          },
                          child: Icon(Icons.visibility_off_outlined, color: lightGreyColor,),
                        ),
                        filled: true,
                        fillColor: lightGreyColor.withOpacity(0.2),
                        border: CustomStyle.textFieldBorder,
                        focusedBorder: CustomStyle.textFieldBorder,
                        enabledBorder: CustomStyle.textFieldBorder,
                        contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                        hintText: "Enter password...",
                        hintStyle: CustomStyle.fourteenNormalLightBlackText,
                      ),
                    ),
                  ),

                  /// confirm password
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 15, 15, 0),
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outlined),
                        SizedBox(
                          width: deviceWidth*0.03,
                        ),
                        Text(
                          StringConstants().confirmPassword,
                          style: CustomStyle.fourteenNormalBlackText,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 40),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Field Required";
                        }
                        else if(value != passwordController.text.trim()){
                          return "Password mismatch";
                        }
                        return null;
                      },
                      obscureText: !showPassword1,
                      cursorColor: greenColor,
                      keyboardType: TextInputType.text,
                      style: CustomStyle.fourteenNormalBlackText,
                      decoration: InputDecoration(
                        suffixIcon: showPassword1 == false
                        ? GestureDetector(
                          onTap: (){
                            setState(() {
                              showPassword1 = true;
                            });
                          },
                          child: Icon(Icons.visibility_outlined, color: lightGreyColor,),
                        )
                        : GestureDetector(
                          onTap: (){
                            setState(() {
                              showPassword1 = false;
                            });
                          },
                          child: Icon(Icons.visibility_off_outlined, color: lightGreyColor,),
                        ),
                        filled: true,
                        fillColor: lightGreyColor.withOpacity(0.2),
                        border: CustomStyle.textFieldBorder,
                        focusedBorder: CustomStyle.textFieldBorder,
                        enabledBorder: CustomStyle.textFieldBorder,
                        contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                        hintText: "Enter confirm password...",
                        hintStyle: CustomStyle.fourteenNormalLightBlackText,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      minimumSize: Size(deviceWidth*0.42,deviceHeight*0.055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: (){
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        saveUserData();
                      }
                    },
                    child: Text(
                      StringConstants().signUp,
                      style: CustomStyle.sixteenSemiBoldWhiteText,
                    ),
                  ),

                  /// login button
                  SizedBox(height: deviceHeight*0.03,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.08, vertical: deviceHeight*0.00),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: StringConstants().alreadyHaveAccount,
                              style: CustomStyle.fourteenNormalBlackText,
                            ),
                            TextSpan(
                              text: StringConstants().login,
                              style: CustomStyle.fourteenNormalBlueText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// saving user data to local database
  Future saveUserData() async{
    CommonWidgets().showLoaderDialog(context);
    try{
      Map<String, dynamic> row = {
        UserDataHelper.colUsername: usernameController.text.trim(),
        UserDataHelper.colUserEmail: emailController.text.trim(),
        UserDataHelper.colPassword: passwordController.text.trim(),
      };
      int colIdSaved = await userDataHelper.insertUserData(row);
      await SharedPrefData().setIsLoggedIn(true);
      await SharedPrefData().setUserId(colIdSaved);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      CustomToast.showToastMessage(StringConstants().accountCreated);
      if(context.mounted){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(builder: (BuildContext context) => const DashboardScreen()),
          ModalRoute.withName('/dashboard'),
        );
      }
    }catch(e){
      Navigator.pop(context);
      debugPrint(e.toString());
      CustomToast.showToastMessage(StringConstants().errorMessage);
    }
  }
}
