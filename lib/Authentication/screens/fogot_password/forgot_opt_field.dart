import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/screens/fogot_password/forgot_button.dart';
import 'package:ayurvan/Authentication/screens/fogot_password/forgot_mail.dart';
import 'package:ayurvan/Authentication/screens/fogot_password/forgot_phone.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/size.dart';

class ForgotOptField{
   static Future<dynamic> forgotoptionfield(BuildContext context) {
    return showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) {
                                  var children = [
                                    const Text(
                                      tForgotPasswordTitle,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Text(tForgotEmailSubtitle,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ForgetPasswordBtn(
                                      buttonicon: Icons.mail_outline_rounded,
                                      title: 'E-mail',
                                      subtile: tResetvEmail,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>const ForgotPasswordMailScreen()));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ForgetPasswordBtn(
                                      buttonicon:
                                          Icons.phone_android_outlined,
                                      title: 'Phone',
                                      subtile: tResetvPhone,
                                      onTap: () {
                                             Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>const ForgotPasswordPhoneScreen()));
                                      },
                                      
                                    ),
                                  ];
                                  return Container(
                                    padding:
                                        const EdgeInsets.all(defaultSize),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: children,
                                    ),
                                  );
                                });
  }
}
