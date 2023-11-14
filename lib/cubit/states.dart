abstract class LocationStates{}
class LocationInitialState extends LocationStates{}
class LocationEnabledSuccess extends LocationStates{}
class GetCurrentLocationSuccess extends LocationStates{}
class GetCurrentLocationError extends LocationStates
{
  final error;
  GetCurrentLocationError(this.error);
}
class GetPositionSuccess extends LocationStates{}
class MoodChangesSuccessfully extends LocationStates{}
class DarkMapMood extends LocationStates{}
class LightMapMood extends LocationStates{}
class ChangeLocation extends LocationStates{}
class LiveLocation extends LocationStates{}
class ArabicState extends LocationStates{}
class ButtonDisappeared extends LocationStates{}
class AddPolyline extends LocationStates{}
class ServiceClickedSuccessfully extends LocationStates{}
class RemovedSuccessfully extends LocationStates{}
class EnglishState extends LocationStates{}
class DirectionsSuccess extends LocationStates{}
class RemoveItems extends LocationStates{}
class AppearAlertSuccessToProvider extends LocationStates{}
//Alaa
class DataContainerVisibility extends LocationStates{}
class DataContainerUserVisibility extends LocationStates{}
class ServiceButtonsVisibility extends LocationStates{}
class ServiceButtonsVisibilityInUser extends LocationStates{}
class PasswordVisibility extends LocationStates{}
class ConfirmPasswordVisibility extends LocationStates{}
class ChangeDataInFireStore extends LocationStates{}
class ChangeDataInFireStoreByUser extends LocationStates{}
class GetDataFromFireStore extends LocationStates{}
class GetDataFromFireStoreByUser extends LocationStates{}
class GetButtonsDataFromFireStore extends LocationStates{}
class GetButtonsDataFromFireStoreByUser extends LocationStates{}
class IsServiceDonee extends LocationStates{}
class UpdatingServiceDoneInFirestor extends LocationStates{}
class GettingServiceDone extends LocationStates{}
class ChangingServiceDoneInFirestor extends LocationStates{}
class UserData extends LocationStates{}
class ProviderData extends LocationStates{}
//Alaa
