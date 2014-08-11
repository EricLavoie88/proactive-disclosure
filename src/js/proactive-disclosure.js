// Enable form
$("button[name=search]").removeAttr("disabled");
$("#add-filters").removeClass("disabled");

// Simulate dynamic loading of organizations via API
$.ajax({
	url: "./data/organizationList.json",
	dataType: "json",
	error: function (){
		$("<div class='alert alert-danger' role='alert'><span>Failed to load organization list.</span></div>").insertAfter("#organizationList summary");
	},
	success: function (data){
		$("<div class='form-group'><div><input type='text' id='org-list-input' class='form-control search' placeholder='Filter organizations' /></div></div><ul class='list'></ul>").insertAfter("#organizationList summary");
		
		var options = {
			item: '<li><div class="checkbox"><label><input class="org-id" type="checkbox" name="organizations" value="" /><span class="org-label"></span></label></div></li>',
			valueNames: ['org-id' ,'org-label']
		};
	
		var organizationList = new List ('organizationList', options);
		
		organizationList.add(data);
		organizationList.sort('org-label', { order: "asc" });
		
		console.log("Added items to organization list");
	}
});

// Simulate dynamic loading of fiscal-year list via API
$.ajax({
	url: "./data/yearList.json",
	dataType: "json",
	error: function (){
		$("#fiscalYearList").append("<div class='alert alert-danger' role='alert'><span>Failed to load year list.</span></div>");
	},
	success: function (data){
		$("#fiscalYearList").append("<div class='form-group'><div><input type='text' id='year-list-input' class='form-control search' placeholder='Filter fiscal years' /></div></div></div><ul class='list'></ul>");
		
		var options = {
			item: '<li><div class="checkbox"><label><input class="year-num" type="checkbox" name="years" value="" /><span class="year-label"></span></label></div></li>',
			valueNames: ['year-num' , 'year-label']
		};
	
		var yearList = new List ('fiscalYearList', options);
		
		yearList.add(data);
		yearList.sort('year-num', { order: "desc" });
		
		console.log("Added items to year list");
	}
});

// Add filters button functionality
$("#add-filters").bind("click", function () {

	// Enable/disable value filter based on disclosure type
	var value = $("input[name=disclosureType]:checked").val();
	if (value === "contracts" || value === "awards" || value === "travel" || value === "hospitality"){
		if (! $("#filters section").hasClass("value")) { 
			$("<section class='value'><details><summary><h4>Value</h4></summary><form class='form-horizontal' role='form'><div class='form-group'><div class='radio'><label><input name='value' type='radio' value='greater' checked/>greater than </label><input name='greater' type='text'/></div></div><div class='form-group'><div class='radio'><label><input name='value' type='radio' value='less' checked/>less than </label><input name='less' type='text'/></div></div><div class='form-group'><div class='radio'><label><input name='value' type='radio' value='equal' checked/>equal to </label><input name='equal' type='text'/></div></div><div class='form-group'><div class='radio'><label><input name='value' type='radio' value='between' checked/>between <input name='low' type='text'/> and <input name='high' type='text'/></label></div></div></details></form></section>").insertAfter("#filters .organizations");
		}
	} else {
		if ($("#filters section").hasClass("value")) { 
			$("#filters .value").remove();
		}
	}
	
});

// Date filter options
$("input[name=date]").bind("click", function() {
	var date = $("input[name=date]:checked").val();
	var calendar = $("#calendarDates").detach();
	var fiscalYear = $("#fiscalYearList").detach();
	var quarter = $("#quarterList").detach();
	
	$("#advanced-date").empty();
	
	if (date === "calendar") {
		$("#advanced-date").append(calendar);
		$("#calendarDates").css({"display": "block"});
		$("#advanced-date").append(fiscalYear);
		$("#fiscalYearList").css({"display": "none"});
		$("#advanced-date").append(quarter);
		$("#quarterList").css({"display": "none"});
	} else {				
		$("#advanced-date").append(fiscalYear);
		$("#fiscalYearList").css({"display": "block"});
		if (date === "quarter") {
			$("#advanced-date").append(quarter);
			$("#quarterList").css({"display": "block"});
		} else {
			$("#advanced-date").append(quarter);
			$("#quarterList").css({"display": "none"});
		}
		$("#advanced-date").append(calendar);
		$("#calendarDates").css({"display": "none"});
	}
});

// Apply button functionality
$("button[name=apply]").bind("click", function () {
	$(".wb-overlay").trigger("close.wb-overlay");
	
	
});