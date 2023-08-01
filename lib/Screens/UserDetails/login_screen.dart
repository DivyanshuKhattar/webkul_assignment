import 'package:dummy_assignment/CommonClasses/common_widgets.dart';
import 'package:dummy_assignment/CommonClasses/custom_toast.dart';
import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:dummy_assignment/Resources/shared_pref_data.dart';
import 'package:dummy_assignment/Resources/string_constants.dart';
import 'package:dummy_assignment/Resources/styling.dart';
import 'package:dummy_assignment/Screens/Dashboard/dashboard_screen.dart';
import 'package:dummy_assignment/Screens/UserDetails/forgot_password.dart';
import 'package:dummy_assignment/Screens/UserDetails/sign_in_screen.dart';
import 'package:dummy_assignment/DatabaseHelper/user_data_helper.dart';
import 'package:dummy_assignment/ModelClasses/user_data_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  UserDataHelper userDataHelper = UserDataHelper.instance;
  List<UserDataModel> allUsers = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// getting data to users list
  Future getData() async{
    setState(() {
      allUsers.clear();
    });
    final allRows = await userDataHelper.queryAllUserData();
    for(var i in allRows){
      setState(() {
        UserDataModel userDataModel = UserDataModel(
          id: i["colId"],
          username: i["colUsername"],
          userEmail: i["colUserEmail"],
          password: i["colPassword"],
        );
        allUsers.add(userDataModel);
      });
    }
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
              padding: EdgeInsets.symmetric(vertical: deviceHeight*0.08),
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
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 40, 15, 10),
                    child: Text(
                      StringConstants().login,
                      style: CustomStyle.twentySemiBoldBlackText,
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
                      style: CustomStyle.fourteenNormalBlackText,
                      cursorColor: greenColor,
                      keyboardType: TextInputType.emailAddress,
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
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 10),
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

                  /// forgot password
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 25, 35),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          StringConstants().forgotPassword,
                          style: CustomStyle.twelveNormalBlueText,
                        ),
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
                        validateUser();
                      }
                    },
                    child: Text(
                      StringConstants().login,
                      style: CustomStyle.sixteenSemiBoldWhiteText,
                    ),
                  ),

                  /// sign in
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: deviceHeight*0.03),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.08, vertical: deviceHeight*0.00),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: StringConstants().doNotHaveAccount,
                                style: CustomStyle.fourteenNormalBlackText,
                              ),
                              TextSpan(
                                text: StringConstants().signUp,
                                style: CustomStyle.fourteenNormalBlueText,
                              ),
                            ],
                          ),
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

  /// validate user email and password
  Future validateUser() async{
    CommonWidgets().showLoaderDialog(context);
    if(allUsers.isNotEmpty){
      for(int i=0; i<allUsers.length; i++){
        if(allUsers[i].userEmail == emailController.text.trim()){
          final userData = await userDataHelper.queryOneUserData(allUsers[i].id);
          if(userData[0]["colPassword"] == passwordController.text.trim()){
            SharedPrefData().setIsLoggedIn(true);
            SharedPrefData().setUserId(userData[0]["colId"]);
            if(context.mounted){
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => const DashboardScreen()),
                ModalRoute.withName('/dashboard'),
              );
            }
          }
          else{
            if(context.mounted){
              Navigator.pop(context);
            }
            CustomToast.showToastMessage(StringConstants().incorrectPassword);
          }
          return;
        }
        else if(i == allUsers.length-1){
          Navigator.pop(context);
          CustomToast.showToastMessage(StringConstants().userNotExist);
        }
      }
    }
    else{
      Navigator.pop(context);
      CustomToast.showToastMessage(StringConstants().noUserFound);
    }
  }
}
