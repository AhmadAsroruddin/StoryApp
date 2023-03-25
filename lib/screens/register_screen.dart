import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes/router_delegate.dart';
import '../widget/login_form.dart';
import '../widget/roundedInputField.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/signup.svg',
                    height: MediaQuery.of(context).size.width * 0.65,
                  ),
                  const LoginForm(
                    text: "Daftar",
                  ),
                  GestureDetector(
                    onTap: () {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .onLogin();
                      
                    },
                    child: const Text("Sudah Punya akun? login"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
