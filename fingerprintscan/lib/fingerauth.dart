import 'package:fingerprintscan/sucessScreen.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerAuth extends StatefulWidget {
  const FingerAuth({super.key});

  @override
  State<FingerAuth> createState() => _FingerAuthState();
}

class _FingerAuthState extends State<FingerAuth> {
  final LocalAuthentication auth = LocalAuthentication();

  checkAuth() async {
    bool isAvailable;
    isAvailable = await auth.canCheckBiometrics;
    print(isAvailable);
    if (isAvailable) {
      bool result = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to proceed',
          options: AuthenticationOptions(biometricOnly: true));
      if (result) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SucessScreen()),
        );
      } else {
        print("Permission Denied");
      }
    } else {
      print("No biometreic sensor detected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Center(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 50),
          Image.network(
            "https://cdn.dribbble.com/users/3898087/screenshots/15355582/media/0dab2b0b20d4f0043bb47ad2837ec80e.gif",
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              "FingerPrint Auth",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 5),
            child: Center(
                child: Text(
                    "Authenticate using fingerprint to proceed in application")),
          ),
          SizedBox(height: 100),
          ElevatedButton(
              onPressed: () {
                checkAuth();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade300,
                  foregroundColor: Colors.white),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Aunthenticate",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
