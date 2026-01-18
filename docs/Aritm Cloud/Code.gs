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
  SpreadsheetApp.getUi().createMenu('Aritm Cloud').addItem('Öppna Aritm', 'showSidebar').addToUi();
}

function showSidebar() {
  var html = HtmlService.createHtmlOutputFromFile('Sidebar') // Här klistrar du in koden nedan
    .setTitle('Aritm Cloud')
    .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
  SpreadsheetApp.getUi().showSidebar(html);
}

// Dessa anropas av den smarta motorn i HTML-filen
function saveCloudSettings(s) { PropertiesService.getUserProperties().setProperty('settings', s); }
function loadCloudSettings() { return PropertiesService.getUserProperties().getProperty('settings'); }
function saveCloudProgress(p) { PropertiesService.getUserProperties().setProperty('progress', p); }
function loadCloudProgress() { return PropertiesService.getUserProperties().getProperty('progress'); }
function clearCloudProgress() { PropertiesService.getUserProperties().deleteProperty('progress'); }
