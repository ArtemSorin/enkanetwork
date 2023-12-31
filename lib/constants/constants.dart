import 'package:flutter/material.dart';

String getPropName(String propId) {
  const propNames = {
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
    'Ice': Colors.lightBlue,
    'Electric': Colors.purple,
    'Wind': Colors.lightGreen,
    'Water': Colors.blue,
    'Fire': Colors.deepOrange,
    'Rock': Colors.yellow,
    'Grass': Colors.green,
  };
  return propNames[propId] ?? Colors.white;
}
