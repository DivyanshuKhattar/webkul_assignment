import 'package:dummy_assignment/CommonClasses/common_widgets.dart';
import 'package:dummy_assignment/CommonClasses/custom_toast.dart';
import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:dummy_assignment/Resources/string_constants.dart';
import 'package:dummy_assignment/Resources/styling.dart';
import 'package:dummy_assignment/Screens/UserDetails/login_screen.dart';
import 'package:dummy_assignment/DatabaseHelper/user_data_helper.dart';
import 'package:dummy_assignment/ModelClasses/user_data_model.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool showPassword1 = false;
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
                        borderRadius: BorderRadius.circular(40)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 40, 15, 10),
                    child: Text(
                      StringConstants().forgotPassword,
                      style: CustomStyle.twentySemiBoldBlackText,
                    ),
                  ),

                  /// email
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 20, 15, 0),
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
                    padding: const EdgeInsets.fromLTRB(20, 11, 20, 11),
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
                        resetPassword();
                      }
                    },
                    child: Text(
                      StringConstants().confirm,
                      style: CustomStyle.sixteenSemiBoldWhiteText,
                    ),
                  ),

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
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.08, vertical: deviceHeight*0.02),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: StringConstants().wantToGoBack,
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

  /// validate user email and setting up new password
  Future resetPassword() async{
    CommonWidgets().showLoaderDialog(context);
    if(allUsers.isNotEmpty){
      for(int i=0; i<allUsers.length; i++){
        if(allUsers[i].userEmail == emailController.text.trim()){
          Map<String, dynamic> row = {
            UserDataHelper.colId: allUsers[i].id,
            UserDataHelper.colUsername: allUsers[i].username,
            UserDataHelper.colUserEmail: allUsers[i].userEmail,
            UserDataHelper.colPassword: passwordController.text.trim(),
          };
          await userDataHelper.updateUserData(row, allUsers[i].id);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          CustomToast.showToastMessage(StringConstants().passwordUpdated);
          if(context.mounted){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
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
