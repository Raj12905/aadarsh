import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/profile/controller/profile_controller.dart';
import 'package:base_module/app_models/user_login_model_response.dart';
import 'package:base_module/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () => _showEditProfileDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Obx(
          () {
            var userData = controller.userData.value;
            return Column(
              children: [
                _buildProfileHeader(userData),
                SizedBox(height: 24),
                _buildStatsCards(),
                SizedBox(height: 24),
                _buildProfileSection(userData),
                SizedBox(height: 24),
                _buildQuickActions(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(LoginData userData) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            (userData.profileImage != "" || userData.profileImage!.isNotEmpty)
                ? Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://e-card.in/aadarsh/uploads/departmentuser/${userData.profileImage}"),
                      ),
                    ),
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 2),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 20,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          userData.name ?? 'Alex Johnson',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          userData.roleTypeName ?? 'HR Administrator',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Last active: Today at 2:45 PM',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Pending', '12', AppColors.primaryColor),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Approved', '24', AppColors.secondaryColor),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Cancel', '5', Colors.red),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(LoginData userData) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12),
          _buildInfoRow(Icons.email, 'Email',
              userData.email ?? 'alex.johnson@company.com'),
          SizedBox(height: 12),
          _buildInfoRow(
              Icons.phone, 'Phone', userData.mobile ?? '+1 (555) 123-4567'),
          SizedBox(height: 12),
          _buildInfoRow(Icons.location_city, 'Address', userData.address ?? ''),
          SizedBox(height: 12),
          _buildInfoRow(
              Icons.location_on, 'State Name', userData.stateName ?? ''),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primaryColor),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Center(
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 3,
          children: [
            _buildActionButton(context, Icons.notifications, 'Notifications'),
            _buildActionButton(context, Icons.help_outline, 'Help'),
            _buildActionButton(context, Icons.logout, 'Logout', isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label,
      {bool isLogout = false}) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          // Handle logout
          controller.showLogoutDialog(RoutesNames.loginScreen);
        } else if (label == "Notifications") {
          controller.navigateTo(RoutesNames.notificationDataScreen);
        } else if (label == 'Help') {}
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isLogout
                  ? Colors.red.withOpacity(0.1)
                  : AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isLogout ? Colors.red : AppColors.primaryColor,
              size: 24,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isLogout ? Colors.red : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // Logout Confirmation Dialog
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Alex Johnson',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'alex.johnson@company.com',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+1 (555) 123-4567',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
