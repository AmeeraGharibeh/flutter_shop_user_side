import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesEvents.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesStates.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Providers/dataProvider.dart';
import 'package:flutter_shop/Repository/fetchDataRepo.dart';
import 'package:provider/provider.dart';

class AddressesBloc extends Bloc<AddressesEvents, AddressesState> {
  fetchDataRepository repo;
  AddressesBloc(AddressesState initialState, this.repo) : super(initialState);

  @override
  Stream<AddressesState> mapEventToState(AddressesEvents event) async*{
    if (event is addressesInit) {
      try{
        yield fetchAddressesLoading();
        List<addressesModel> addressesList = await repo.fetchUsersAddresse();
        List<addressesModel> usersAddresses = [];
        usersAddresses = addressesList.where((element) => element.userId == event.userId).toList();
        print('data from addresses bloc : ' + usersAddresses.first.name);
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        provider.setData(usersAddresses);
        yield fetchAddressesSuccess();
      } catch (err) {
        yield fetchAddressesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addAddresssButtonPressed) {
      yield addAddressesLoading();
      try{
        addressesModel addressObj = await repo.posAddress(event.userId, event.name, event.country, event.city, event.area, event.details1, event.details2);
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        provider.setOne(addressObj);
        yield addAddressesSuccess();

      }catch(err){
        yield addAddressesFailure();
        print('error from add favorites Error ' +err.toString());
      }
    }
    if (event is updateAddressButtonPresses) {
      yield addAddressesLoading();
      try{
        addressesModel addressObj = await repo.updateAddress(event.id, event.name, event.city, event.area, event.details1, event.details2);
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        provider.setOne(addressObj);
        yield addAddressesSuccess();

      }catch(err){
        yield addAddressesFailure();
        print('error from update card Error ' +err.toString());
      }
    }

    if (event is removeFromAddressesButtonPressed) {
      yield addAddressesLoading();
      try{
        await repo.deleteAddress(event.itemId);
        yield addAddressesSuccess();
      }catch(err){
        yield addAddressesFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }

    }
  }
}