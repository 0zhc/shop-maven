/*******************************************************************************
 * KindEditor - WYSIWYG HTML Editor for Internet
 * Copyright (C) 2006-2011 kindsoft.net
 *
 * @author Roddy <luolonghao@gmail.com>
 * @site http://www.kindsoft.net/
 * @licence http://www.kindsoft.net/license.php
 *******************************************************************************/

KindEditor.plugin('media', function (K) {
    var self = this, name = 'media', lang = self.lang(name + '.'),
        allowMediaUpload = K.undef(self.allowMediaUpload, true),
        allowFileManager = K.undef(self.allowFileManager, false),
        uploadJson = K.undef(self.uploadJson, self.basePath + 'php/upload_json.php');
    self.plugin.media = {
        edit: function () {
            var html = [
                '<div style="padding:10px 20px;">',
                //url
                '<div class="ke-dialog-row">',
                '<label for="keUrl" style="width:60px;">' + lang.url + '</label>',
                '<input class="ke-input-text" type="text" id="keUrl" name="url" value="" style="width:160px;" /> &nbsp;',
                '<input type="button" class="ke-upload-button" value="' + lang.upload + '" /> &nbsp;',
                '<span class="ke-button-common ke-button-outer">',
                '<input type="button" class="ke-button-common ke-button" name="viewServer" value="' + lang.viewServer + '" />',
                '</span>',
                '</div>',
                //width
                '<div class="ke-dialog-row">',
                '<label for="keWidth" style="width:60px;">' + lang.width + '</label>',
                '<input type="text" id="keWidth" class="ke-input-text ke-input-number" name="width" value="550" maxlength="4" />',
                '</div>',
                //height
                '<div class="ke-dialog-row">',
                '<label for="keHeight" style="width:60px;">' + lang.height + '</label>',
                '<input type="text" id="keHeight" class="ke-input-text ke-input-number" name="height" value="400" maxlength="4" />',
                '</div>',
                //autostart
                '<div class="ke-dialog-row">',
                '<label for="keAutostart">' + lang.autostart + '</label>',
                '<input type="checkbox" id="keAutostart" name="autostart" value="" /> ',
                '</div>',
                '</div>'
            ].join('');
            var dialog = self.createDialog({
                    name: name,
                    width: 450,
                    height: 230,
                    title: self.lang(name),
                    body: html,
                    yesBtn: {
                        name: self.lang('yes'),
                        click: function (e) {
                            var url = urlBox.val(),
                                html = K.mediaImg(self.themesPath + 'common/blank.gif', {
                                    src: url,
                                    type: K.mediaType(url),
                                    width: widthBox.val(),
                                    height: heightBox.val(),
                                    autostart: autostartBox[0].checked ? 'true' : 'false',
                                    loop: 'true'
                                });
                            self.insertHtml(html).hideDialog().focus();
                        }
                    }
                }),
                div = dialog.div,
                urlBox = K('[name="url"]', div),
                viewServerBtn = K('[name="viewServer"]', div),
                widthBox = K('[name="width"]', div),
                heightBox = K('[name="height"]', div),
                autostartBox = K('[name="autostart"]', div);
            urlBox.val('http://');

            if (allowMediaUpload) {
                var uploadbutton = K.uploadbutton({
                    button: K('.ke-upload-button', div)[0],
                    fieldName: 'imgFile',
                    url: uploadJson + '?dir=media',
                    afterUpload: function (data) {
                        if (data.error === 0) {
                            var url = K.formatUrl(data.url, 'absolute');
                            urlBox.val(url);
                            if (self.afterUpload) {
                                self.afterUpload.call(self, url);
                            }
                            alert(self.lang('uploadSuccess'));
                        } else {
                            alert(data.message);
                        }
                    }
                });
                uploadbutton.fileBox.change(function (e) {
                    uploadbutton.submit();
                });
            } else {
                K('.ke-upload-button', div).hide();
                urlBox.width(250);
            }

            if (allowFileManager) {
                viewServerBtn.click(function (e) {
                    self.loadPlugin('filemanager', function () {
                        self.plugin.filemanagerDialog({
                            viewType: 'LIST',
                            dirName: 'media',
                            clickFn: function (url, title) {
                                if (self.dialogs.length > 1) {
                                    K('[name="url"]', div).val(url);
                                    self.hideDialog();
                                }
                            }
                        });
                    });
                });
            } else {
                viewServerBtn.hide();
            }

            var img = self.plugin.getSelectedMedia();
            if (img) {
                var attrs = K.mediaAttrs(img.attr('data-ke-tag'));
                urlBox.val(attrs.src);
                widthBox.val(K.removeUnit(img.css('width')) || attrs.width || 0);
                heightBox.val(K.removeUnit(img.css('height')) || attrs.height || 0);
                autostartBox[0].checked = (attrs.autostart === 'true');
            }
            urlBox[0].focus();
            urlBox[0].select();
        },
        'delete': function () {
            self.plugin.getSelectedMedia().remove();
        }
    };
    self.clickToolbar(name, self.plugin.media.edit);
});
