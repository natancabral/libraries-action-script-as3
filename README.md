[<img src="https://rawgit.com/hgupta9/awesome-actionscript3/master/AS3_AIR.png" align="right" width="150">](https://www.adobe.com/products/air.html)

# Libraries NC ActionScript 3 [![Awesome](https://raw.githubusercontent.com/natancabral/libraries-action-script-as3/main/badge-awesome.svg)](https://github.com/natancabral/libraries-action-script-as3)

> A curated list of awesome libraries and components for ActionScript 3 and Adobe AIR.

[Adobe AIR](https://en.wikipedia.org/wiki/Adobe_AIR) provides a single set of APIs to build cross-platform desktop/mobile applications and games. [ActionScript 3](https://en.wikipedia.org/wiki/ActionScript) is the programming language for AIR. Powerful native functionality such as file system, SQLite, sensors are included by default. To add missing functionality, you can build ANEs (Air Native Extensions) coded in the native language (eg VC++ for Windows, Java for Android, Swift/Objective-C for iOS). To build mobile apps/games with GPU-rendered graphics, use the [Starling](https://gamua.com/starling/) framework and optionally the [Feathers UI](https://feathersui.com/). Adobe AIR is very popular in the mobile gaming space.

## Code

```as
package com.example
{
    import flash.text.TextField;
    import flash.display.Sprite;

    public class Greeter extends Sprite
    {
        public function Greeter()
        {
            var txtHello: TextField = new TextField();
            txtHello.text = "Hello World";
            addParent3(txtHello);
        }
    }
}
```

# Tree 

```txt
├── application
│   ├── ExtendedNativeWindow.as
│   ├── ExtendedNativeWindowOptions.as
│   ├── gnncApp
│   ├── gnncAppIcons.as
│   ├── gnncAppIconTray.as
│   ├── gnncApplication.as
│   ├── gnncAppNetConnect.as
│   ├── gnncAppOS.as
│   ├── gnncAppResize.as
│   ├── gnncAppUpdateRuntime.as
│   ├── gnncAppWindow.as
│   ├── image
│   │   └── resize-16.png
│   └── UI
├── audio
│   ├── gnncAudio.as
│   └── micrecorder
│       ├── encoder
│       │   ├── WaveEncoder.as
│       │   └── wavSound
│       │       ├── sazameki
│       │       │   ├── core
│       │       │   │   ├── AudioSamples.as
│       │       │   │   └── AudioSetting.as
│       │       │   └── format
│       │       │       ├── riff
│       │       │       │   ├── Chunk.as
│       │       │       │   ├── LIST.as
│       │       │       │   └── RIFF.as
│       │       │       └── wav
│       │       │           ├── chunk
│       │       │           │   ├── WavdataChunk.as
│       │       │           │   └── WavfmtChunk.as
│       │       │           └── Wav.as
│       │       ├── WavSound.as
│       │       ├── WavSoundChannel.as
│       │       ├── WavSoundPlayer.as
│       │       └── WavToMp3.as
│       ├── events
│       │   └── RecordingEvent.as
│       ├── IEncoder.as
│       └── MicRecorder.as
├── data
│   ├── bitmap
│   │   ├── DAYBYDAY_BITMAP_3D
│   │   ├── gnncBitmap.as
│   │   ├── gnncBitmapDraw2.as
│   │   ├── gnncBitmapDraw.as
│   │   ├── gnncBitmapGif.as
│   │   ├── gnncBitmapScale.as
│   │   ├── image
│   │   │   └── hand.gif
│   │   └── NonTransparentPNGEncoder.as
│   ├── collection
│   │   ├── HashMapCollection.as
│   │   ├── HashMapManager.as
│   │   └── IMap.as
│   ├── conn
│   │   ├── gnncAmfPhp3.as
│   │   ├── gnncAMFPhp3Config.as
│   │   ├── gnncAMFPhp.as
│   │   ├── gnncCrypt.as
│   │   └── xml
│   │       ├── instruction.txt
│   │       └── services-config.xml
│   ├── data
│   │   ├── gnncClipBoard.as
│   │   ├── gnncDataArray.as
│   │   ├── gnncDataArrayCollection.as
│   │   ├── gnncData.as
│   │   ├── gnncDataBindable.as
│   │   ├── gnncDataHtml.as
│   │   ├── gnncDataHtmlStyles.txt
│   │   ├── gnncDataNumber.as
│   │   ├── gnncDataNumberConvert.as
│   │   ├── gnncDataObject.as
│   │   ├── gnncDataRand.as
│   │   ├── gnncDataRegExp.as
│   │   ├── gnncDataUpdateItens.as
│   │   ├── gnncDataVector.as
│   │   ├── gnncDataXml.as
│   │   └── json
│   │       ├── gnncJSON.as
│   │       ├── gnncJSONDecoder.as
│   │       ├── gnncJSONEncoder.as
│   │       ├── gnncJSONParseError.as
│   │       ├── gnncJSONToken.as
│   │       ├── gnncJSONTokenizer.as
│   │       └── gnncJSONTokenType.as
│   ├── date
│   │   ├── BusinessDay.as
│   │   ├── DateUtils.as
│   │   ├── DaylightSavingTimeUS.as
│   │   ├── gnncDate.as
│   │   └── Holiday.as
│   ├── element
│   │   └── gnncElement.as
│   ├── encrypt
│   │   ├── gnncEncryptKey.as
│   │   ├── gnncHMAC.as
│   │   ├── gnncIntUtil.as
│   │   ├── gnncMD5.as
│   │   ├── gnncMD5Stream.as
│   │   ├── gnncSHA1.as
│   │   ├── gnncSHA224.as
│   │   ├── gnncSHA256.as
│   │   └── gnncWSSEUsernameToken.as
│   ├── file
│   │   ├── gnncFileCookie.as
│   │   ├── gnncFileCsv.as
│   │   ├── gnncFileMimeType.as
│   │   ├── gnncFilePdf.as
│   │   ├── gnncFileReport.as
│   │   ├── gnncFilesInative.as
│   │   ├── gnncFilesNative.as
│   │   ├── gnncFileSqlLite2.as
│   │   ├── gnncFileSqlLite.as
│   │   ├── gnncFilesRemote.as
│   │   ├── gnncFileUpload.as
│   │   ├── gnncFileXml.as
│   │   ├── image
│   │   │   ├── bgh.jpg
│   │   │   ├── bgh.png
│   │   │   ├── bgv.jpg
│   │   │   ├── bgv.png
│   │   │   └── gnnc.jpg
│   │   └── itemRender
│   │       └── itemRender_files_forList.mxml
│   ├── globals
│   │   ├── gnncGlobalArrays.as
│   │   ├── gnncGlobalLog.as
│   │   ├── gnncGlobalStatic.as
│   │   └── gnncGlobalStaticProjects.as
│   ├── mailer
│   │   └── gnncMailer.as
│   ├── permission
│   │   ├── gnncPermission.as
│   │   ├── gnncPermissionSet.as
│   │   └── image
│   │       ├── access-32-unlock.png
│   │       ├── shield-16.png
│   │       ├── shield-32.png
│   │       └── shield-48.png
│   ├── securityService
│   │   ├── gnncSecurityDate.as
│   │   ├── gnncSecurityService.as
│   │   ├── gnncSecurityService.new.txt
│   │   ├── gnncSecurityUserLogin.as
│   │   └── gnncSocket.as
│   ├── sql
│   │   ├── gnncSql.as
│   │   ├── gnncSqlCreation.as
│   │   ├── gnncSqlModel.as
│   │   └── gnncSqlTable.as
│   ├── validator
│   │   ├── gnncValidatorCnpj.as
│   │   ├── gnncValidatorCpf.as
│   │   ├── gnncValidatorPhoneBr.as
│   │   └── gnncValidatorRg.as
│   ├── vCard
│   │   ├── gnncDataVCard.as
│   │   ├── vCardAddress.as
│   │   ├── vCardData.as
│   │   ├── vCardEmail.as
│   │   └── vCardPhone.as
│   └── zip
│       └── gnncZip.as
├── daybyday
│   ├── educ
│   └── money
│       └── gnncMoneyFinancialAccount.as
├── document
├── elements
│   ├── component
│   │   ├── list
│   │   │   ├── back
│   │   │   │   ├── conList_attach.mxml
│   │   │   │   └── conList_comment.mxml
│   │   │   ├── conList_attach.as
│   │   │   ├── conList_class.as
│   │   │   ├── conList_client.as
│   │   │   ├── conList_clientTeam.as
│   │   │   ├── conList_comment.as
│   │   │   ├── conList_contact.as
│   │   │   ├── conList_financial.as
│   │   │   ├── conList_financial_overDraft.as
│   │   │   ├── conList_formModel.as
│   │   │   ├── conList_job.as
│   │   │   ├── conList_.mxml
│   │   │   ├── conList_product.as
│   │   │   ├── conList_project.as
│   │   │   ├── conList_report.as
│   │   │   ├── conList_step.as
│   │   │   ├── conList_webMenuLink.as
│   │   │   └── conList_webPage.as
│   │   ├── plus
│   │   │   └── conPlus_job.mxml
│   │   ├── select
│   │   │   ├── conColor.mxml
│   │   │   ├── conDateButton.mxml
│   │   │   ├── conDateCalendar.mxml
│   │   │   ├── conSelectButton_client.mxml
│   │   │   ├── conSelect_CATEGORY.mxml
│   │   │   ├── conSelect_CLIENT.mxml
│   │   │   ├── conSelect_COLOR.mxml
│   │   │   ├── conSelect_DEPARTAMENT.mxml
│   │   │   ├── conSelect_GROUP.mxml
│   │   │   ├── conSelect_PERCENT.mxml
│   │   │   ├── conSelect_PRODUCT.mxml
│   │   │   ├── conSelect_SERIES.mxml
│   │   │   ├── conSelect_STATUS.mxml
│   │   │   ├── itemRender
│   │   │   │   └── itemRender_color_forList.mxml
│   │   │   └── report
│   │   │       └── gnncFileReport_series.as
│   │   └── series
│   │       └── conNewSeries_class.mxml
│   └── other
├── event
│   ├── gnncCloseEvent.as
│   ├── gnncEventGeneral.as
│   └── gnncUncaughtErrorEvent.as
├── keyboard
│   ├── gnncKeyboard.as
│   ├── gnncKeyboardCommand.as
│   └── gnncKeyboardPaste.as
├── main
│   ├── gnncMain.as
│   ├── gnncStartAIR.as
│   ├── gnncStart.as
│   ├── gnncStartStyle.as
│   └── gnncStartValues.as
├── modules
│   ├── attach
│   │   ├── formNew
│   │   │   ├── newAttach.mxml
│   │   │   └── selectAttach.mxml
│   │   ├── formView
│   │   │   └── viewAttach.mxml
│   │   ├── itemRender
│   │   │   ├── itemRender_attach_forList.mxml
│   │   │   ├── itemRender_attach_icons_forList.mxml
│   │   │   ├── itemRender_attachPhoto_forList.mxml
│   │   │   └── itemRender_attachSelect_forList.mxml
│   │   ├── moduleFinancialGroup_attach.mxml
│   │   └── report
│   ├── calendar
│   │   ├── formNew
│   │   │   ├── newCalendar.mxml
│   │   │   └── newCalendarProcessOdonto.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   ├── itemRender_calendarDayForMonth_forGroup.mxml
│   │   │   └── itemRender_calendar_forList.mxml
│   │   ├── moduleCalendar.mxml
│   │   └── report
│   ├── category
│   │   ├── formNew
│   │   │   └── newCategory.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── client
│   │   ├── formNew
│   │   │   ├── newClient.mxml
│   │   │   ├── newClientQuick.mxml
│   │   │   └── selectClient.mxml
│   │   ├── formView
│   │   │   └── viewClient.mxml
│   │   ├── itemRender
│   │   │   ├── itemRender_client_forList.mxml
│   │   │   ├── itemRender_clientName_forList.mxml
│   │   │   ├── itemRender_clientPhoto_forList.mxml
│   │   │   └── itemRender_clientSimpleList_forList.mxml
│   │   └── report
│   │       ├── gnncFileReport_client_inListSimple.as
│   │       └── gnncFileReport_client_viewClient.as
│   ├── color
│   │   ├── formNew
│   │   │   └── NEW_COLOR.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── course
│   │   ├── formNew
│   │   │   ├── newCourse.mxml
│   │   │   └── selectCourse.mxml
│   │   ├── formView
│   │   ├── image
│   │   │   ├── cloud16.png
│   │   │   ├── cloud32.png
│   │   │   ├── moon16.png
│   │   │   ├── moon32.png
│   │   │   ├── sun16.png
│   │   │   ├── sun16v2.png
│   │   │   ├── sun32.png
│   │   │   └── sun32v2.png
│   │   ├── itemRender
│   │   │   ├── itemRender_courseParcel_forList.mxml
│   │   │   ├── itemRender_courseStudent_forList.mxml
│   │   │   ├── itemRender_courseTeacher_forList.mxml
│   │   │   ├── itemRender_cronList_forList.mxml
│   │   │   ├── itemRender_disciplineList_forList.mxml
│   │   │   └── itemRender_frequencyList_forList.mxml
│   │   └── report
│   ├── departament
│   │   ├── formNew
│   │   │   └── newDepartament.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── document
│   │   ├── formNew
│   │   │   ├── newDocumentLabel.mxml
│   │   │   └── newFormModel.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   └── itemRender_formModel_forList.mxml
│   │   └── report
│   ├── education
│   │   ├── formNew
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── financial
│   │   ├── formNew
│   │   │   ├── newFinancial.mxml
│   │   │   ├── newFinancialOverDraft.mxml
│   │   │   └── newFinancialPay.mxml
│   │   ├── formView
│   │   │   └── viewFinancial.mxml
│   │   ├── itemRender
│   │   │   ├── itemRender_financialAccountBox_forList.mxml
│   │   │   ├── itemRender_financialAccount_forList.mxml
│   │   │   ├── itemRender_financial_clean_forList.mxml
│   │   │   ├── itemRender_financial_forList.mxml
│   │   │   ├── itemRender_financialOverDraft_forList.mxml
│   │   │   ├── itemRender_financialPayFlagCard_forList.mxml
│   │   │   └── itemRender_financialPayType_forList.mxml
│   │   └── report
│   ├── group
│   │   ├── formNew
│   │   │   └── newGroup.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── note
│   │   ├── formNew
│   │   │   └── newNote.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   └── itemRender_noteBlock_forList.mxml
│   │   └── report
│   ├── product
│   │   ├── formNew
│   │   │   ├── newProduct.mxml
│   │   │   ├── newProductStockLot.mxml
│   │   │   ├── newProductStockLotProduction.mxml
│   │   │   ├── newProductStock.mxml
│   │   │   ├── newProductStockOS.mxml
│   │   │   └── newProductStockOS_out.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   ├── itemRender_product_forList.mxml
│   │   │   ├── itemRender_productStock_forList.mxml
│   │   │   ├── itemRender_productStockLot_forList.mxml
│   │   │   ├── itemRender_productStockLotProduction_forList.mxml
│   │   │   ├── itemRender_productStockOs_forList.mxml
│   │   │   └── itemRender_productStockOs_out_forList.mxml
│   │   └── report
│   ├── project
│   │   ├── formNew
│   │   │   ├── newComment.mxml
│   │   │   ├── newJobHierarchy.mxml
│   │   │   ├── newJob.mxml
│   │   │   └── newProject.mxml
│   │   ├── formView
│   │   │   ├── viewComment.mxml
│   │   │   ├── viewJobBack.mxml
│   │   │   ├── viewJobCompact.mxml
│   │   │   └── viewJob.mxml
│   │   ├── itemRender
│   │   │   ├── itemRender_comment_forList.mxml
│   │   │   ├── itemRender_contactList_forList.mxml
│   │   │   ├── itemRender_course_forList.mxml
│   │   │   ├── itemRender_jobBox_forList.mxml
│   │   │   ├── itemRender_jobList_forList.mxml
│   │   │   ├── itemRender_Project_clientTeam_forList.mxml
│   │   │   ├── itemRender_Project_Comment_forList.mxml
│   │   │   ├── itemRender_projectList_forList.mxml
│   │   │   └── itemRender_reportList_forList.mxml
│   │   └── report
│   ├── series
│   │   ├── formNew
│   │   │   └── newSeries.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── setting
│   │   ├── formNew
│   │   ├── formView
│   │   ├── itemRender
│   │   └── report
│   ├── step
│   │   ├── formNew
│   │   │   └── newStep.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   ├── itemRender_stepList_forList.mxml
│   │   │   └── itemRender_stepList_withDate_forList.mxml
│   │   └── report
│   ├── user
│   │   ├── formNew
│   │   │   ├── CopyofnewPermissionHost.mxml
│   │   │   ├── newFinancialSellerCommission.mxml
│   │   │   ├── newPermissionHost.mxml
│   │   │   └── newUserLogin.mxml
│   │   ├── formView
│   │   ├── itemRender
│   │   │   ├── itemRender_letter_forList.mxml
│   │   │   ├── itemRender_permission_forList.mxml
│   │   │   ├── itemRender_permissionHost_forList.mxml
│   │   │   ├── itemRender_permissionModule_forList.mxml
│   │   │   └── itemRender_user_forList.mxml
│   │   ├── moduleClientNew.mxml
│   │   ├── moduleClientReport.mxml
│   │   ├── moduleClientSeller.mxml
│   │   ├── moduleClientUserNew.mxml
│   │   ├── report
│   │   └── sql
│   └── web
│       ├── formNew
│       │   ├── newWebMenuLink.mxml
│       │   ├── newWebMenuLocation.mxml
│       │   ├── newWebPage.mxml
│       │   ├── newWebSettings.mxml
│       │   └── newWebTable.mxml
│       ├── formView
│       ├── itemRender
│       │   ├── itemRender_webMenuLink_forList.mxml
│       │   └── itemRender_webPage_forList.mxml
│       └── report
├── mouse
│   ├── gnncMouseIncludeDisplayObject.as
│   └── gnncMousePoint.as
├── others
│   ├── gnncFocus.as
│   ├── gnncScrollPosition.as
│   ├── gnncToolTip.as
│   ├── gnncUpdateItemList.as
│   ├── gnncUrlNavegator.as
│   └── gnncViewStackCommand.as
├── skin
│   ├── accordion
│   │   └── skin_accordion_header.mxml
│   ├── button
│   │   ├── skin_buttonBack.mxml
│   │   ├── skin_buttonBlue.mxml
│   │   ├── skin_buttonGreen.mxml
│   │   ├── skin_buttonLink.mxml
│   │   ├── skin_button.mxml
│   │   └── skin_buttonTextLeft.mxml
│   ├── buttonBar
│   │   ├── skin_ButtonBar2.mxml
│   │   ├── skin_buttonBar3.mxml
│   │   ├── skin_buttonBarButton3.mxml
│   │   ├── skin_buttonBarButton.mxml
│   │   └── skin_buttonBar.mxml
│   ├── checkBox
│   │   ├── skin_checkBoxGreen.mxml
│   │   └── skin_checkBox.mxml
│   ├── comboBox
│   │   ├── skin_comboBox2.mxml
│   │   └── skin_comboBox.mxml
│   ├── datagrid
│   │   ├── skin_datagridHeaderMX.mxml
│   │   └── skin_datagrid.mxml
│   ├── dateField
│   │   ├── image
│   │   │   └── calendar-16.png
│   │   └── other
│   ├── dropDownList
│   │   ├── itemRender
│   │   │   ├── itemRender_hierarchy_forList.mxml
│   │   │   ├── itemRender_hierarchyWithTitle_forList.mxml
│   │   │   └── itemRender_label_forList.mxml
│   │   └── skin_dropDownList.mxml
│   ├── form
│   │   └── skin_formItem.mxml
│   ├── hSlider
│   │   ├── skin_hSliderIcon.mxml
│   │   └── skin_hSliderIconSkin.mxml
│   ├── list
│   │   └── skin_list.mxml
│   ├── mxScroller
│   │   ├── mxScrollBarDownButtonSkin.mxml
│   │   ├── mxScrollBarUpButtonSkin.mxml
│   │   ├── mxVScrollBarThumbSkin.mxml
│   │   ├── mxVScrollBarTrackSkin.mxml
│   │   ├── xCustomScroller.mxml
│   │   ├── xSparkSkinScrollBar.mxml
│   │   └── xVScrollBarSkin.mxml
│   ├── scroller
│   │   ├── skin_hScrollBar.mxml
│   │   ├── skin_hScrollBar_v1.mxml
│   │   ├── skin_hScrollerThumb.mxml
│   │   ├── skin_hScrollerTrack.mxml
│   │   ├── skin_scroller.mxml
│   │   ├── skin_scroller_v1.mxml
│   │   ├── skin_vScrollBar.mxml
│   │   ├── skin_vScrollBar_v1.mxml
│   │   ├── skin_vScrollerThumbDown.mxml
│   │   ├── skin_vScrollerThumbDown_v1.mxml
│   │   ├── skin_vScrollerThumb.mxml
│   │   ├── skin_vScrollerThumbUp.mxml
│   │   ├── skin_vScrollerThumbUp_v1.mxml
│   │   ├── skin_vScrollerThumb_v1.mxml
│   │   ├── skin_vScrollerTrack.mxml
│   │   └── skin_vScrollerTrack_v1.mxml
│   ├── tabBar
│   │   ├── image
│   │   │   ├── menu-v1-over.png
│   │   │   ├── menu-v1-selected.png
│   │   │   ├── menuWhite-v1-over.png
│   │   │   └── menuWhite-v1-selected.png
│   │   ├── skin_tabBar_default_buttonBarButton.mxml
│   │   ├── skin_tabBar_default.mxml
│   │   ├── skin_tabBar_forMenu_buttonBarButton.mxml
│   │   ├── skin_tabBar_forMenu.mxml
│   │   ├── skin_tabBar_forMenuWhite_buttonBarButton.mxml
│   │   ├── skin_tabBar_forMenuWhite.mxml
│   │   ├── skin_tabBar_vertical_buttonBarButton.mxml
│   │   └── skin_tabBar_vertical.mxml
│   └── toggleButton
│       ├── skin_toggleButtonBack.mxml
│       ├── skin_toggleButtonForSelectionBack.mxml
│       ├── skin_toggleButtonForSelection.mxml
│       ├── skin_toggleButton.mxml
│       └── skin_toggleButtonTextLeft.mxml
├── sqlTables
│   ├── table_.as
│   ├── table_attach.as
│   ├── table_attach_group.as
│   ├── table_calendar.as
│   ├── table_category.as
│   ├── table_cep_address.as
│   ├── table_cep_city.as
│   ├── table_cep_country.as
│   ├── table_cep_neighborhood.as
│   ├── table_cep_state.as
│   ├── table_client.as
│   ├── table_client_employee.as
│   ├── table_comment.as
│   ├── table_contact.as
│   ├── table_contract.as
│   ├── table_course.as
│   ├── table_course_discipline.as
│   ├── table_course_frequency.as
│   ├── table_course_grade.as
│   ├── table_course_parcel.as
│   ├── table_course_parcel_pay.as
│   ├── table_course_student.as
│   ├── table_course_teacher.as
│   ├── table_data_json.as
│   ├── table_departament.as
│   ├── table_financial_account.as
│   ├── table_financial.as
│   ├── table_financial_book.as
│   ├── table_financial_future.as
│   ├── table_financial_overdraft.as
│   ├── table_financial_seller.as
│   ├── table_financial_seller_commission.as
│   ├── table_form_model.as
│   ├── table_group.as
│   ├── table_job.as
│   ├── table_log.as
│   ├── table_login.as
│   ├── table_mail.as
│   ├── table_note.as
│   ├── table_online.as
│   ├── table_permission.as
│   ├── table_permission_set.as
│   ├── table_process_calendar.as
│   ├── table_product.as
│   ├── table_product_group.as
│   ├── table_product_stock.as
│   ├── table_product_stock_lot.as
│   ├── table_product_stock_lot_prodution.as
│   ├── table_product_stock_os.as
│   ├── table_product_stock_out.as
│   ├── table_project.as
│   ├── table_project_team.as
│   ├── table_report.as
│   ├── table_sad_answer.as
│   ├── table_sad_ask.as
│   ├── table_series.as
│   ├── table_settings.as
│   ├── table_sql.as
│   ├── table_star.as
│   ├── table_step.as
│   ├── table_web_menu_link.as
│   ├── table_web_menu_location.as
│   ├── table_web_page.as
│   └── table_web_table.as
├── system
│   ├── gnncMemonyEventListener.as
│   ├── gnncMemory.as
│   └── gnncParent.as
├── time
│   ├── DeferredFunctionCall.as
│   ├── gnncFunctions.as
│   └── gnncTime.as
└── UI
    ├── components
    │   ├── componentLoadingBoxText.mxml
    │   └── componentProjectCommentJonAndDiscussion.mxml
    ├── elements
    │   ├── elementBarGray.mxml
    │   ├── elementBarStatus.mxml
    │   ├── elementHDropShadow.mxml
    │   ├── elementHLine.mxml
    │   ├── elementInput.mxml
    │   ├── elementInputSearch.mxml
    │   ├── elementLabelBackgroudColor.mxml
    │   ├── elementlabelCalendar.mxml
    │   ├── elementLabelDropShadow.mxml
    │   ├── elementLabelFont.mxml
    │   ├── elementLoading.mxml
    │   ├── elementMenuMain.mxml
    │   ├── elementPanelSimple.mxml
    │   ├── elementStageBox.mxml
    │   ├── elementStageBoxPopUp.mxml
    │   ├── elementStageGeneral.mxml
    │   ├── elementStageGeneralWhiteFit.mxml
    │   ├── elementStageGeneralWhite.mxml
    │   ├── elementVDropShadow.mxml
    │   ├── elementVLine.mxml
    │   ├── icon
    │   │   ├── icon_directionDown.mxml
    │   │   ├── icon_directionLeft.mxml
    │   │   ├── icon_directionRight.mxml
    │   │   ├── icon_directionUp.mxml
    │   │   └── icon_search.mxml
    │   ├── image
    │   │   ├── filter-16.png
    │   │   └── refresh-16.png
    │   └── itemRender
    │       └── itemRender_menu_forTree.mxml
    ├── gnncAlert
    │   ├── gnncAlert.as
    │   └── gnncAlertEvent.as
    ├── gnncBook
    │   ├── book
    │   │   ├── Book.as
    │   │   ├── BookError.as
    │   │   ├── BookEvent.as
    │   │   ├── Gradients.as
    │   │   ├── limited.as
    │   │   ├── Page.as
    │   │   └── PageManager.as
    │   ├── containers
    │   │   └── SuperViewStack.as
    │   ├── drawing
    │   │   ├── DrawingTool.as
    │   │   └── LineStyle.as
    │   ├── geom
    │   │   ├── Geom.as
    │   │   ├── InfiniteLine.as
    │   │   ├── Line.as
    │   │   ├── SuperPoint.as
    │   │   └── SuperRectangle.as
    │   ├── managers
    │   │   └── StateManager.as
    │   ├── pageflip
    │   │   ├── DistortImage.as
    │   │   └── PageFlip.as
    │   ├── style
    │   │   └── book.css
    │   └── utils
    │       ├── ArrayTool.as
    │       ├── ChildTool.as
    │       └── MathTool.as
    ├── gnncComboCheck
    │   ├── ComboCheck.as
    │   ├── ComboCheckBoxSkin.mxml
    │   ├── ComboCheckEvent.as
    │   ├── ComboCheckItemRenderer.mxml
    │   ├── ComboCheckList.as
    │   ├── ComboCheckListSkin.mxml
    │   ├── ComboCheckSkin.mxml
    │   ├── gnncComboCheckBox.as
    │   ├── IComboCheck.as
    │   └── IComboCheckType.as
    ├── gnncDateButton
    │   └── gnncDateButton.mxml
    ├── gnncDateField4
    │   ├── controls
    │   ├── events
    │   │   └── ItemEditEvent.as
    │   ├── gnncDateField4.as
    │   ├── image
    │   │   └── calendar-16.png
    │   ├── utils
    │   │   └── DateUtil.as
    │   └── validators
    │       └── DateI18nValidator.as
    ├── gnncDaybyday
    │   ├── gnncLogo
    │   │   └── gnncLogoSystem.as
    │   ├── gnncSetting
    │   │   ├── gnncPermissionSetValues.mxml
    │   │   ├── gnncSetting.mxml
    │   │   ├── gnncSettingValues.mxml
    │   │   └── image
    │   │       ├── edit-16.png
    │   │       └── user-128.png
    │   └── gnncUserLogin
    │       ├── gnncUserLogin.mxml
    │       └── image
    │           ├── access-16.png
    │           └── setting-16.png
    ├── gnncDropDownList
    │   └── gnncDropDownList.mxml
    ├── gnncFxgConverter
    │   ├── FXGStringConverter.as
    │   └── SupportedClassesAndProperties.as
    ├── gnncImage
    │   ├── gnncImageCD.mxml
    │   └── gnncImageProgress.as
    ├── gnncImport
    │   └── gnncImport.mxml
    ├── gnncList
    │   └── gnncList.as
    ├── gnncLoading
    │   └── gnncLoading.mxml
    ├── gnncMenuRight
    │   └── gnncMenuRight.as
    ├── gnncNotification
    │   ├── event
    │   │   └── gnncNotificationEvent.as
    │   ├── gnncNotification.as
    │   ├── gnncNotificationConst.as
    │   ├── gnncNotificationManager.as
    │   ├── gnncNotificationValues.as
    │   ├── sound
    │   │   └── drop.mp3
    │   └── ui
    │       └── gnncNotificationWindow.mxml
    ├── gnncPaint
    │   ├── ControlPanel.mxml
    │   ├── DrawingCanvasElement.as
    │   ├── DrawingStateChangeEvent.as
    │   └── ShaperlyNew.mxml
    ├── gnncPopUp
    │   └── gnncPopUp.as
    ├── gnncPreloader
    │   ├── gnncLoadScreen.as
    │   ├── gnncPreloader.as
    │   └── image
    │       ├── splash2012.gif
    │       └── splash2012.png
    ├── gnncSettingAir
    │   └── gnncSettingAIR.mxml
    ├── gnncShape
    │   └── gnncShape.as
    ├── gnncTextEdit
    │   ├── gnncTextEditHtml.mxml
    │   ├── gnncTextEdit.mxml
    │   ├── gnncTextFlowUtils.as
    │   └── images
    │       ├── 2text-align-c-16.png
    │       ├── 2text-align-j-16.png
    │       ├── 2text-align-l-16.png
    │       ├── 2text-align-r-16.png
    │       ├── insert-image-16.png
    │       ├── lowercase.png
    │       ├── text-align-c-16.png
    │       ├── text-align-j-16.png
    │       ├── text-align-l-16.png
    │       ├── text-align-r-16.png
    │       ├── text-code-16.png
    │       └── uppercase.png
    ├── gnncTextInputMasked
    │   ├── gnncTextInputMasked.as
    │   └── MTISkin.as
    ├── gnncVideo
    │   ├── gnncVideoYoutube.as
    │   └── gnncVideoYoutubeEvents.as
    ├── gnncView
    │   ├── gnncViewHtml.as
    │   └── gnncViewImage.as
    └── gnncViewStack
        └── gnncViewStack.as

```
