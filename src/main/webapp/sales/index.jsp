<%@page import="com.storemanagement.services.EntityService"%>
<%@page import="com.storemanagement.entities.Item"%>
<%@page import="com.storemanagement.entities.MainGroup"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.storemanagement.entities.Cache"%>
<%@page import="com.storemanagement.entities.Inventory"%>
<%@page import="com.storemanagement.entities.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%
List<Client> clients = (List<Client>) request.getAttribute("clients");
List<Inventory> inventories = (List<Inventory>) request.getAttribute("inventories");
List<Cache> caches = (List<Cache>) request.getAttribute("caches");
List<MainGroup> mainGroups = (List<MainGroup>) request.getAttribute("mainGroups");
%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">فاتورة بيع جديدة</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">

	<div class="panel panel-default">
		<div class="panel-heading">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group form-inline">
						<label for="inv_num">رقم الفاتورة</label> 
						<input style="width: 30%" class="form-control" type="number" id="inv_num" name="inv_num" value="1" disabled />
					</div>
					<div class="form-group form-inline">
						<label for="client">العميل</label> 
						<select class="form-control" id="client" name="client">
							<optgroup label="عميل غير مسجل" id="monetaryClient">
								<option value="0">عميل نقدي</option>
							</optgroup>
							<optgroup label="عملاء مسجلين بقواعد البيانات" id="installmentClient">
							<% for(Client client : clients){ %>
							<option value="<%= client.getId() %>"><%= client.getName() %></option>
							<% } %>
							</optgroup>
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group form-inline">
						<label for="inv_date">التاريخ</label> 
						<input style="width: 40%" class="form-control" type="text" id="inv_date" name="inv_date" value="<%= new SimpleDateFormat("dd-MM-yyyy").format(new Date()) %>" disabled />
					</div>
					<div class="form-group form-inline">
						<label for="store">المخزن</label> 
						<select class="form-control" id="store" name="store">
							<% for(Inventory inventory : inventories){ %>
							<option value="<%= inventory.getId() %>"><%= inventory.getName() %></option>
							<% } %>
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group form-inline">
						<label for="inv_type">نوع الفاتورة</label> 
						<select class="form-control" id="inv_type" name="inv_type">
							<option value="0">فوري</option>
							<option value="1">آجل</option>
						</select>
					</div>
					<div class="form-group form-inline">
						<label for="cache">الخزنة</label> 
						<select class="form-control" id="cache" name="cache">
							<% for(Cache cache : caches){ %>
							<option value="<%= cache.getId() %>"><%= cache.getName() %></option>
							<% } %>
						</select>
					</div>
				</div>
			</div>
			<hr />
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label for="mainGroup">المجموعة الرئيسية</label>
						<select class="form-control" name="mainGroup" id="mainGroup">
							<option value="0">اختر مجموعة رئيسية</option>
							<% for(MainGroup mainGroup : mainGroups){ %>
							<option value="<%= mainGroup.getId() %>"><%= mainGroup.getName() %></option>
							<% } %>
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="subGroup">المجموعة الفرعية</label>
						<select class="form-control" name="subGroup" id="subGroup">
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="item">الصنف</label>
						<div style="overflow: hidden;">
							<select class="form-control" name="item" id="item" style="float: right; width: 85%">
							</select>
							<button class="btn btn-success" id="add_item" style="float: left"><i class="fa fa-plus" aria-hidden="true"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
			<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>كود الصنف</th>
							<th>اسم الصنف</th>
							<th>السعر</th>
							<th>الكمية</th>
							<th>الإجمالى</th>
							<th>حذف</th>
						</tr>
					</thead>
					<tbody id="item-rows">
					</tbody>
				</table>
				
			</div>
			<!-- /.table-responsive -->
		</div>
		<div class="panel-footer">
				<div class="row" id="completeSale">
					<div class="col-md-3">
						<div class="form-group form-inline">
							<label for="totalPrice">إجمالى الفاتورة</label>
							<input type="number" style="width: 40%;" class="form-control" value="0" name="totalPrice" id="totalPrice" disabled />
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group form-inline">
							<select name="discountType" id="discountType" class="form-control">
								<option value="0">خصم نسبة</option>
								<option value="1">خصم مبلغ</option>
							</select>
							<input type="number" style="width: 40%;" class="form-control" placeholder="%" min="1" name="discount" id="discount" />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group form-inline">
							<label for="tax">ضرائب بعد الخصم</label>
							<input type="number" class="form-control" placeholder="%" min="1" name="tax" id="tax" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 hideInMonetary hidden">
						<div class="form-group form-inline">
							<label for="paid">المدفوع</label>
							<input type="number" style="width: 40%;" class="form-control" min="1" name="paid" id="paid" />
						</div>
					</div>
					<div class="col-md-3 hideInMonetary hidden">
						<div class="form-group form-inline">
							<label for="remain">الباقى</label>
							<input type="number" style="width: 40%;" class="form-control" min="1" name="remain" id="remain" disabled />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group form-inline">
							<label for="finalTotal">الاجمالى النهائي</label>
							<input type="number" class="form-control" min="1" name="finalTotal" id="finalTotal" disabled />
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
					<div class="col-md-3 col-md-offset-9">
						<div class="form-group form-inline">
							<input type="submit" class="btn btn-lg btn-primary" value="طباعة الفاتورة" />
							<a href="#"><button class="btn btn-lg btn-default">خروج</button></a>
						</div>
					</div>
				</div>
			</div>
		<!-- /.panel-body -->
	</div>
