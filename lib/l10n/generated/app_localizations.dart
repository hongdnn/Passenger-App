import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @testString.
  ///
  /// In en, this message translates to:
  /// **'Test String'**
  String get testString;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @current_location.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get current_location;

  /// No description provided for @save_place.
  ///
  /// In en, this message translates to:
  /// **'Save place'**
  String get save_place;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @promotion_page_title.
  ///
  /// In en, this message translates to:
  /// **'My promo code'**
  String get promotion_page_title;

  /// No description provided for @search_empty_title.
  ///
  /// In en, this message translates to:
  /// **'We are sorry'**
  String get search_empty_title;

  /// No description provided for @search_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We cannot find what you are looking for :('**
  String get search_empty_subtitle;

  /// No description provided for @apply_promotion_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Cannot continue'**
  String get apply_promotion_dialog_title;

  /// No description provided for @apply_promotion_dialog_msg.
  ///
  /// In en, this message translates to:
  /// **'Cannot continue \n An error occurred, please try again'**
  String get apply_promotion_dialog_msg;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @promotion_apply_now.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get promotion_apply_now;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @hint_text_search.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get hint_text_search;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Instant'**
  String get book_now;

  /// No description provided for @landing_page_title.
  ///
  /// In en, this message translates to:
  /// **'Choose destination'**
  String get landing_page_title;

  /// No description provided for @last_place.
  ///
  /// In en, this message translates to:
  /// **'Last place'**
  String get last_place;

  /// No description provided for @book_again.
  ///
  /// In en, this message translates to:
  /// **'Book again'**
  String get book_again;

  /// No description provided for @book_in_advance.
  ///
  /// In en, this message translates to:
  /// **'Book in advance'**
  String get book_in_advance;

  /// No description provided for @add_a_place.
  ///
  /// In en, this message translates to:
  /// **'Add a place'**
  String get add_a_place;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @recently_used.
  ///
  /// In en, this message translates to:
  /// **'Recently used'**
  String get recently_used;

  /// No description provided for @ready_to_book.
  ///
  /// In en, this message translates to:
  /// **'Ready to book this ride?'**
  String get ready_to_book;

  /// No description provided for @add_address.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get add_address;

  /// No description provided for @suggested_rides.
  ///
  /// In en, this message translates to:
  /// **'Suggested Rides'**
  String get suggested_rides;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @call_now.
  ///
  /// In en, this message translates to:
  /// **'call now'**
  String get call_now;

  /// No description provided for @save_address.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get save_address;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @map_error.
  ///
  /// In en, this message translates to:
  /// **'Map error'**
  String get map_error;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get choose_time;

  /// No description provided for @rating_page_title.
  ///
  /// In en, this message translates to:
  /// **'Please rate my service'**
  String get rating_page_title;

  /// No description provided for @rating_section_title_reason.
  ///
  /// In en, this message translates to:
  /// **'How\'s the service? Let us know'**
  String get rating_section_title_reason;

  /// No description provided for @rating_section_title_tip.
  ///
  /// In en, this message translates to:
  /// **'Consider giving a tip'**
  String get rating_section_title_tip;

  /// No description provided for @rating_section_title_comment.
  ///
  /// In en, this message translates to:
  /// **'Additional Comments'**
  String get rating_section_title_comment;

  /// No description provided for @rating_comment_hint.
  ///
  /// In en, this message translates to:
  /// **'Tell us more (Optinal)'**
  String get rating_comment_hint;

  /// No description provided for @error_common_msg.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_common_msg;

  /// No description provided for @checkout_confirmation_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm driver and pay'**
  String get checkout_confirmation_title;

  /// No description provided for @checkout_confirmation_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get checkout_confirmation_button;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @add_note_to_driver.
  ///
  /// In en, this message translates to:
  /// **'Add note to driver'**
  String get add_note_to_driver;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @travel_time.
  ///
  /// In en, this message translates to:
  /// **'Travel time'**
  String get travel_time;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @looking_for_driver.
  ///
  /// In en, this message translates to:
  /// **'Looking for a driver.'**
  String get looking_for_driver;

  /// No description provided for @cancel_reservation.
  ///
  /// In en, this message translates to:
  /// **'Cancel reservation'**
  String get cancel_reservation;

  /// No description provided for @my_card.
  ///
  /// In en, this message translates to:
  /// **'My card'**
  String get my_card;

  /// No description provided for @msg_delete_favorite.
  ///
  /// In en, this message translates to:
  /// **'This location will be removed from your favorite permanently'**
  String get msg_delete_favorite;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @message_to_driver.
  ///
  /// In en, this message translates to:
  /// **'Message to driver'**
  String get message_to_driver;

  /// No description provided for @hint_text_message_to_driver.
  ///
  /// In en, this message translates to:
  /// **'Such as a spotting place'**
  String get hint_text_message_to_driver;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cannot_find_driver.
  ///
  /// In en, this message translates to:
  /// **'we couldn\'t find any drivers at this time.'**
  String get cannot_find_driver;

  /// No description provided for @search_again.
  ///
  /// In en, this message translates to:
  /// **'search again'**
  String get search_again;

  /// No description provided for @choose_from_map.
  ///
  /// In en, this message translates to:
  /// **'Choose from map'**
  String get choose_from_map;

  /// No description provided for @save_address_favourite.
  ///
  /// In en, this message translates to:
  /// **'Save your favourite places'**
  String get save_address_favourite;

  /// No description provided for @no_data_for.
  ///
  /// In en, this message translates to:
  /// **'No data for'**
  String get no_data_for;

  /// No description provided for @order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get order_summary;

  /// No description provided for @robinhood_car.
  ///
  /// In en, this message translates to:
  /// **'Robinhood Car'**
  String get robinhood_car;

  /// No description provided for @promo.
  ///
  /// In en, this message translates to:
  /// **'PROMO'**
  String get promo;

  /// No description provided for @robinhood_coin.
  ///
  /// In en, this message translates to:
  /// **'Robinhood Coin'**
  String get robinhood_coin;

  /// No description provided for @virtual_ccount.
  ///
  /// In en, this message translates to:
  /// **'Virtual Account'**
  String get virtual_ccount;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get payment_methods;

  /// No description provided for @select_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Select payment method'**
  String get select_payment_method;

  /// No description provided for @confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm cancellation'**
  String get confirm_cancel;

  /// No description provided for @message_confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'If you cancel this booking You will be suspended from the service for a period of 3 hours.'**
  String get message_confirm_cancel;

  /// No description provided for @message_cancel_booking.
  ///
  /// In en, this message translates to:
  /// **'Cancel the reservation \n Press the OK button.'**
  String get message_cancel_booking;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get go_back;

  /// No description provided for @cancel_booking_title.
  ///
  /// In en, this message translates to:
  /// **'Cancel my reservation'**
  String get cancel_booking_title;

  /// No description provided for @reason_cancel_booking.
  ///
  /// In en, this message translates to:
  /// **'Reason for cancellation'**
  String get reason_cancel_booking;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @expressway.
  ///
  /// In en, this message translates to:
  /// **'Expressway'**
  String get expressway;

  /// No description provided for @all_items.
  ///
  /// In en, this message translates to:
  /// **'All items'**
  String get all_items;

  /// No description provided for @choose_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose another payment method'**
  String get choose_payment_method;

  /// No description provided for @promo_newuser.
  ///
  /// In en, this message translates to:
  /// **'PROMO NEWUSER'**
  String get promo_newuser;

  /// No description provided for @payment_message.
  ///
  /// In en, this message translates to:
  /// **'Payment verification in progress.'**
  String get payment_message;

  /// No description provided for @cannot_reserved.
  ///
  /// In en, this message translates to:
  /// **'This time cannot be reserved.'**
  String get cannot_reserved;

  /// No description provided for @booking_time_err_msg.
  ///
  /// In en, this message translates to:
  /// **'Please book at least 1 hour in advance.'**
  String get booking_time_err_msg;

  /// No description provided for @unable_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Unable to continue'**
  String get unable_to_continue;

  /// No description provided for @because_you_already_have_a_reservation.
  ///
  /// In en, this message translates to:
  /// **'Because you already have a reservation.'**
  String get because_you_already_have_a_reservation;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @get_a_car.
  ///
  /// In en, this message translates to:
  /// **'Get a car'**
  String get get_a_car;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @emergency_call.
  ///
  /// In en, this message translates to:
  /// **'Emergency Call'**
  String get emergency_call;

  /// No description provided for @silent_ride.
  ///
  /// In en, this message translates to:
  /// **'Silent ride'**
  String get silent_ride;

  /// No description provided for @do_not_disturb.
  ///
  /// In en, this message translates to:
  /// **'Do not disturb'**
  String get do_not_disturb;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @rate_service.
  ///
  /// In en, this message translates to:
  /// **'Rate service'**
  String get rate_service;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @ride_again.
  ///
  /// In en, this message translates to:
  /// **'Ride again'**
  String get ride_again;

  /// No description provided for @report_issue.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get report_issue;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @order_no.
  ///
  /// In en, this message translates to:
  /// **'Order no.'**
  String get order_no;

  /// No description provided for @favorite_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Address name'**
  String get favorite_title_hint;

  /// No description provided for @favorite_desc_hint.
  ///
  /// In en, this message translates to:
  /// **'Address details to rider'**
  String get favorite_desc_hint;

  /// No description provided for @newuser.
  ///
  /// In en, this message translates to:
  /// **'NEWUSER'**
  String get newuser;

  /// No description provided for @error_msg_payment.
  ///
  /// In en, this message translates to:
  /// **'Payment unsuccessful, Please try again.'**
  String get error_msg_payment;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payment_methods_trip_detail.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get payment_methods_trip_detail;

  /// No description provided for @select_payment_method_trip_detail.
  ///
  /// In en, this message translates to:
  /// **'Select payment method'**
  String get select_payment_method_trip_detail;

  /// No description provided for @schedule_a_ride_for_header.
  ///
  /// In en, this message translates to:
  /// **'Schedule a ride for'**
  String get schedule_a_ride_for_header;

  /// No description provided for @schedule_a_ride_for_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule a ride for'**
  String get schedule_a_ride_for_title;

  /// No description provided for @primary_card.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary_card;

  /// No description provided for @waiting_for_payment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for payment'**
  String get waiting_for_payment;

  /// No description provided for @unsuccessful_payment.
  ///
  /// In en, this message translates to:
  /// **'Unsuccessful payment'**
  String get unsuccessful_payment;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @canceled_drive.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled_drive;

  /// No description provided for @scb_payment.
  ///
  /// In en, this message translates to:
  /// **'SCB easy'**
  String get scb_payment;

  /// No description provided for @qrcode_payment.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrcode_payment;

  /// No description provided for @add_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Add payment method'**
  String get add_payment_method;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @confirm_to_change_payment_method_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm to change primary\npayment method'**
  String get confirm_to_change_payment_method_title;

  /// No description provided for @confirm_to_change_payment_method_msg.
  ///
  /// In en, this message translates to:
  /// **'Do you confirm to change your primary\npayment method?'**
  String get confirm_to_change_payment_method_msg;

  /// No description provided for @rider_found.
  ///
  /// In en, this message translates to:
  /// **'Rider found'**
  String get rider_found;

  /// No description provided for @the_driver_is_here.
  ///
  /// In en, this message translates to:
  /// **'The driver is here'**
  String get the_driver_is_here;

  /// No description provided for @im_arrived.
  ///
  /// In en, this message translates to:
  /// **'I\'m arrived'**
  String get im_arrived;

  /// No description provided for @bookmark_add_new_title.
  ///
  /// In en, this message translates to:
  /// **'Add location (Save your favourite places)'**
  String get bookmark_add_new_title;

  /// No description provided for @book_trip_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get book_trip_now;

  /// No description provided for @add_card.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get add_card;

  /// No description provided for @card_information.
  ///
  /// In en, this message translates to:
  /// **'Card information'**
  String get card_information;

  /// No description provided for @card_name.
  ///
  /// In en, this message translates to:
  /// **'Card name'**
  String get card_name;

  /// No description provided for @card_number.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get card_number;

  /// No description provided for @card_expired.
  ///
  /// In en, this message translates to:
  /// **'Card expired'**
  String get card_expired;

  /// No description provided for @code_on_the_back_card.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get code_on_the_back_card;

  /// No description provided for @name_of_card.
  ///
  /// In en, this message translates to:
  /// **'Card nickname (optional)'**
  String get name_of_card;

  /// No description provided for @message_add_card.
  ///
  /// In en, this message translates to:
  /// **'A minimum amount will be charged to \nyour cardto prove its validity. The amount \nwill be automatically refunded \nshortly after.'**
  String get message_add_card;

  /// No description provided for @please_enter_card_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid card name'**
  String get please_enter_card_name;

  /// No description provided for @please_enter_card_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid card number'**
  String get please_enter_card_number;

  /// No description provided for @please_enter_card_expired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid card expired date'**
  String get please_enter_card_expired;

  /// No description provided for @please_enter_cvv.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid cvv number'**
  String get please_enter_cvv;

  /// No description provided for @card_number_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid card number'**
  String get card_number_invalid;

  /// No description provided for @cvv_number_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid cvv number'**
  String get cvv_number_invalid;

  /// No description provided for @expired_date_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid card expiration date'**
  String get expired_date_invalid;

  /// No description provided for @add_card_success.
  ///
  /// In en, this message translates to:
  /// **'Add card successfully'**
  String get add_card_success;

  /// No description provided for @you_have_success.
  ///
  /// In en, this message translates to:
  /// **'You have succeeded'**
  String get you_have_success;

  /// No description provided for @edit_card.
  ///
  /// In en, this message translates to:
  /// **'Edit card'**
  String get edit_card;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @success_payment.
  ///
  /// In en, this message translates to:
  /// **'Successful payment'**
  String get success_payment;

  /// No description provided for @thanks_for_your_pay.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your payment'**
  String get thanks_for_your_pay;

  /// No description provided for @driver_to_pickup_point.
  ///
  /// In en, this message translates to:
  /// **'Driver to Pick-up Point'**
  String get driver_to_pickup_point;

  /// No description provided for @pickup_point_to_destination.
  ///
  /// In en, this message translates to:
  /// **'Pick-up Point to Destination'**
  String get pickup_point_to_destination;

  /// No description provided for @delete_card.
  ///
  /// In en, this message translates to:
  /// **'Delete card'**
  String get delete_card;

  /// No description provided for @message_delete_card.
  ///
  /// In en, this message translates to:
  /// **'Confirm card deletion'**
  String get message_delete_card;

  /// No description provided for @delete_primary_card.
  ///
  /// In en, this message translates to:
  /// **'Delete primary card'**
  String get delete_primary_card;

  /// No description provided for @message_delete_primary_card.
  ///
  /// In en, this message translates to:
  /// **'We will change the channel. The main payment is SCB easy.'**
  String get message_delete_primary_card;

  /// No description provided for @delete_card_success_1.
  ///
  /// In en, this message translates to:
  /// **'The card number'**
  String get delete_card_success_1;

  /// No description provided for @delete_card_success_2.
  ///
  /// In en, this message translates to:
  /// **'has been deleted.'**
  String get delete_card_success_2;

  /// No description provided for @update_card_success.
  ///
  /// In en, this message translates to:
  /// **'Successful record.'**
  String get update_card_success;

  /// No description provided for @error_message.
  ///
  /// In en, this message translates to:
  /// **'An error occurred Please try again.'**
  String get error_message;

  /// No description provided for @permission_is_required.
  ///
  /// In en, this message translates to:
  /// **'permission is required'**
  String get permission_is_required;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @type_message.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get type_message;

  /// No description provided for @require_camera_permission.
  ///
  /// In en, this message translates to:
  /// **'Require camera permission'**
  String get require_camera_permission;

  /// No description provided for @require_camera_permission_explained.
  ///
  /// In en, this message translates to:
  /// **'This app needs camera access to take pictures for upload user profile photo'**
  String get require_camera_permission_explained;

  /// No description provided for @success_advance_booking.
  ///
  /// In en, this message translates to:
  /// **'Successful, Advance Booking'**
  String get success_advance_booking;

  /// No description provided for @the_driver_is_almost_there.
  ///
  /// In en, this message translates to:
  /// **'The driver is almost there'**
  String get the_driver_is_almost_there;

  /// No description provided for @im_on_my_way.
  ///
  /// In en, this message translates to:
  /// **'I\'m on my way'**
  String get im_on_my_way;

  /// No description provided for @driver_arrived_destination.
  ///
  /// In en, this message translates to:
  /// **'Driver arrived destination'**
  String get driver_arrived_destination;

  /// No description provided for @driver_found.
  ///
  /// In en, this message translates to:
  /// **'Driver found'**
  String get driver_found;

  /// No description provided for @driver_will_arrived_within_1_hours.
  ///
  /// In en, this message translates to:
  /// **'Driver will arrived within 1 hours'**
  String get driver_will_arrived_within_1_hours;

  /// No description provided for @driver_pickup.
  ///
  /// In en, this message translates to:
  /// **'Driver Pick-up'**
  String get driver_pickup;

  /// No description provided for @the_driver_is_waiting.
  ///
  /// In en, this message translates to:
  /// **'The driver is waiting'**
  String get the_driver_is_waiting;

  /// No description provided for @drop_off_mid_destination.
  ///
  /// In en, this message translates to:
  /// **'Drop off mid destination'**
  String get drop_off_mid_destination;

  /// No description provided for @promo_expiration.
  ///
  /// In en, this message translates to:
  /// **'expiration dates'**
  String get promo_expiration;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get use;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @deny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get deny;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @tip_payment_title_header.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get tip_payment_title_header;

  /// No description provided for @tip_order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get tip_order_summary;

  /// No description provided for @tip_value.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip_value;

  /// No description provided for @tip_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get tip_total;

  /// No description provided for @tip_payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get tip_payment_methods;

  /// No description provided for @tip_select_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Select payment method'**
  String get tip_select_payment_method;

  /// No description provided for @incorrect_information.
  ///
  /// In en, this message translates to:
  /// **'Incorrect information'**
  String get incorrect_information;

  /// No description provided for @fare.
  ///
  /// In en, this message translates to:
  /// **'Fare'**
  String get fare;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// No description provided for @enter_promo_code_here.
  ///
  /// In en, this message translates to:
  /// **'Enter promo code here'**
  String get enter_promo_code_here;

  /// No description provided for @successful_payment.
  ///
  /// In en, this message translates to:
  /// **'Successful payment'**
  String get successful_payment;

  /// No description provided for @complete_within_48_hours.
  ///
  /// In en, this message translates to:
  /// **'Complete within 48 hours'**
  String get complete_within_48_hours;

  /// No description provided for @losing_connect.
  ///
  /// In en, this message translates to:
  /// **'Losing Connect'**
  String get losing_connect;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @no_internet_title.
  ///
  /// In en, this message translates to:
  /// **'ไม่สามารถดำเนินการต่อได้'**
  String get no_internet_title;

  /// No description provided for @no_internet_msg.
  ///
  /// In en, this message translates to:
  /// **'โทรศัพท์ของคุณไม่สามารถเชื่อมเต่อ อินเทอร์เน็ตได้ในขณะนี้ กรุณาตรวจสอบ สัญญาณและลองใหม่อีกครั้ง'**
  String get no_internet_msg;

  /// No description provided for @no_internet_button_title.
  ///
  /// In en, this message translates to:
  /// **'ตกลง'**
  String get no_internet_button_title;

  /// No description provided for @api_load_fail_button_title.
  ///
  /// In en, this message translates to:
  /// **'API ERROR'**
  String get api_load_fail_button_title;

  /// No description provided for @per_km.
  ///
  /// In en, this message translates to:
  /// **'Per km'**
  String get per_km;

  /// No description provided for @minimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get minimum;

  /// No description provided for @baht.
  ///
  /// In en, this message translates to:
  /// **'Baht'**
  String get baht;

  /// No description provided for @you_do_not_have_any_ongoing_activities.
  ///
  /// In en, this message translates to:
  /// **'You do not have any ongoing activities.'**
  String get you_do_not_have_any_ongoing_activities;

  /// No description provided for @you_do_not_have_any_completed_activities.
  ///
  /// In en, this message translates to:
  /// **'You do not have any completed activities.'**
  String get you_do_not_have_any_completed_activities;

  /// No description provided for @you_do_not_have_any_canceled_activities.
  ///
  /// In en, this message translates to:
  /// **'You do not have any canceled activities.'**
  String get you_do_not_have_any_canceled_activities;

  /// No description provided for @upsert_error_title.
  ///
  /// In en, this message translates to:
  /// **'All prices are subject to change'**
  String get upsert_error_title;

  /// No description provided for @upsert_error_content.
  ///
  /// In en, this message translates to:
  /// **'At this time, the fare has been changed.\nPlease check the details again'**
  String get upsert_error_content;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'th': return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
