// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to`
  String get welcome {
    return Intl.message(
      'Welcome to',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with`
  String get signInWith {
    return Intl.message(
      'Sign in with',
      name: 'signInWith',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with the same email but different sign in credentials.`
  String get accExists {
    return Intl.message(
      'An account already exists with the same email but different sign in credentials.',
      name: 'accExists',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Quit`
  String get quit {
    return Intl.message(
      'Quit',
      name: 'quit',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get sound {
    return Intl.message(
      'Sound',
      name: 'sound',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact {
    return Intl.message(
      'Contact us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Terms & privacy`
  String get termAndPr {
    return Intl.message(
      'Terms & privacy',
      name: 'termAndPr',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get games {
    return Intl.message(
      'Games',
      name: 'games',
      desc: '',
      args: [],
    );
  }

  /// `Get ready !!`
  String get ready {
    return Intl.message(
      'Get ready !!',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Remember the highlighted tiles. The tiles reveal themselves momentarily before flipping back over.`
  String get memoMessage {
    return Intl.message(
      'Remember the highlighted tiles. The tiles reveal themselves momentarily before flipping back over.',
      name: 'memoMessage',
      desc: '',
      args: [],
    );
  }

  /// `Pay close attention to the cards you flip over. Try to remember the positions of the cards.`
  String get findPairMessage {
    return Intl.message(
      'Pay close attention to the cards you flip over. Try to remember the positions of the cards.',
      name: 'findPairMessage',
      desc: '',
      args: [],
    );
  }

  /// `Choice the answer to solving math problems, quickly and accurately as possible.`
  String get mathMessage {
    return Intl.message(
      'Choice the answer to solving math problems, quickly and accurately as possible.',
      name: 'mathMessage',
      desc: '',
      args: [],
    );
  }

  /// `Remember the previous card shown and select whether or not the next card matches the previous card.`
  String get speedMatchMessage {
    return Intl.message(
      'Remember the previous card shown and select whether or not the next card matches the previous card.',
      name: 'speedMatchMessage',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message(
      'Score',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `High score`
  String get highScore {
    return Intl.message(
      'High score',
      name: 'highScore',
      desc: '',
      args: [],
    );
  }

  /// `New high score`
  String get newHighScore {
    return Intl.message(
      'New high score',
      name: 'newHighScore',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuew {
    return Intl.message(
      'Continue',
      name: 'continuew',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get currentw {
    return Intl.message(
      'Current',
      name: 'currentw',
      desc: '',
      args: [],
    );
  }

  /// `No results found.`
  String get noRes {
    return Intl.message(
      'No results found.',
      name: 'noRes',
      desc: '',
      args: [],
    );
  }

  /// `We couldn’t find what you’re looking for.`
  String get couldntFind {
    return Intl.message(
      'We couldn’t find what you’re looking for.',
      name: 'couldntFind',
      desc: '',
      args: [],
    );
  }

  /// `You need to be signed in to use this feature.`
  String get needSign {
    return Intl.message(
      'You need to be signed in to use this feature.',
      name: 'needSign',
      desc: '',
      args: [],
    );
  }

  /// `Dose the CURRENT card match the card that came IMEDIATELY BEFORE it ?`
  String get doseThe {
    return Intl.message(
      'Dose the CURRENT card match the card that came IMEDIATELY BEFORE it ?',
      name: 'doseThe',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message(
      'You',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `Login success`
  String get success {
    return Intl.message(
      'Login success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact_ {
    return Intl.message(
      'Contact',
      name: 'contact_',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
