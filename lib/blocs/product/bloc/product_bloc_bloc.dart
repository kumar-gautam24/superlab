import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


import '../../../models/product_model.dart';
import '../../../sevices/product_service.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<FetchAllProductBlocEvent>((event, emit) async {
      emit(ProductBlocLoding());
      try {
        final response = await ProductService.fetchAllProducts(limit:event.limit,search:event.id);
        emit(AllProductBlocLoded(product: response));
      } catch (e) {
        if (kDebugMode) {
          print("in all product bloc error : $e");
        }
      }
    });
    on<ProductDetailsBlocEvent>((event, emit) async {
      emit(ProductBlocLoding());
      try {
        final response = await ProductService.fetchProductDetails(event.id);
        emit(ProductBlocLoded(product: response!));
      } catch (e) {
        if (kDebugMode) {
          print("in  product detail bloc error : $e");
        }
      }
    });
  }
}
