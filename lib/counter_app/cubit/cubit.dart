import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/counter_app/cubit/counter_state.dart';

class CounterCubit extends Cubit<int>{
  CounterCubit() : super (0);
  addCounter(){
    emit(state+1);
}
// minusConter(){
//     counter--;
//     emit(LoadedState());
//
// }
}