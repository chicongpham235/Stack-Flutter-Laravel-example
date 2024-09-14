import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/src/configs/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../widgets/custom_snack_bar.dart';
import 'package:frontend/src/utils/extensions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/src/configs/navigator/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  // text editing controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final passwordFocusNode = FocusNode();

  // sign user in method
  Future<void> _signIn() async {
    try {
      setState(() => _isLoading = true);
      await Provider.of<Auth>(context, listen: false).authentication(
          credential: {
            'username': _usernameController.text,
            'password': _passwordController.text
          });
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'Successfully Logged In', false));
      _onNavigate();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackBar(context, 'Failed to Login ', true));
    } finally {
      FocusScope.of(context).unfocus();
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onNavigate() {
    context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Stack(
                  children: [
                    CustomScrollView(slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset(
                            //   "assets/foodorderanywhere_logo.png",
                            //   width: context.screenWidth * 0.3,
                            // ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'Welcome back',
                                      style: context.titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Welcome back login to your vendor',
                                      style: context.titleSmall!
                                          .copyWith(color: Colors.grey[700]),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    FormBuilderTextField(
                                      key: const Key("name"),
                                      name: "username",
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Your Username',
                                        prefixIcon: Icon(Icons.account_box),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) {
                                        passwordFocusNode.requestFocus();
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    FormBuilderTextField(
                                      name: "password",
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: "Your Password",
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            Provider.of<Auth>(context,
                                                    listen: false)
                                                .toggleText();
                                          },
                                          icon: Provider.of<Auth>(context)
                                                  .obscureText
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                        ),
                                      ),
                                      focusNode: passwordFocusNode,
                                      obscureText: Provider.of<Auth>(context,
                                              listen: false)
                                          .obscureText,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                      onSubmitted: (_) {
                                        _signIn();
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //submit button
                                    ElevatedButton(
                                      onPressed: _isLoading ? null : _signIn,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0))),
                                      child: Container(
                                          padding: const EdgeInsets.all(25),
                                          child: Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  padding: EdgeInsets.all(2.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: _isLoading
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    strokeWidth: 3,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Sign In",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      )
                    ]),
                  ],
                ))));
  }
}
