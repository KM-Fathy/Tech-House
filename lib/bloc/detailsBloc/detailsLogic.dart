import 'package:bloc/bloc.dart';
import 'detailsState.dart';

class DetailsLogic extends Cubit<DetailsState> {
  DetailsLogic() : super(InitDetails());

}