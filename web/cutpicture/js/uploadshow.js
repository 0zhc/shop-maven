function onUploadImgChange(sender) {

    if (!sender.value.match(/.jpg|.gif/i)) {
        alert('ͼƬ��ʽ��Ч��');
        return false;
    }
    var objPreview = document.getElementById('preview');
    var objPreviewFake = document.getElementById('preview_fake');
    var objPreviewSizeFake = document.getElementById('preview_size_fake');
    if (sender.files && sender.files[0]) {
        objPreview.style.display = 'block';
        objPreview.style.width = 'auto';
        objPreview.style.height = 'auto';

        // Firefox ��ȫ���������޷�ֱ��ͨ�� input[file].value ��ȡ�������ļ�·��   
        objPreview.src = sender.files[0].getAsDataURL();
    } else if (objPreviewFake.filters) {
        // IE7,IE8 �����ñ���ͼƬ��ַΪ img.src ʱ����Ī������ĺ��   
        //����ͬ������ʱ����ʾ����ʱ����ʾ�������ֻ�����˾������   

        // IE7, IE8��ȫ���������޷�ֱ��ͨ�� input[file].value ��ȡ�������ļ�·��   
        sender.select();
        var imgSrc = document.selection.createRange().text;

        objPreviewFake.filters.item(
            'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;
        objPreviewSizeFake.filters.item(
            'DXImageTransform.Microsoft.AlphaImageLoader').src = imgSrc;

        autoSizePreview(objPreviewFake,
            objPreviewSizeFake.offsetWidth, objPreviewSizeFake.offsetHeight);
        objPreview.style.display = 'none';
    }
}

function onPreviewLoad(sender) {
    autoSizePreview(sender, sender.offsetWidth, sender.offsetHeight);
}

function autoSizePreview(objPre, originalWidth, originalHeight) {
    var zoomParam = clacImgZoomParam(300, 300, originalWidth, originalHeight);

    // objPre.style.width = zoomParam.width + 'px';
    // objPre.style.height = zoomParam.height + 'px';
    objPre.style.marginTop = zoomParam.top + 'px';
    objPre.style.marginLeft = zoomParam.left + 'px';
}

function clacImgZoomParam(maxWidth, maxHeight, width, height) {
    var param = {width: width, height: height, top: 0, left: 0};

    /*   if( width>maxWidth || height>maxHeight ){
           rateWidth = width / maxWidth;
           rateHeight = height / maxHeight;

           if( rateWidth > rateHeight ){
               param.width =  maxWidth;
               param.height = height / rateWidth;
           }else{
               param.width = width / rateHeight;
               param.height = maxHeight;
           }
       }

       param.left = (maxWidth - param.width) / 2;
       param.top = (maxHeight - param.height) / 2;   */

    return param;
} 