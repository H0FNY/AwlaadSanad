import 'package:awladsanaad_2/services.dart';
import 'package:awladsanaad_2/view/auth/_login_cubit.dart';
import 'package:awladsanaad_2/view/auth/_login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../custom/colors.dart';
import '../../custom/custom_text_form_field.dart';
import '../home/Home.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.sizeOf(context).height;
    double widthScreen = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, Loginstate>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false,
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: whiteColor,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: heightScreen / 5),
                        const Row(mainAxisSize: MainAxisSize.max),
                        Image.asset(
                          "assets/images/school.png",
                          width: widthScreen / 2,
                        ),
                        SizedBox(height: heightScreen / 12),
                        SizedBox(
                          width: widthScreen - 70,
                          child: Card(
                            elevation: 10,
                            shadowColor: mainColor,
                            color: mainColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 5),
                                  Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: widthScreen / 13,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "اسم المستخدم",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        CustomTextFormField(controller: emailController),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "كلمة المرور",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        CustomTextFormField(controller: passwordController, hide: true),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () async {
                                      final username = emailController.text;
                                      final password = passwordController.text;
                                      // context.read<LoginCubit>().login(username, password);
                                      context.read<LoginCubit>().login("Admin", "Admin123@#");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: widthScreen / 25,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: heightScreen / 30),
                        if (state is LoginLoading)
                          const CircularProgressIndicator(color: mainColor),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
