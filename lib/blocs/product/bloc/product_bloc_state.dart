part of 'product_bloc_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState({Product? product});

  @override
  List<Object> get props => [];
}

final class ProductBlocInitial extends ProductBlocState {}

// loading
final class ProductBlocLoding extends ProductBlocState {}

// loaded
final class AllProductBlocLoded extends ProductBlocState {
  final List<Product> product;

  const AllProductBlocLoded({required this.product});

  @override
  List<Object> get props => [product];
}
final class ProductBlocLoded extends ProductBlocState {
  final Product product;

  const ProductBlocLoded({required this.product});

  @override
  List<Object> get props => [product];
}

// error
final class ProductBlocError extends ProductBlocState {}
