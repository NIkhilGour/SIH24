import 'package:flutter/material.dart';
import 'package:ayurvan/Authentication/screens/fogot_password/forgot_otp.dart';
import 'package:ayurvan/constant/Text.dart';
import 'package:ayurvan/constant/image.dart';
import 'package:ayurvan/constant/size.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const SizedBox(
                  height: defaultSize + 4,
                ),
                Image(
                  image: const AssetImage(tForgotPassWordImage),
                  height: height * 0.2,
                ),
                const SizedBox(height: 30,),
                const Text(
                  tForgotPassword,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                ),
                const Text(
                  tForgotEmailSubtitle,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
               const SizedBox(height: defaultSize,),
               Form(
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(fontSize: 25),
                      
                      decoration: const InputDecoration(
                        label: Text(' E-mail'),
                        hintText: ' E-mail',
                        
                        border: OutlineInputBorder(),
                       
                         
                        prefix: Icon(Icons.mail_outline_rounded,size: 30,),           
                        
                      ),
                    ),
                  ],)),
                    const SizedBox(height: 20,),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpScreen()
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 50)),
                            child: const Text(
                              'Next',
                              style:  TextStyle(fontSize: 20),
                            )
                            ),
                      ),
                  ]
                      ),
                    )
                  ,
                )
               
               
      ),
    );
  }
}
