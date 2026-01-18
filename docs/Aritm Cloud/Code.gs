/**
 * Aritm Cloud - Backend (Google Apps Script)
 * Copyright (C) 2026 Mikael O. Bonnier, Lund, Sweden. 
 * * Detta program är fri programvara. Du kan distribuera det och/eller modifiera 
 * det under villkoren i GNU General Public License, version 3 eller senare, 
 * enligt vad som publicerats av Free Software Foundation.
 * * Se: https://www.gnu.org/licenses/gpl-3.0.html
 * * @OnlyCurrentDoc
 */

function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu('Aritm Cloud')
    .addItem('Öppna Aritm', 'showSidebar')
    .addToUi();
}

function showSidebar() {
  var html = HtmlService.createHtmlOutputFromFile('Sidebar')
    .setTitle('Aritm Cloud')
    .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
  SpreadsheetApp.getUi().showSidebar(html);
}

// Ersätter LocalStorage för inställningar
function saveCloudSettings(settingsJson) {
  var userProperties = PropertiesService.getUserProperties();
  userProperties.setProperty('aritm_cloud_settings', settingsJson);
}

function loadCloudSettings() {
  var userProperties = PropertiesService.getUserProperties();
  return userProperties.getProperty('aritm_cloud_settings');
}

// Ersätter LocalStorage för pågående spel (Session)
function saveCloudProgress(progressJson) {
  var userProperties = PropertiesService.getUserProperties();
  userProperties.setProperty('aritm_cloud_save_v1', progressJson);
}

function loadCloudProgress() {
  var userProperties = PropertiesService.getUserProperties();
  return userProperties.getProperty('aritm_cloud_save_v1');
}

function clearCloudProgress() {
  var userProperties = PropertiesService.getUserProperties();
  userProperties.deleteProperty('aritm_cloud_save_v1');
}
