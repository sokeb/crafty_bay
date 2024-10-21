import 'package:flutter/material.dart';

import '../utils/assets_path.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ProfileInfoScreenState createState() => ProfileInfoScreenState();
}

class ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user's current info from API or local data
    // Update controllers with the existing data.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Information'),
        // backgroundColor: AppColors.themeColor,
      ),
      body: Container(
        color: Colors.black.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 50,
                        backgroundImage: AssetImage(
                          AssetsPath.person,
                        ), // Profile image
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                              size: 16,
                            ),
                            onPressed: () {
                              // Open camera/gallery to change profile pic
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Md Hasanuzzaman Sakib',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('sakib@gmail.com'),
                    ],
                  )
                ],
              ),
            ),
            //const SizedBox(height: 20),
            // Name Field
            Expanded(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildTextField(
                        label: 'Name',
                        controller: nameController,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      buildTextField(
                        label: 'Email',
                        controller: emailController,
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      // Phone Field
                      buildTextField(
                        label: 'Phone',
                        controller: phoneController,
                        icon: Icons.phone,
                      ),
                      const SizedBox(height: 16),
                      // Address Field
                      buildTextField(
                        label: 'Address',
                        controller: addressController,
                        icon: Icons.location_on,
                      ),
                      const SizedBox(height: 30),
                      // Update Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            // Handle profile update
                          },
                          child: const Text('Update Information'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed: () {
                            // Handle logout
                          },
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create text fields
  Widget buildTextField(
      {required String label,
      required TextEditingController controller,
      required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
