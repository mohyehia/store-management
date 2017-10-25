<%@page import="com.storemanagement.entities.Unit"%>
<%@page import="com.storemanagement.utils.InvoicesCounterUtil"%>
<%@page import="com.storemanagement.utils.DateUtil"%>
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
List<Unit> units = (List<Unit>) request.getAttribute("units");
long invNumber = InvoicesCounterUtil.getSalesInvoiceCounter();
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
			<form action="" method="post" id="saveInvoiceForm">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group form-inline">
						<label for="inv_num">رقم الفاتورة</label> 
						<input style="width: 50%" class="form-control" type="number" id="inv_num" name="inv_num" value="<%= invNumber %>" readonly />
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
						<input style="width: 40%" class="form-control" type="text" id="inv_date" name="inv_date" value="<%= new SimpleDateFormat("dd-MM-yyyy").format(new Date()) %>" readonly />
					</div>
<!-- 					<div class="form-group form-inline"> -->
<!-- 						<label for="inventory">المخزن</label>  -->
<!-- 						<select class="form-control" id="inventory" name="inventory"> -->

<!-- 						</select> -->
<!-- 					</div> -->
				</div>
				<div class="col-md-4">
					<div class="form-group form-inline">
						<label for="inv_type">نوع الفاتورة</label> 
<!-- 						<select class="form-control" id="inv_type" name="inv_type">
							<option value="0">فوري</option>
							<option value="1">آجل</option>
 							</select> -->
 						<input type="text" class="form-control" name="inv_type" id="inv_type" value="فوري" readonly />
					</div>
<!-- 					<div class="form-group form-inline"> -->
<!-- 						<label for="cache">الخزنة</label>  -->
<!-- 						<select class="form-control" id="cache" name="cache"> -->
							
<!-- 						</select> -->
<!-- 					</div> -->
				</div>
			</div>
			<hr />
			<div class="row">
				<div class="col-md-3">
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
				<div class="col-md-3">
					<div class="form-group">
						<label for="subGroup">المجموعة الفرعية</label>
						<select class="form-control" name="subGroup" id="subGroup">
						</select>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="item">الصنف</label>
						<select class="form-control" name="item" id="item">
						</select>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label for="unit">الوحدة</label>
						<div style="overflow: hidden;">
							<select class="form-control" name="unit" id="unit" style="float: right; width: 80%">
							<% for(Unit unit : units){ %>
							<option data-qty="<%= unit.getQty() %>" value="<%= unit.getId() %>"><%= unit.getName() %></option>
							<% } %>
							</select>
							<button class="btn btn-success" id="add_item" type="button" style="float: left"><i class="fa fa-plus" aria-hidden="true"></i></button>
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
							<th>الكمية فى المخزن</th>
							<th>الوحدة</th>
							<th>كمية الوحدة</th>
							<th>الكمية</th>
							<th>السعر</th>
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
							<input type="number" style="width: 40%;" class="form-control" value="0" name="totalPrice" id="totalPrice" readonly />
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
							<input type="number" style="width: 40%;" class="form-control" min="1" name="remain" id="remain" readonly />
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group form-inline">
							<label for="finalTotal">الاجمالى النهائي</label>
							<input type="number" class="form-control" min="1" name="finalTotal" id="finalTotal" readonly />
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
					<div class="col-md-3 col-md-offset-9">
						<div class="form-group form-inline">
							<input type="hidden" name="action" value="save" />
							<input type="submit" id="saveInvoiceBtn" class="btn btn-lg btn-primary" value="طباعة الفاتورة" />
							<a href="sales/invoices.jsp"><button class="btn btn-lg btn-default" type="button">خروج</button></a>
						</div>
						</form>
					</div>
				</div>
			</div>
		<!-- /.panel-body -->
	</div>
</div>
</div>
<!-- /#page-wrapper -->

