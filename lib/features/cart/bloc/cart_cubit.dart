import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../models/cart_item.dart';

@lazySingleton
class CartCubit extends Cubit<List<CartItem>> {
  CartCubit() : super([]);

  void addItem(CartItem item) {
    if (!state.contains(item)) {
      final newState = List<CartItem>.from(state)..add(item);
      emit(newState);
    }
  }

  void removeItem(CartItem item) {
    final newState = List<CartItem>.from(state)..remove(item);
    emit(newState);
  }

  void clearCart() {
    emit([]);
  }
}
