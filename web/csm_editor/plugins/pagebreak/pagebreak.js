/*******************************************************************************
 * KindEditor - WYSIWYG HTML Editor for Internet
 * Copyright (C) 2006-2011 kindsoft.net
 *
 * @author Roddy <luolonghao@gmail.com>
 * @site http://www.kindsoft.net/
 * @licence http://www.kindsoft.net/license.php
 *******************************************************************************/

KindEditor.plugin('pagebreak', function (K) {
    var self = this, name = 'pagebreak';
    self.clickToolbar(name, function () {
        var cmd = self.cmd, range = cmd.range;
        self.focus();
        range.enlarge(true);
        cmd.split(true);
        var tail = self.newlineTag == 'br' ? '' : '<p id="__kindeditor_tail_tag__"></p>';
        self.insertHtml('<hr class="ke-pagebreak" style="page-break-after: always;" />' + tail);
        if (self.newlineTag != 'br') {
            var p = K('#__kindeditor_tail_tag__', self.edit.doc);
            range.selectNodeContents(p[0]);
            p.removeAttr('id');
            cmd.select();
        }
    });
});
