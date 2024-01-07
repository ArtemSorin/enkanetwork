import 'package:flutter/material.dart';

String getPropName(String propId) {
  const propNames = {
    'FIGHT_PROP_BASE_ATTACK': 'Base ATK',
    'FIGHT_PROP_HP': 'Flat HP',
    'FIGHT_PROP_ATTACK': 'Flat ATK',
    'FIGHT_PROP_DEFENSE': 'Flat DEF',
    'FIGHT_PROP_HP_PERCENT': 'HP%',
    'FIGHT_PROP_ATTACK_PERCENT': 'ATK%',
    'FIGHT_PROP_DEFENSE_PERCENT': 'DEF%',
    'FIGHT_PROP_CRITICAL': 'Crit RATE',
    'FIGHT_PROP_CRITICAL_HURT': 'Crit DMG',
    'FIGHT_PROP_CHARGE_EFFICIENCY': 'Energy Recharge',
    'FIGHT_PROP_HEAL_ADD': 'Healing Bonus',
    'FIGHT_PROP_ELEMENT_MASTERY': 'Elemental Mastery',
    'FIGHT_PROP_PHYSICAL_ADD_HURT': 'Physical DMG Bonus',
    'FIGHT_PROP_FIRE_ADD_HURT': 'Pyro DMG Bonus',
    'FIGHT_PROP_ELEC_ADD_HURT': 'Electro DMG Bonus',
    'FIGHT_PROP_WATER_ADD_HURT': 'Hydro DMG Bonus',
    'FIGHT_PROP_WIND_ADD_HURT': 'Anemo DMG Bonus',
    'FIGHT_PROP_ICE_ADD_HURT': 'Cryo DMG Bonus',
    'FIGHT_PROP_ROCK_ADD_HURT': 'Geo DMG Bonus',
    'FIGHT_PROP_GRASS_ADD_HURT': 'Dendro DMG Bonus',
  };
  return propNames[propId] ?? '';
}

Color getColor(String propId) {
  const propNames = {
    'Ice': Color.fromARGB(255, 94, 195, 242),
    'Electric': Colors.purple,
    'Wind': Colors.lightGreen,
    'Water': Colors.blue,
    'Fire': Colors.deepOrange,
    'Rock': Color.fromARGB(255, 163, 150, 32),
    'Grass': Colors.green,
  };
  return propNames[propId] ?? Colors.white;
}

String getServer(String propId) {
  const propNames = {
    '0': 'inside the miHoYo',
    '1': 'Mainland China',
    '2': 'Mainland China',
    '5': 'Mainland China (channels bilibili or Xiaomi)',
    '6': 'America',
    '7': 'Europe and Africa',
    '8': 'Asia and Australia',
    '9': 'Taiwan, Hong Kong and Macau',
  };
  return propNames[propId] ?? '';
}
