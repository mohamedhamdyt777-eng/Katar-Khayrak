import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../models/app_notification.dart';
import 'notifications_state.dart';

@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState(notifications: _initialNotifications));

  static final List<AppNotification> _initialNotifications = [
    AppNotification(
      id: '1',
      title: 'Reminder to Donate',
      body: 'Your contribution can save lives today! Tap here to explore campaigns and make a difference.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    AppNotification(
      id: '2',
      title: 'Welcome to Katar Khayrak',
      body: 'Thank you for joining our community. Start browsing charity organizations and campaigns.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];

  void markAsRead(String id) {
    final updatedList = state.notifications.map((notif) {
      if (notif.id == id) {
        return notif.copyWith(isRead: true);
      }
      return notif;
    }).toList();
    emit(state.copyWith(notifications: updatedList));
  }

  void markAllAsRead() {
    final updatedList = state.notifications.map((notif) => notif.copyWith(isRead: true)).toList();
    emit(state.copyWith(notifications: updatedList));
  }

  void removeNotification(String id) {
    final updatedList = state.notifications.where((n) => n.id != id).toList();
    emit(state.copyWith(notifications: updatedList));
  }

  void removeAll() {
    emit(state.copyWith(notifications: []));
  }

  void addNotification({required String title, required String body}) {
    final newNotif = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      timestamp: DateTime.now(),
      isRead: false,
    );
    final updatedList = [newNotif, ...state.notifications];
    emit(state.copyWith(notifications: updatedList));
  }
}
