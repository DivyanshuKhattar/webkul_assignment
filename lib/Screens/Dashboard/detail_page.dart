import 'dart:async';
import 'package:dummy_assignment/CommonClasses/custom_toast.dart';
import 'package:dummy_assignment/ModelClasses/product_detail_model_class.dart';
import 'package:dummy_assignment/Resources/color_picker.dart';
import 'package:dummy_assignment/CommonClasses/common_function.dart';
import 'package:dummy_assignment/Resources/getx_controller_custom.dart';
import 'package:dummy_assignment/Resources/shared_pref_data.dart';
import 'package:dummy_assignment/Resources/string_constants.dart';
import 'package:dummy_assignment/Resources/styling.dart';
import 'package:dummy_assignment/Resources/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPageScreen extends StatefulWidget {
  final int productId;
  const DetailPageScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<DetailPageScreen> createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  TextEditingController searchController = TextEditingController();
  ProductDetailModelClass? productDetail;
  bool dataFetched = false;
  List<String> imageList = [];
  PageController pageController = PageController(initialPage: 0);
  Timer? timer;
  int currentPage = 0;
  final GetXControllerCustom controller = Get.put(GetXControllerCustom());

  @override
  void initState() {
    fetchProductDetail(widget.productId);
    super.initState();
  }

  @override
  void dispose() {
    if(timer != null && timer!.isActive){
      timer!.cancel();
    }
    super.dispose();
  }

  /// function to FETCH PRODUCT DETAILS
  Future fetchProductDetail(int id) async{
    setState(() {
      dataFetched = false;
      productDetail = null;
      imageList.clear();
    });
    try{
      final response = await Util.getProductDetail(id);
      final productResponse = productDetailModelClassFromJson(response);
      if(productResponse.id != 0){
        setState(() {
          productDetail = productResponse;

          // adding multiple images to list
          for(int i=0; i<5; i++){
            imageList.add(productDetail!.image!);
          }
          CommonFunction.lightStatusBarColor(lightGreenColor);
          swipeImage();

        });
      }
      setState(() {
        dataFetched = true;
      });
    }
    catch(e){
      dataFetched = true;
      CustomToast.showToastMessage(StringConstants().errorMessage);
      debugPrint(e.toString());
    }
  }

  /// function to swipe image automatically
  Future swipeImage() async{
    if(imageList.isNotEmpty && imageList.length <= 5){
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if(currentPage < 5){
          currentPage++;
        }
        else{
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor ,
      body: dataFetched == true
      ? SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// image
                    Container(
                      color: lightGreenColor,
                      height: deviceHeight*0.4,
                      width: deviceWidth,
                      padding: EdgeInsets.symmetric(vertical: deviceHeight*0.012),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: deviceHeight*0.36,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: imageList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Image.network(productDetail!.image!, fit: BoxFit.fitHeight,);
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_ios, color: greenColor,),
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: pageController,
                            count: imageList.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: greenColor,
                              dotColor: greenColor.withOpacity(0.4),
                              radius: 5,
                              dotHeight: deviceHeight*0.012,
                              dotWidth: deviceWidth*0.04
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// text
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceWidth*0.05, deviceHeight*0.02, deviceWidth*0.05, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: deviceWidth*0.65,
                            child: Text(
                              productDetail!.title!,
                              style: CustomStyle.sixteenSemiBoldBlackText,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              /// share package
                            },
                            child: SvgPicture.asset("assets/svg_icons/share.svg"),
                          ),
                          LikeButton(
                            size: 30,
                            animationDuration: const Duration(milliseconds: 1000),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: greenColor,
                              dotSecondaryColor: lightGreenColor,
                            ),
                            circleColor: CircleColor(
                              start: greenColor,
                              end: lightGreenColor,
                            ),
                            likeBuilder: (tapped){
                              return Icon(
                                Icons.favorite_rounded,
                                color: tapped ? greenColor : greenColor.withOpacity(0.3),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    /// category and rating
                    Padding(
                      padding: EdgeInsets.fromLTRB(deviceWidth*0.05, deviceHeight*0.02, deviceWidth*0.05, deviceHeight*0.014,),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg_icons/category.svg",
                            width: deviceWidth*0.03,
                            height: deviceHeight*0.03,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: deviceWidth*0.4,),
                            child: Text(
                              "  ${productDetail!.category!}",
                              style: CustomStyle.twelveSemiBoldGreenText,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.attach_money, size: deviceWidth*0.05, color: greenColor,),
                          Container(
                            constraints: BoxConstraints(maxWidth: deviceWidth*0.14,),
                            child: Text(
                              productDetail!.price!.toString(),
                              style: CustomStyle.twelveSemiBoldGreenText,
                            ),
                          ),
                          const Spacer(),
                          RatingBar.builder(
                            glow: true,
                            ignoreGestures: true,
                            itemSize: deviceWidth*0.045,
                            initialRating: productDetail!.rating!.rate!,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            unratedColor: greenColor.withOpacity(0.3),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: greenColor,
                            ),
                            onRatingUpdate: (rating) {
                              debugPrint(rating.toString());
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: lightGreyColor.withOpacity(0.4),
                      thickness: 2,
                      endIndent: 20,
                      indent: 20,
                    ),

                    /// description
                    Container(
                      width: deviceWidth,
                      padding: EdgeInsets.fromLTRB(deviceWidth*0.05, deviceHeight*0.025, deviceWidth*0.05, 0),
                      child: Text(
                        StringConstants().description,
                        style: CustomStyle.sixteenSemiBoldBlackText,
                      ),
                    ),
                    Container(
                      width: deviceWidth,
                      padding: EdgeInsets.fromLTRB(deviceWidth*0.05, deviceHeight*0.015, deviceWidth*0.05, deviceHeight*0.02),
                      child: Text(
                        productDetail!.description!,
                        style: CustomStyle.fourteenBoldGreenText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /// footer
            Container(
              height: deviceHeight*0.12,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: lightGreyColor,
                    blurRadius: 12,
                    offset: const Offset(0, 0.2),
                  ),
                ],
                color: whiteColor,
              ),
              padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.065,),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: deviceWidth*0.16,
                      height: deviceHeight*0.065,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greenColor,
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svg_icons/chat.svg",
                          width: deviceWidth*0.04,
                          height: deviceHeight*0.04,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greenColor,
                      minimumSize: Size(deviceWidth*0.65,deviceHeight*0.065),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        controller.increment();
                      });
                      SharedPrefData().setCartValue(controller.cart.value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringConstants().productAdded),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    child: Text(
                      StringConstants().addToCart,
                      style: CustomStyle.sixteenSemiBoldWhiteText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
      : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
