import 'package:barber_app/ResponseModel/salonDetailResponse.dart';
import 'package:barber_app/constant/color_constant.dart';
import 'package:barber_app/constant/constant_font.dart';
import 'package:barber_app/constant/dymmyimages.dart';
import 'package:barber_app/constant/string_constant.dart';
import 'package:barber_app/constant/toast_message.dart';
import 'package:barber_app/network/Apiservice.dart';
import 'package:barber_app/network/Retro_Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'homescreen.dart';

class GenerateStripeToken extends StatefulWidget {
  final String result;
  final SalonDetails salonDetails;
  final List<int> selectedServices;
  final String stripeKey;
  final int empId;
  final double totalPrice;
  final date;
  final time;
  GenerateStripeToken({
    Key? key,
    required this.result,
    required this.salonDetails,
    required this.stripeKey,
    required this.empId,
    required this.selectedServices,
    required this.totalPrice,
    this.time,
    this.date,
  }) : super(key: key);

  @override
  _GenerateStripeTokenState createState() => _GenerateStripeTokenState();
}

class _GenerateStripeTokenState extends State<GenerateStripeToken> {
  CardFieldInputDetails? _card;
  TokenData? tokenData;
  List<int> serviceList = [];
  @override
  void initState() {
    print("salonId: ${widget.salonDetails.salonId!.toString()}");
    super.initState();
    setKey();
    print("selectedEmpId:" + widget.empId.toString());
    for (int i = 0; i < widget.selectedServices.length; i++) {
      serviceList.add(widget.selectedServices[i]);
    }
    print(serviceList);
    print("date:" + widget.date);
    print("totalPrice:" + widget.totalPrice.toString());
    print("time:" + widget.time);
    print("paymentMethod:" + widget.result);
    print("stripe key:" + widget.stripeKey);
  }

  Future setKey() async {
    Stripe.publishableKey = widget.stripeKey;
    await Stripe.instance.applySettings();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print("paymentMethod:" + widget.result);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinkColor,
        title: Text("Stripe Payment"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: CardField(
                  autofocus: true,
                  onCardChanged: (card) {
                    setState(() {
                      _card = card;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: _card?.complete == true ? _handleCreateTokenPress : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: pinkColor, minimumSize: Size(MediaQuery.of(context).size.width, 50)),
          child: const Text("Pay"),
        ),
      ),
    );
  }

  Future<void> _handleCreateTokenPress() async {
    if (_card == null) {
      return;
    }
    try {
      setState(() {
        isLoading = true;
      });
      final tokenData =
          await Stripe.instance.createToken(CreateTokenParams.card(params: CardTokenParams(type: TokenType.Card)));
      setState(() {
        isLoading = false;
        this.tokenData = tokenData;

        callApiForBookService(tokenData.id);
      });
      print("Strip response Key:" + tokenData.id);
      return;
    } catch (e) {
      print(e);
      ToastMessage.toastMessage("Erreur:" + e.toString());
      rethrow;
    }
  }

  void callApiForBookService(String token) {
    Map<String, String> body = {
      "emp_id": widget.empId.toString(),
      "service_id": serviceList.toString(),
      "payment": widget.totalPrice.toInt().toString(),
      "date": widget.date.toString(),
      "start_time": widget.time.toString(),
      "payment_type": widget.result,
      "payment_token": token,
    };
    print(body);
    RestClient(RetroApi().dioData()).booking(body).then((response) {
      print("bookingResponse:${response.toString()}");
      setState(() {
        if (response.success = true) {
          showSucess();
        } else {
          ToastMessage.toastMessage("Pas de données");
        }
      });
    }).catchError((Object obj) {
      setState(() {});
      print("error:$obj");
      print(obj.runtimeType);

      print("bookingResponse_error:${obj.toString()}");
    });
  }

  void showSucess() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                margin: EdgeInsets.only(top: 30, left: 15, bottom: 20),
                color: whiteColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 0.0),
                          alignment: FractionalOffset.center,
                          child: Image.asset(
                            DummyImage.changePasswordDone,
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            StringConstant.yourAppointmentBookingIsSuccessfully,
                            style: TextStyle(
                                color: blackColor,
                                fontFamily: ConstantFont.montserratMedium,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15),
                          child: Text(
                            StringConstant.youCanSeeYourUpcomingAppointmentInAppointmentSection,
                            style: TextStyle(
                                color: greyColor,
                                fontFamily: ConstantFont.montserratMedium,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeScreen(1)));
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15, bottom: 20),
                            child: Text(
                              StringConstant.goThere,
                              style: TextStyle(
                                  color: blue21,
                                  fontFamily: ConstantFont.montserratMedium,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ]),
              );
            },
          );
        });
  }
}
