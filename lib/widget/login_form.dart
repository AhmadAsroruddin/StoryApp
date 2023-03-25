import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/router_delegate.dart';

import 'package:story_app/widget/roundedInputField.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.text});
  final String text;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isHide = true;
  final _emailController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userController.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final email = _emailController.text;
    // final userName = _userController.text;
    // final password = _passwordController.text;

    return Form(
      child: Column(
        children: <Widget>[
          widget.text == "Daftar"
              ? RoundedInputField(
                  child: TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Username",
                      icon: Icon(Icons.people),
                    ),
                  ),
                )
              : Container(),
          RoundedInputField(
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  icon: Icon(Icons.email),
                  border: InputBorder.none),
            ),
          ),
          RoundedInputField(
            child: TextField(
              controller: _passwordController,
              obscureText: isHide ? true : false,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Password",
                icon: const Icon(Icons.lock),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    print(isHide);
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                  icon: const Icon(Icons.visibility),
                ),
              ),
            ),
          ),
          Consumer<AuthProvider>(
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () async {
                  // widget.text == "Daftar"
                  //     ? Provider.of<AuthProvider>(context, listen: false)
                  //         .registrasi(_userController.text, _emailController.text,
                  //             _passwordController.text)
                  //     : await context
                  //         .read<AuthProvider>()
                  //         .login(_emailController.text, _passwordController.text);
                  if (widget.text == "Daftar") {
                    setState(() {
                      isLoading = true;
                    });

                    await value.registrasi(_userController.text,
                        _emailController.text, _passwordController.text);
                    setState(() {
                      isLoading = false;
                    });

                    if (value.state == ResultState.hasData) {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .onLogin();
                    } else {
                      final ScaffoldMessengerState scaffoldMessengerState =
                          ScaffoldMessenger.of(context);

                      scaffoldMessengerState
                          .showSnackBar(SnackBar(content: Text(value.message)));
                      print(' ini di sini${value.message}');
                    }
                  } else {
                    final ScaffoldMessengerState scaffoldMessengerState =
                        ScaffoldMessenger.of(context);
                    setState(() {
                      isLoading = true;
                    });
                    await value.login(
                        _emailController.text, _passwordController.text);

                    if (value.state == ResultState.hasData) {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .onLoggedIn();
                    }
                    setState(() {
                      isLoading = false;
                    });
                    scaffoldMessengerState
                        .showSnackBar(SnackBar(content: Text(value.message)));
                  }
                  print(
                      'message : ${Provider.of<AuthProvider>(context, listen: false).message}');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurple[300]),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            widget.text,
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
