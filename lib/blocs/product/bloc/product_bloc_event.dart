part of 'product_bloc_bloc.dart';

sealed class ProductBlocEvent extends Equatable {
  const ProductBlocEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllProductBlocEvent extends ProductBlocEvent {
  final int limit;
  final String id;
  const FetchAllProductBlocEvent( {required this.limit, this.id=''});

  @override
  List<Object> get props => [limit];
}


final class ProductDetailsBlocEvent extends ProductBlocEvent {
  final String id;
  const ProductDetailsBlocEvent({required this.id});

  @override
  List<Object> get props => [id];
}
