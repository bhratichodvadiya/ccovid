import 'dart:convert';

class Appurl{

  static const String BaseUri = 'https://disease.sh/v3/covid-19/';


  // fetch world covid state
  static const String worldStateApi = BaseUri + 'all';
  static const String countrieslist = BaseUri + 'countries';

}