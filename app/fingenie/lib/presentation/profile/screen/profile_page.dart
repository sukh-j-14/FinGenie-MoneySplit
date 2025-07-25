import 'package:fingenie/data/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fingenie/utils/app_logger.dart';
import 'package:fingenie/domain/models/user_model.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Box<UserModel>? userBox;
  UserModel? currentUser;
  String? token;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _showErrorSnackBar(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> _loadUserData() async {
    try {
      // Get token from SharedPreferences
      final authRepository = AuthRepository();
      token = await authRepository.getStoredToken();
      AppLogger.debug('Token loaded: ${token ?? 'No token found'}');

      // Debug box state before loading
      await AuthRepository.debugBoxContents();

      // Register the adapter if not already registered
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(UserModelAdapter());
      }

      // Use the already opened box
      userBox = Hive.box<UserModel>('userBox');

      if (userBox == null) {
        throw Exception('Failed to open userBox');
      }

      final user = userBox?.get('current_user');

      if (user != null) {
        setState(() {
          currentUser = user;
        });
        AppLogger.debug('''
Profile loaded user successfully:
ID: ${user.id}
Name: ${user.name}
Email: ${user.email}
IsLoggedIn: ${user.isLoggedIn}
''');
      } else {
        AppLogger.warning('''
Profile: No user found in box
Box is open: ${userBox?.isOpen}
Box length: ${userBox?.length}
Box keys: ${userBox?.keys.toList()}
''');
      }
    } catch (e) {
      AppLogger.error('Profile: Error loading user data: $e');
      _showErrorSnackBar('Error loading profile: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: currentUser != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Text(
                            currentUser!.name[0].toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          currentUser!.name,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoItem(
                          icon: Icons.email,
                          label: 'Email',
                          value: currentUser!.email,
                        ),
                        _buildInfoItem(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: currentUser!.phoneNumber,
                        ),
                        _buildInfoItem(
                          icon: Icons.work,
                          label: 'Occupation',
                          value: currentUser!.occupation,
                        ),
                        _buildInfoItem(
                          icon: Icons.calendar_today,
                          label: 'Age',
                          value: '${currentUser!.age} years',
                        ),
                        _buildInfoItem(
                          icon: Icons.currency_rupee,
                          label: 'Monthly Income',
                          value:
                              '${currentUser!.currency} ${currentUser!.monthlyIncome}',
                        ),
                        _buildInfoItem(
                          icon: Icons.access_time,
                          label: 'Member Since',
                          value: DateFormat('MMM dd, yyyy')
                              .format(currentUser!.createdAt),
                        ),
                        _buildInfoItem(
                          icon: Icons.access_time,
                          label: 'ID',
                          value: currentUser!.id,
                        ),
                        if (token != null)
                          _buildInfoItem(
                            icon: Icons.vpn_key,
                            label: 'Auth Token',
                            value: token!,
                          ),
                      ],
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text('No user data found'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (userBox != null && userBox!.isOpen) {
      userBox!.close();
    }
    super.dispose();
  }
}
