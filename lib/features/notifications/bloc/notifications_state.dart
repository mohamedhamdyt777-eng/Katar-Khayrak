import 'package:equatable/equatable.dart';
import '../models/app_notification.dart';

class NotificationsState extends Equatable {
  final List<AppNotification> notifications;

  const NotificationsState({this.notifications = const []});

  NotificationsState copyWith({
    List<AppNotification>? notifications,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [notifications];
}
