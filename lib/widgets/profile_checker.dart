import 'package:first/provider/data_provider.dart';
import 'package:first/screens/add_user_profile.dart';
import 'package:first/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChecker extends StatelessWidget {
  const ProfileChecker({Key? key});

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<DataProvider>(context, listen: false);

    // Use useEffect hook equivalent for post frame callback
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   profileData.addProfileName();
    // });
    
      profileData.getProfileName();



    // Retrieve profile name
    final profileName = profileData.profileName;

    // Check if profile name is null
    if (profileName!.isNotEmpty) {
        return Home();
  
    } else {
          // If profile name is null, navigate to AddProfileName screen
      return AddProfileName();
    }
  }
}
