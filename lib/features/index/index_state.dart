part of 'index_cubit.dart';

class IndexState extends Equatable{
  // final NavbarItem navbarItem;
  final int index;

  const IndexState( this.index);

  @override
  List<Object> get props => [index];

}