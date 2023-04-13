import 'package:chat/Authenticate/Methods.dart';
import 'package:chat/screens2/welcome_screen.dart';
import 'package:chat/widgets/navbar_roots.dart';
import 'package:flutter/material.dart';
import 'LoginScree.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _number = TextEditingController();
  bool isLoading = false;
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height / 28,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 0.5,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 29,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen1(),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("images/logo.png"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          width: size.width,
                          alignment: Alignment.center,
                          child: field(size, "Enter Full Name", "Full Name",
                              Icons.account_box, _name),
                        ),
                      ),
                      Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: fielde(size, "Enter email id", "Email Id",
                            Icons.email, _email),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          width: size.width,
                          alignment: Alignment.center,
                          child: fieldPhone(size, "Enter Phone number",
                              "Phone Number", Icons.phone, _number),
                        ),
                      ),
                      Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field1(size, "Enter Password", "Password",
                            Icons.lock, _password),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      customButton(size),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have account?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7165D6)),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });

          createAccount(_name.text, _email.text, _password.text, _number.text)
              .then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AccountCreated()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AccountCreationFailed()));
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: Color(0xFF7165D6),
            borderRadius: BorderRadius.circular(30),
            // surfaceTintColor: Colors.black,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              child: Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget field(Size size, String hintText, String label, IconData icon,
      TextEditingController cont) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter valid name";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          labelText: label,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget fielde(Size size, String hintText, String label, IconData icon,
      TextEditingController cont) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return "Please enter valid email";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          labelText: label,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget fieldPhone(Size size, String hintText, String label, IconData icon,
      TextEditingController cont) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        validator: (value) {
          if (value!.length != 10) {
            return "Please enter valid phone number";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          labelText: label,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget field1(Size size, String hintText, String label, IconData icon,
      TextEditingController cont) {
    return Container(
      height: size.height / 10,
      width: size.width / 1.1,
      child: TextFormField(
        controller: cont,
        obscureText: _isHidden,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              size: 25,
            ),
          ),
          hintText: hintText,
          labelText: label,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Password is required";
          } else if (_password.text.length < 6) {
            return "Password must be at least 6 characters";
          }
        },
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

class AccountCreated extends StatelessWidget {
  const AccountCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account Created Successfully'),
      content: Text('Your account has been created successfully.'),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBarRoots()),
            );
          },
        ),
      ],
    );
  }
}

class AccountCreationFailed extends StatelessWidget {
  const AccountCreationFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account not Created'),
      content: Text('Please check all details'),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
