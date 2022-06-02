import 'package:flutter/material.dart';
import 'package:tyba_great_app/screens/home_screen/home_screen.dart';
import 'package:tyba_great_app/screens/register_screen/register_presenter.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends RegisterScreenDelegate<RegisterScreen> {

  final RegisterPresenter presenter = RegisterPresenter();

  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _rePasswordTextEditingController = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    presenter.mView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(title: const Text("Registrarse")),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _createBody(),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        child: ElevatedButton(
          child: const Text("Registrarse"),
          onPressed: _validateForm,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _createBody() {
    return Form(
      child: Column(
        children: <Widget>[
          _createInputEmail(),
          const SizedBox(height: 16),
          _createInputPassword(),
          const SizedBox(height: 16),
          _createInputRePassword(),
          const SizedBox(height: 8),
          _createCheckBoxShowPassword()
        ],
      ),
      key: _registerFormKey,
    );
  }

  Widget _createInputEmail() {
    return TextFormField(
      controller: _emailTextEditingController,
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        hintText: "next_tybe_developer@mail.com",
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (String? text) {
        if(text == null || text.trim().isEmpty) {
          return "Campo obligatorio";
        }

        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);

        if(!emailValid) {
          return "Dirección de correo inválida";
        }

        return null;

      },
    );
  }

  Widget _createInputPassword() {
    return TextFormField(
      controller: _passwordTextEditingController,
      decoration: const InputDecoration(
        labelText: "Contraseña",
      ),
      obscureText: !showPassword,
      textInputAction: TextInputAction.next,
      validator: (String? text) {
        if(text == null || text.trim().isEmpty) {
          return "Campo obligatorio";
        } else if(text.length < 8) {
          return "La contraseña debe contener al menos 8 caracteres";
        }
        return null;
      },
    );
  }

  Widget _createInputRePassword() {
    return TextFormField(
      controller: _rePasswordTextEditingController,
      decoration: const InputDecoration(
        labelText: "Repetir contraseña"
      ),
      obscureText: !showPassword,
      textInputAction: TextInputAction.done,
      validator: (String? text) {
        if(text == null || text.trim().isEmpty) {
          return "Campo obligatorio";
        } else if(text != _passwordTextEditingController.text) {
          return "Las contraseñas deben ser iguales";
        }
        return null;
      },
    );
  }

  Widget _createCheckBoxShowPassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: showPassword,
          onChanged: (bool? value) {
            setState(() {
              showPassword = value ?? false;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: Text("Mostrar contraseña", style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: const Color(0xff777777)
          )),
        )
      ],
    ); 
  }

  void _validateForm() {
    if(_registerFormKey.currentState?.validate() == true) {
      presenter.createUser(
        _emailTextEditingController.text, _passwordTextEditingController.text);
    }
  }

  @override
  void navigateToHome() {
    navigatePushReplacement(const HomeScreen(key: Key("HomeScreen")));
  }

}