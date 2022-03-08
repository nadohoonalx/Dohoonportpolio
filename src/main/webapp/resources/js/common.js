/**
 * 
 */
 
var util = {
    requestSync : function(url, param, method, callback) {
   
    $.ajax({
			method : method,
			url : url,
			dataType : "JSON",
			data : param,
			error : function() {
				alert('error뜸');
			  				    },
			success : callback
		});	
    },
   
    initSelectBox : function(id, groupCode, value, select, service) {
   	
   	    if(groupCode == null) return;
   	    var reqData = {upcd : groupCode};
   	
   	    var serv = "/common/getCodeList";
   	
   	    //서비스가 있을경우 공통코드가 아닌 서비스로 값 조회
   	    if(service) serv = service;
   	
   	    util.requestSync(serv, reqData, 'GET', function(data) {
   		
   		    var obj = $('#' + id).get(0);
   		    obj.options.length = 0;
   		    if(select == "y") obj.add(new Option("-select-", ""));
   		
   		    for(var i=0; i<data.codeList.length; i++) {
   		    	var item = data.codeList[i];
   			    if(item.CODE==value) {
   				    obj.add(new Option(item.VALUE, item.CODE, true, true));
   			    }
   			    else {
   				    obj.add(new Option(item.VALUE, item.CODE));
   			    }
   			
   		    }
   	    });
    },
   
    showLoad : function(url, data){
        $('.card-body').load(url, function(response, status) {
		    if(status == 'error') {
			    $(this).html(response); //에러인 반응을 바인딩 한다
			}
			$(".mt-4").text(data);
		});
  
	}
}
 