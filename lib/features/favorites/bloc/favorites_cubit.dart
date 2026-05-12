import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/favorite_item.dart';

@lazySingleton
class FavoritesCubit extends Cubit<List<FavoriteItem>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(FavoriteItem item) {
    if (state.contains(item)) {
      removeItem(item);
    } else {
      addItem(item);
    }
  }

  void addItem(FavoriteItem item) {
    if (!state.contains(item)) {
      final newState = List<FavoriteItem>.from(state)..add(item);
      emit(newState);
    }
  }

  void removeItem(FavoriteItem item) {
    final newState = List<FavoriteItem>.from(state)..remove(item);
    emit(newState);
  }
}
