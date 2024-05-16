import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationCubit extends Cubit<int> {
  PaginationCubit() : super(0);

  void nextPage() => emit(state + 4);

  void backPage() => emit(state - 4);
}
