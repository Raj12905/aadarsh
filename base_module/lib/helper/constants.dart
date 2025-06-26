import 'config.dart';

enum MasterType {
  professional('1'),
  specialization('2'),
  symptom('3'),
  language('4'),
  days('5');

  final String value;
  const MasterType(this.value);
}

enum ApiAction {
  sendOtp('send_otp'),
  verifyOtp('verify_otp'),
  master('master'),
  getProfile('view_consultant_profile'),
  getTimeSlots('consultant/get_slot_detail'),
  updateTimeSlots('consultant/update_time_slot'),
  updateAvailability('consultant/update_live_status'),
  upcomingBookings('booking/upcoming_booking'),
  historyBookings('booking/history');

  final String path;
  const ApiAction(this.path);

  @override
  String toString() => path; // Returns only the endpoint
}
