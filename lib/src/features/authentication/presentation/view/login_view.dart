import 'package:bookihub/src/features/authentication/presentation/provider/auth_provider.dart';
import 'package:bookihub/src/shared/utils/exports.dart';
import 'package:bookihub/src/shared/utils/show.snacbar.dart';
import 'package:bookihub/src/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: Image.asset(CustomeImages.logo),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: white,
                            filled: true,
                            hintText: "example@email.com",
                            labelText: "Username",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    backgroundColor: white),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: white,
                            filled: true,
                            labelText: "Password",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    backgroundColor: white),
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.06,
                      ),
                      CustomButton(
                        bgColor: orange,
                        onPressed: () async {
                          print(emailController.text.trim());
                          print(passwordController.text.trim());
                          await context
                              .read<AuthProvider>()
                              .login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              )
                              .then((value) async {
                            value.fold(
                              (failure) => showCustomSnackBar(
                                  context, failure.message, orange),
                              (succes) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const MainPage();
                                  },
                                ),
                              ),
                            );
                          });
                        },
                        child: const Text("Login"),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