<jsp:include page="../footer.html" />
<style>
hr{margin-top: 10px; margin-bottom: 10px;}
</style>
<script>
$(document).ready(function(){
	var finalTotal = null;
	var i = 0;
	$('#add_item').click(function(){
		var itemId = $('#item').val();
		var unit = $('#unit').val();
		var unitQuantity = $('#unit').find(':selected').data('qty');
		$.ajax({
			url : "/store-management/sales",
			method : "POST",
			data : {itemId : itemId, action : "3"},
			dataType : "json",
			success : function(data){
				addRows(data.itemId, data.itemCode, data.itemName, data.itemPrice, data.itemQty, data.itemMin, unit, unitQuantity);
			}
		});
	});
	
	//add new items to the invoice if the request is success
	function addRows(id, code, name, price, itemQty, itemMin, unit, unitQuantity){
		i++;
		$('#item-rows').append('<tr id="row' + i + '">' + 
		'<input type="hidden" class="itemId" name="itemId[]" value = "' + id + '"/>' +
		'<input type="hidden" class="unitId" name="unitId[]" value = "' + unit + '"/>' +
		'<td><input class="form-control" value="' + code + '" type="text" name="item_code[]" autofocus disabled /></td>' +
		'<td><input class="form-control" value="' + name + '" type="text" name="item_name[]" disabled /></td>' + 
		'<td><input class="form-control" value="' + itemQty + '" type="number" disabled /></td>' + 
		'<td><input class="form-control" value="' + $("#unit option:selected").text() + '" disabled /></td>' + 
		'<td><input class="form-control" value="' + unitQuantity + '" type="number" disabled /></td>' + 
		'<td><input class="form-control itemQty" data-inventory="' + itemQty + '" data-min="' + itemMin + '" value="1" type="number" name="itemQty[]" min="1" /></td>' +
		'<td><input class="form-control itemPrice" value="' + price + '" type="number" name="itemPrice[]" min="1" /></td>' +
		'<td><input class="form-control itemTotal" value="' + price * unitQuantity +'" type="number" name="itemTotal[]" min="1" disabled /></td>' +
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
	
	//modify total price each time a change is happened to quantity
	var invalid = 0;
	$(document).on('change keyup', '.itemQty', function(){
		var min = $(this).data('min');
		var inventory = $(this).data('inventory');
		var unitQty = $(this).closest('td').prev().find('input').val();
		var qty = $(this).val();
		if(inventory - (unitQty * qty) < 0) {
			alert("كمية الصنف فى المخزن غير كافية");
			invalid++;
			$('#saveInvoiceBtn').addClass('hidden');
		}
		else{
			if(inventory - (unitQty * qty) < min){
				alert("الكمية المختارة ستتخطى الحد الأدنى للصنف فى المخزن");
			}
			if(invalid > 0) invalid--;
			if(invalid == 0) $('#saveInvoiceBtn').removeClass('hidden');
		}
		var price = $(this).closest('td').next().find('input').val();
		$(this).closest('td').next().next().find('input').val(qty * price * unitQty);
		sumTotal();
	});
	
	//modify total price each time a change is happened to price
	$(document).on('change keyup', '.itemPrice', function(){
		var price = $(this).val();
		var qty = $(this).closest('td').prev().find('input').val();
		var unitQty = $(this).closest('td').prev().prev().find('input').val();
		$(this).closest('td').next().find('input').val(qty * price * unitQty);
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

	//submit the form
	$('#saveInvoiceForm').on('submit', function(e){
		e.preventDefault();
		var itemIds = $('input.itemId[type=hidden]').map(function() {
		       return $(this).val(); }).get().join();
		var itemQty = $('input.itemQty[type=number]').map(function() {
		       return $(this).val(); }).get().join();
		var unitId = $('input.unitId[type=hidden]').map(function() {
		       return $(this).val(); }).get().join();
		var itemPrice = $('input.itemPrice[type=number]').map(function() {
		       return $(this).val(); }).get().join();
		var itemTotal = $('input.itemTotal[type=number]').map(function() {
		       return $(this).val(); }).get().join();
		var inv_num = $('#inv_num').val();
//		var inv_type = $('#inv_type').val();
// 		var paid = $('#paid').val();
// 		var remain = $('#remain').val();
		var finalTotal = $('#finalTotal').val();
		var paid = $('#finalTotal').val();
		var remain = 0;
		var inv_type = 0;
		var client = $('#client').val();
// 		var inventory = $('#inventory').val();
// 		var cache = $('#cache').val();
		var totalPrice = $('#totalPrice').val();
		var discountType = $('#discountType').val();
		var discount = $('#discount').val();
		var tax = $('#tax').val();
		if(discount == '') discount = 0;
		if(tax == '') tax = 0;
		$.ajax({
			url : "/store-management/sales",
			method : "POST",
			data : {
				itemIds : itemIds, itemQty : itemQty, itemTotal : itemTotal, unitId : unitId,
				inv_num : inv_num, inv_type :inv_type, paid : paid, itemPrice : itemPrice,
				remain : remain, finalTotal : finalTotal, client : client,
				//inventory : inventory, cache : cache,
				totalPrice :totalPrice,
				discountType : discountType, discount : discount, tax : tax,
				action : "save"
			},
			dataType : "text",
			success : function(data){
				if(data){
					alert("تم حفظ الفاتورة بنجاح");
					location.reload();
				}
			}	
		});
	});
})
</script>