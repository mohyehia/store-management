<%@page import="com.storemanagement.entities.Privilege"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<Privilege> privileges = (List<Privilege>) request.getSession().getAttribute("privileges");
if(!privileges.get(10).isInsert()) response.sendRedirect("/store-management-system/error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>برنامج إدارة المبيعات | إضافة مورد جديد</title>

    <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../css/sb-admin-2.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="../css/font-awesome/font-awesome.min.css" rel="stylesheet" type="text/css">
    
	<style>
		textarea {resize: vertical;}
	</style>
</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading" style="overflow: hidden;">
                        <h3 class="panel-title" style="float: right;">إضافة مورد جديد</h3>
                    	<a href="/store-management-system/suppliers" style="float: left;"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
                    </div>
                    <div class="panel-body">
                        <form method="post" action="/store-management-system/suppliers">
                            <fieldset>
                                <div class="form-group">
                                	<label for="supplier_name">اسم المورد</label>
                                    <input class="form-control" placeholder="اسم المورد" name="supplier_name" type="text" id="supplier_name" autofocus required>
                                </div>
                                <div class="form-group">
                                	<label for="supplier_code">كود المورد</label>
                                    <input class="form-control" placeholder="كود المورد" name="supplier_code" type="text" id="supplier_code">
                                </div>
                                <div class="form-group">
                                	<label for="supplier_email">البريد الالكترونى</label>
                                    <input class="form-control" placeholder="البريد الالكترونى" name="supplier_email" type="email" id="supplier_email">
                                </div>
                                <div class="form-group">
                                	<label for="supplier_phone">رقم الهاتف</label>
                                    <input class="form-control" placeholder="رقم الهاتف" name="supplier_phone" type="number" id="supplier_phone">
                                </div>
                                <div class="form-group">
                                	<label for="supplier_mobile1">رقم الموبايل 1</label>
                                    <input class="form-control" placeholder="رقم الموبايل 1" name="supplier_mobile1" type="number" id="supplier_mobile1">
                                </div>
                                <div class="form-group">
                                	<label for="supplier_mobile2">رقم الموبايل 2</label>
                                    <input class="form-control" placeholder="رقم الموبايل 2" name="supplier_mobile2" type="number" id="supplier_mobile2">
                                </div>
                                <div class="form-group">
                                	<label for="supplier_description">وصف المورد</label>
                                    <textarea class="form-control" placeholder="وصف المورد" name="supplier_description" id="supplier_description"></textarea>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="hidden" name="action" value="add" />
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

</body>

</html>