</div>
</div>
<!-- /#page-wrapper -->

<jsp:include page="../footer.jsp" />
<style>
hr{margin-top: 10px; margin-bottom: 10px;}
</style>
<script>
$(document).ready(function(){
	var finalTotal = null;
	var i = 0;
	$('#add_item').click(function(){
		var itemId = $('#item').val();
		$.ajax({
			url : "/store-management/sales",
			method : "POST",
			data : {itemId : itemId, action : "3"},
			dataType : "json",
			success : function(data){
				addRows(data.itemCode, data.itemName, data.itemPrice);
			}
		});
	});
	
	//add new items to the invoice if the request is success
	function addRows(code, name, price){
		i++;
		$('#item-rows').append('<tr id="row' + i + '">' + 
		'<td><input class="form-control" value="' + code + '" type="text" name="item_code[]" autofocus disabled /></td>' +
		'<td><input class="form-control" value="' + name + '" type="text" name="item_name[]" disabled /></td>' + 
		'<td><input class="form-control itemPrice" value="' + price + '" type="number" name="item_price[]" min="1" disabled /></td>' +
		'<td><input class="form-control itemQty" value="1" type="number" name="item_qty[]" min="1" /></td>' +
		'<td><input class="form-control itemTotal" value="' + price +'" type="number" name="item_total[]" min="1" disabled /></td>' +
		'<td><button class="btn btn-danger btn-remove" name="remove" id="' + i + '"><i class="fa fa-close"></i></button></td>' +
		'</tr>');
		sumTotal();
	}
	
	//sum total for the totalPrice and finalTotal
	function sumTotal(){
		var sum = 0;
		$('.itemTotal').each(function(){
			sum += parseFloat($(this).val());
		});
		$('#totalPrice').val(sum);
		$('#finalTotal').val(sum);
		finalTotal = $('#finalTotal').val();
	}
	
	//remove item from invoice
	$(document).on('click', '.btn-remove', function(){
		var buttonId = $(this).attr('id');
		$('#row' + buttonId).remove();
		sumTotal();
	});
	
	//modify price eachn time a change is happened to quantity
	$(document).on('change keyup', '.itemQty', function(){
		var qty = $(this).val();
		var price = $(this).closest('td').prev().find('input').val();
		$(this).closest('td').next().find('input').val(qty * price);
		sumTotal();
	});
	
	//check if the invType is monetary or installement
	$('#inv_type').change(function(){
		if($(this).val() == 1){
			$('#monetaryClient').addClass('hidden');
			$('.hideInMonetary').removeClass('hidden');
		} else {
			$('#monetaryClient').removeClass('hidden');
			$('.hideInMonetary').addClass('hidden');
		}
	});
	
	//check for the discount type if it is % or EGP
	$('#discountType').change(function(){
		if($(this).val() == 0)
			$('#discount').attr('placeholder', '%');
		else $('#discount').attr('placeholder', 'EGP');
	});
	
	//sum finalTotal value after the discount
	$('#discount').on('change keyup', function(){
		if($(this).attr('placeholder') == '%'){
			var val = $(this).val() / 100;
			var sum = parseFloat(val * $('#totalPrice').val());
			$('#finalTotal').val($('#totalPrice').val() - sum);
		}else{
			var val = $(this).val();
			$('#finalTotal').val(parseFloat($('#totalPrice').val()) - parseFloat(val));
		}
		finalTotal = $('#finalTotal').val();
	});
	
	//sum final total after applying tax after discount
	$('#tax').on('change keyup', function(){
		var val = $(this).val() / 100;
		var total = parseFloat(val * finalTotal);
		$('#finalTotal').val(parseFloat(finalTotal) + total);
	});
	
	//calculate paid and remain
	$('#paid').on('change keyup', function(){
		var paid = $(this).val();
		var total = $('#finalTotal').val();
		$('#remain').val(parseFloat(total) - parseFloat(paid));
	});
	
	//send ajax request to get subGroups from mainGroupId
	$('#mainGroup').change(function(){
		var mainGroup_id = $(this).val();
		$.ajax({
			url : "/store-management/sales",
			method : "POST",
			data : {mainGroup_id : mainGroup_id, action : "1"},
			dataType : "text",
			success : function(data){
				$('#subGroup').html(data);
			}
		});
	});
	
	//send ajax request to get items from subGroupId
	$('#subGroup').change(function(){
		var subGroup_id = $(this).val();
		$.ajax({
			url : "/store-management/sales",
			method : "POST",
			data : {subGroup_id : subGroup_id, action : "2"},
			dataType : "text",
			success : function(data){
				$('#item').html(data);
			}
		});
	});
})
</script>