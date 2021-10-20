import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesEvents.dart';
import 'package:flutter_shop/Blocs/addressesBloc/addressesStates.dart';
import 'package:flutter_shop/Models/addressesModel.dart';
import 'package:flutter_shop/Models/userModel.dart';
import 'package:flutter_shop/Providers/dataProviders/addressesProvider.dart';
import 'package:flutter_shop/Providers/usersProvider.dart';
import 'package:flutter_shop/Repository/authRepository.dart';
import 'package:provider/provider.dart';

class AddressesBloc extends Bloc<AddressesEvents, AddressesState> {
  AuthRepository auth;
  AddressesBloc(AddressesState initialState, this.auth) : super(initialState);

  @override
  Stream<AddressesState> mapEventToState(AddressesEvents event) async*{
    if (event is addressesInit) {
      try{
        yield fetchAddressesLoading();
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        List<addressesModel> addressesList = await provider.fetchUsersAddresse();
        provider.setData(addressesList, event.userId);
        yield fetchAddressesSuccess();
      } catch (err) {
        yield fetchAddressesFailure(msg: err.toString());
        print('error from fetch data ' +err.toString());
      }
    }
    if (event is addAddresssButtonPressed) {
      yield addAddressesLoading();
      try{
        /*    var provider = Provider.of<addressesProvider>(event.context, listen: false);
        addressesModel addressObj = await repo.posAddress(event.userId, event.name, event.country, event.city, event.area, event.details1, event.details2).then((value) async {
          List<addressesModel> addressesList = await repo.fetchUsersAddresse();
          List<addressesModel> usersAddresses = [];
          usersAddresses = addressesList.where((element) => element.userId == event.userId).toList();
          userModel user = await auth.updateAddress(event.userId, value.addressId);
          var userPr = Provider.of<userProvider>(event.context, listen: false);
          userPr.setData(user);
          return provider.setData(usersAddresses);

        });
        provider.setOne(addressObj);*/
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        addressesModel addressObj = await provider.posAddress(event.userId, event.name, event.country, event.city, event.area, event.details1, event.details2);
        provider.setOne(addressObj);
        userModel user = await auth.updateAddress(event.userId, addressObj.addressId);
        var userPr = Provider.of<userProvider>(event.context, listen: false);
        userPr.setData(user);
        yield addAddressesSuccess();

      }catch(err){
        yield addAddressesFailure();
        print('error from add favorites Error ' +err.toString());
      }
    }
    if (event is updateAddressButtonPresses) {
      yield addAddressesLoading();
      try{
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        addressesModel addressObj = await provider.updateAddress(event.id, event.name, event.city, event.area, event.details1, event.details2);
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
        var provider = Provider.of<addressesProvider>(event.context, listen: false);
        await provider.deleteAddress(event.itemId);
        yield addAddressesSuccess();
      }catch(err){
        yield addAddressesFailure();
        print('error from delete shoppingCart Error ' +err.toString());
      }

    }
  }
}