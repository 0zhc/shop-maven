 function checkName(){
             var reg=/^[\u4E00-\u9FA5A-Za-z0-9]+$/;
             var goodsName=$("#name").val();
           if(goodsName.length>20 || goodsName.length<1){
                alert("商品名不要为空且大于20个字符");
                return false;
             }else{
               if(!reg.test(goodsName)){//test符合返回true
                   alert("商品名由数字、英文、中文组成");
                   return false;
               }
             }
             return true;
        }      
         
        //价格
        function checkPrice(){
         var reg = /^\d+(\.\d+)?$/;
         var price=$("#price").val();
		if (!reg.test(price)){
			alert('价格输入有误,请输入数字！');
			return false;
		}else{
			if(price>10000){
			  alert('价格数字不能大于10000！');
			 return false;
			} 
		    else  
			return true;
		}
         return true; 
        
        }
        //数量
        function checkAmount(){
            var reg = /^\d+(\.\d+)?$/;
         var amount=$("#amount").val();
		if (!reg.test(amount)){
			alert('数量输入有误,请输入数字！');
			return false;
		}else{
			if(amount.length>4){
			  alert('数量不能大于10000！');
			 return false;
			} 
		    else  
			return true;
		}
         return true; 
        }
        //数量单位
        function checkAmountUnit(){
              var reg=/^[a-zA-Z\u4e00-\u9fa5]{1,10}$/;
           
             var amountUnit=$("#amountUnit").val();
            
             
             
           if(amountUnit.length>10 || amountUnit.length<1){
                alert("单位不能为空且不能大于10个字符");
                return false;
             }else{
                 if(!reg.test(amountUnit)){
                   alert("单位不能为空且由英文、中文组成");
                   return false;
             }
               
             }
             return true; 
        }  
         //检查是否有上传图片
         function isUploadPictrue(){
             if($("#goodsId").val()==""){
                  alert("请上传商品");
                  return false;
            
               }else{
                   // document.getElementById("addOtherForm").submit();
                   return true;
               }
               return false;
            }
			//验证商品尺寸
			function checkSize(){
				var size = $("#size").val();
				var reg = /^[\u4E00-\u9FA5A-Za-z0-9]{0,10}$/;
				if(size.length>10){
					alert("商品尺寸不能超过10个字符！");
					return false;
				}else if(!reg.test(size)){
					alert("商品尺寸只能由中文  英文  数字组成！");
					return false;
				}
				return true;
			}

			//验证尺寸单位
			function checkSizeUnit(){
              var reg=/^[a-zA-Z\u4e00-\u9fa5]{0,10}$/;
             var SizeUnit=$("#SizeUnit").val();
           if(SizeUnit.length>10){
                alert("尺寸单位不能大于10个字符！");
                return false;
             }else if(!reg.test(SizeUnit)){
                   alert("尺寸单位由英文、中文组成！");
                   return false;
             }
             return true; 
        } 

		//验证商品毛重
		function checkWeight(){
			var weight = $("#weight").val();
			var reg = /^[0-9]{0,10}$/
			if(weight.length>10){
	               alert("商品毛重不能大于10个数字！");
	               return false;
	          }else if(!reg.test(weight)){
	              alert("商品毛重由数字组成！");
	             return false;
	             }
	         return true; 		
		}

		//验证毛重单位
		function checkGrossUnit(){
          var reg=/^[a-zA-Z\u4e00-\u9fa5]{0,10}$/;
         var grossUnit=$("#grossUnit").val();
       if(grossUnit.length>10){
            alert("毛重单位不能大于10个字符！");
            return false;
         }else if(!reg.test(grossUnit)){
               alert("毛重单位由英文、中文组成！");
               return false;
         }
         return true; 
    } 
		//商品产地
		function checkOrigin(){
			var origin=$("#origin").val();
			var reg = /^[\u4E00-\u9FA5 A-Za-z0-9\-.]{0,}$/;
			if(!reg.test(origin)){
				alert("商品产地只能由中文、英文、数字、‘.’、‘-’组成！");
					return false;
				}else if(origin.length>20){
					alert("商品产地不能大于20个字符！");
					return false;
				}
				return true;
			}

		//商品品牌
		function checkBrand(){
			var brand=$("#brand").val();
			var reg = /^[\u4E00-\u9FA5 A-Za-z0-9]{0,}$/;
			if(!reg.test(brand)){
				alert("商品品牌只能由中文、英文、数字组成！");
					return false;
				}else if(brand.length>20){
					alert("商品品牌不能大于20个字符！");
					return false;
				}
				return true;
			}

		//商品颜色
		function checkColor(){
			var color=$("#color").val();
			var reg = /^[\u4E00-\u9FA5 A-Za-z]{0,}$/;
			if(!reg.test(color)){
				alert("商品颜色只能由中文、英文组成！");
					return false;
				}else if(color.length>10){
					alert("商品颜色不能大于10个字符！");
					return false;
				}
				return true;
			}

		//生产厂家
		function checkProductAdd(){
			var productAdd=$("#productAdd").val();
			var reg = /^[\u4E00-\u9FA5 A-Za-z0-9]{0,}$/;
			if(!reg.test(productAdd)){
				alert("生产厂家只能由中文、英文、数字组成！");
					return false;
				}else if(productAdd.length>50){
					alert("生产厂家不能大于50个字符！");
					return false;
				}
				return true;
			}
	    
         
          function isModify(){
        	 if(KE.count('content1','text')>500){
            	 alert("商品描述不能超过500个字符 ！");
      			return false;
      		}
            return checkName() && isUploadPictrue() && checkPrice() &&  checkAmount() && checkAmountUnit() && checkSize() && checkSizeUnit() && checkWeight() && checkGrossUnit() && checkOrigin() && checkBrand() && checkColor() && checkProductAdd();
          }