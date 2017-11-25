<%@page import="com.storemanagement.utils.DateUtil"%>
<%@page import="com.storemanagement.entities.Supplier"%>
<%@page import="com.storemanagement.entities.Unit"%>
<%@page import="com.storemanagement.services.EntityService"%>
<%@page import="com.storemanagement.entities.MainGroup"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
List<MainGroup> mainGroups = (List<MainGroup>) EntityService.getAllObjects(MainGroup.class);
List<Unit> units = (List<Unit>) EntityService.getAllObjects(Unit.class);
String code = DateUtil.getDate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>برنامج إدارة المبيعات | إضافة صنف</title>

    <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/sb-admin-2.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="../css/font-awesome/font-awesome.min.css" rel="stylesheet" type="text/css">
	<style>
		textarea {resize: vertical;}
		.login-panel{margin-top: 50px;}
	</style>
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading" style="overflow: hidden;">
                        <h3 class="panel-title" style="float: right;">إضافة صنف جديد</h3>
                    	<a href="/store-management-system/items" style="float: left;"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                    </div>
                    <div class="panel-body">
                        <form method="post" action="/store-management-system/items">
                            <fieldset>
                            	<div class="col-md-6">
                            		<div class="form-group">
	                            		<label for="mainGroups">اختر المجموعة الرئيسية</label>
		                        		<select class="form-control" name="mainGroups" id="mainGroups" required autofocus>
		                        			<option value="">اختر مجموعة رئيسية</option>
		                        			<% for(MainGroup mainGroup : mainGroups){ %>
		                        			<option value="<%= mainGroup.getId() %>"><%= mainGroup.getName() %></option>
		                        			<% } %>
		                        		</select>
                            		</div>
                            		<div class="form-group">
	                                	<label for="item_name">اسم الصنف</label>
	                                    <input class="form-control" placeholder="اسم الصنف" name="item_name" type="text" id="item_name" required>
                                	</div>
                                	<div class="form-group">
	                                	<label for="item_purchase_price">سعر الشراء</label>
	                                    <input class="form-control" placeholder="سعر الشراء" name="item_purchase_price" type="number" min="1" id="item_purchase_price" required>
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_minLimit">أقل كمية</label>
	                                    <input class="form-control" placeholder="أقل كمية" name="item_minLimit" type="number" min="1" id="item_minLimit" >
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_home">بلد المنشأ</label>
	                                    <input class="form-control" placeholder="بلد المنشأ" name="item_home" type="text" id="item_home" >
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_expirationDate">تاريخ انتهاء الصلاحية</label>
	                                    <input class="form-control" placeholder="تاريخ انتهاء الصلاحية" name="item_expirationDate" type="date" min="1" id="item_expirationDate" >
	                                	<input type="hidden" name="action" value="add" />
	                                </div>
                            	</div>
                            	
                            	<div class="col-md-6">
                            		<div class="form-group">
	                                	<label for="subGroups">اختر المجموعة الفرعية</label>
	                                    <select class="form-control" name="subGroups" id="subGroups" required>
	                                    </select>
                                	</div>
                                	<div class="form-group">
	                                	<label for="item_code">كود الصنف</label>
	                                    <input class="form-control" placeholder="كود الصنف" name="item_code" type="text" id="item_code" value="<%= code %>" required>
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_sale_price">سعر البيع</label>
	                                    <input class="form-control" placeholder="سعر البيع" name="item_sale_price" type="number" min="1" id="item_sale_price" required>
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_maxLimit">أعلى كمية</label>
	                                    <input class="form-control" placeholder="أعلى كمية" name="item_maxLimit" type="number" min="1" id="item_maxLimit" >
	                                </div>
	                                <div class="form-group">
	                                	<label for="item_productionDate">تاريخ الانتاج</label>
	                                    <input class="form-control" placeholder="تاريخ الانتاج" name="item_productionDate" type="date" min="1" id="item_productionDate" >
	                                </div>
	                                <div class="form-group">
	                                	<label for="description">الوصف</label>
	                                	<textarea class="form-control" name="description" id="description" placeholder="وصف الصنف"></textarea>
	                                </div>
                            	</div>
      
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" class="btn btn-lg btn-primary btn-block" value="حفظ" />
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery Version 1.11.0 -->
    <script src="../js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../js/bootstrap.min.js"></script>

	<script>
	$(document).ready(function(){
		$('#mainGroups').change(function(){
			var mainGroup_id = $(this).val();
			if(mainGroup_id != ''){
				$.ajax({
					url : "/store-management-system/items",
					method : "POST",
					data : {mainGroup_id : mainGroup_id, action : "1"},
					dataType : "text",
					success : function(data){
						$('#subGroups').html(data);
					}
				});
			}
		});
	})
	</script>

</body>

</html>