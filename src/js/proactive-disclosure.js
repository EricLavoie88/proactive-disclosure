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
			item: '<li><div class="checkbox"><label><input class="id" type="checkbox" name="organizations" value="" /><span class="name"></span></label></div></li>',
			valueNames: ['id' ,'name']
		};
	
		var organizationList = new List ('organizationList', options);
		
		organizationList.add(data);
		organizationList.sort('name', { order: "asc" });
		
		console.log("Added items to organization list");
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

// Apply button functionality
$("button[name=apply]").bind("click", function () {
	$(".wb-overlay").trigger("close.wb-overlay");
	
	
});