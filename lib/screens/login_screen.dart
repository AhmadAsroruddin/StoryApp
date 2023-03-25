import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story_app/routes/router_delegate.dart';

import '../widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.65,
                  child: SvgPicture.asset('assets/login.svg'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const LoginForm(text: "Login"),
              GestureDetector(
                onTap: () {
                  (Router.of(context).routerDelegate as MyRouterDelegate)
                      .onRegister();
                },
                child: const Text("Belum punya akun? klik di sini"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
