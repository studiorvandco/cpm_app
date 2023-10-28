import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navigation_projects => 'Projets';

  @override
  String get navigation_members => 'Membres';

  @override
  String get navigation_locations => 'Lieux';

  @override
  String get navigation_settings => 'Paramètres';

  @override
  String get login_username => 'Identifiant';

  @override
  String get login_password => 'Mot de passe';

  @override
  String get login_log_in => 'Se connecter';

  @override
  String get login_log_out => 'Se déconnecter';

  @override
  String projects_project(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Projets',
      one: 'Projet',
      zero: 'Aucun projet',
    );
    return '$_temp0';
  }

  @override
  String get projects_movie => 'Film';

  @override
  String get projects_series => 'Série';

  @override
  String projects_episode(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Épisodes',
      one: 'Épisode',
      zero: 'Aucun épisode',
    );
    return '$_temp0';
  }

  @override
  String projects_sequence(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Séquences',
      one: 'Séquences',
      zero: 'Aucune séquence',
    );
    return '$_temp0';
  }

  @override
  String projects_shot(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Plans',
      one: 'Plan',
      zero: 'Aucun plan',
    );
    return '$_temp0';
  }

  @override
  String projects_shots_value(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Valeurs',
      one: 'Valeur',
      zero: 'Aucune valeur',
    );
    return '$_temp0';
  }

  @override
  String get projects_shots_value_full => 'Moyen';

  @override
  String get projects_shots_value_medium_full => 'Italien';

  @override
  String get projects_shots_value_cowboy => 'Cowboy';

  @override
  String get projects_shots_value_medium => 'Américain';

  @override
  String get projects_shots_value_medium_closeup => 'Taille';

  @override
  String get projects_shots_value_closeup => 'Gros plan';

  @override
  String get projects_shots_value_extreme_closeup => 'Très gros plan';

  @override
  String get projects_shots_value_insert => 'Insert';

  @override
  String get projects_shots_value_sequence => 'Séquence';

  @override
  String get projects_shots_value_landscape => 'Paysage';

  @override
  String get projects_shots_value_drone => 'Drone';

  @override
  String get projects_shots_value_other => 'Autre';

  @override
  String get projects_links => 'Liens';

  @override
  String get projects_details => 'Détails';

  @override
  String get projects_no_title => 'Sans titre';

  @override
  String get projects_no_description => 'Aucune description';

  @override
  String get projects_no_dates => 'Pas de dates';

  @override
  String get projects_no_director => 'Aucun directeur';

  @override
  String get projects_no_writer => 'Aucun scénariste';

  @override
  String get projects_no_links => 'Aucun lien';

  @override
  String get schedule_schedule => 'Planning';

  @override
  String members_members(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Membres',
      one: 'Membre',
      zero: 'Aucun membre',
    );
    return '$_temp0';
  }

  @override
  String get members_call => 'Appeler';

  @override
  String get members_message => 'Envoyer un message';

  @override
  String locations_location(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lieux',
      one: 'Lieu',
      zero: 'Aucun lieu',
    );
    return '$_temp0';
  }

  @override
  String get location_map => 'Voir sur le carte';

  @override
  String get settings_account => 'Compte';

  @override
  String get settings_user => 'Utilisateur';

  @override
  String get settings_log_out => 'Se déconnecter';

  @override
  String settings_log_out_description(Object appName) {
    return 'Se déconnecter de $appName';
  }

  @override
  String get settings_appearance => 'Apparence';

  @override
  String get settings_theme => 'Thème';

  @override
  String get settings_theme_system => 'Système';

  @override
  String get settings_theme_light => 'Clair';

  @override
  String get settings_theme_dark => 'Sombre';

  @override
  String get settings_dynamic_theming => 'Thème dynamique';

  @override
  String get settings_dynamic_theming_description => 'Générer les couleurs depuis votre fond d\'écran';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_language_restart => 'Veuillez redémarrer l\'application pour que les changements s\'appliquent.';

  @override
  String get settings_about => 'À propos';

  @override
  String get settings_studiorvandco => 'Studio Rv & Co';

  @override
  String get settings_studiorvandco_description => 'Visiter notre site';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_github_description => 'Jeter un coup d\'œuil au code source';

  @override
  String get settings_licence => 'License';

  @override
  String get settings_licence_description => 'AGPL-3.0';

  @override
  String get button_add => 'Ajouter';

  @override
  String get button_edit => 'Éditer';

  @override
  String get button_delete => 'Supprimer';

  @override
  String get button_cancel => 'Annuler';

  @override
  String get menu_add => 'Ajouter';

  @override
  String get menu_open => 'Ouvrir';

  @override
  String get menu_move_up => 'Monter';

  @override
  String get menu_move_down => 'Descendre';

  @override
  String get menu_edit => 'Éditer';

  @override
  String get menu_delete => 'Supprimer';

  @override
  String get item_project => 'projet';

  @override
  String get item_episode => 'épisode';

  @override
  String get item_sequence => 'séquence';

  @override
  String get item_shot => 'plan';

  @override
  String get item_member => 'membre';

  @override
  String get item_location => 'lieu';

  @override
  String get dialog_log_out => 'Voulez-vous vraiment vous déconnecter?';

  @override
  String dialog_add_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Nouveau',
        'female': 'Nouvelle',
        'other': '',
      },
    );
    return '$_temp0 $item';
  }

  @override
  String dialog_edit_item(Object item) {
    return 'Éditer $item';
  }

  @override
  String dialog_delete_item_confirmation(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'ce',
        'female': 'cette',
        'other': '',
      },
    );
    return 'Voulez-vous vraiment supprimer $_temp0 $item ? Cette action est irréversible.';
  }

  @override
  String get dialog_field_title => 'Titre';

  @override
  String get dialog_field_description => 'Description';

  @override
  String get dialog_field_value => 'Valeur';

  @override
  String get dialog_field_label => 'Label';

  @override
  String get dialog_field_url => 'URL';

  @override
  String get dialog_field_first_name => 'Prénom';

  @override
  String get dialog_field_last_name => 'Nom';

  @override
  String get dialog_field_number => 'Numéro';

  @override
  String get dialog_field_position => 'Position';

  @override
  String snack_bar_add_success_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'ajouté',
        'female': 'ajoutée',
        'other': '',
      },
    );
    return '$_temp0 $item a été $_temp1 avec succès.';
  }

  @override
  String snack_bar_add_fail_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'ajouté',
        'female': 'ajoutée',
        'other': '',
      },
    );
    return '$_temp0 $item n\'a pas pu être $_temp1.';
  }

  @override
  String snack_bar_delete_success_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'supprimé',
        'female': 'supprimée',
        'other': '',
      },
    );
    return '$_temp0 $item a été $_temp1 avec succès.';
  }

  @override
  String snack_bar_delete_fail_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'supprimé',
        'female': 'supprimée',
        'other': '',
      },
    );
    return '$_temp0 $item n\'a pas pu être $_temp1.';
  }

  @override
  String snack_bar_edit_success_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'édité',
        'female': 'éditée',
        'other': '',
      },
    );
    return '$_temp0 $item a été $_temp1 avec succès.';
  }

  @override
  String snack_bar_edit_fail_item(Object item, String sex) {
    String _temp0 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'Le',
        'female': 'La',
        'other': '',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      sex,
      {
        'male': 'édité',
        'female': 'éditée',
        'other': '',
      },
    );
    return '$_temp0 $item n\'a pas pu être $_temp1.';
  }

  @override
  String get error_error => 'Erreur';

  @override
  String get error_login => 'Mauvais identifiant ou mot passe.';

  @override
  String get error_invalid_email => 'Email invalide';

  @override
  String get error_invalid_url => 'URL invalide';

  @override
  String get error_required => 'Requis';

  @override
  String get coming_soon => 'Prochainement disponible!';
}