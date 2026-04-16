/**
 * 
 */
$(document).ready(function () {

	    /* Disable past dates in date picker */
	    let today = new Date().toISOString().split("T")[0];
	    $("#insuranceExpiryDate").attr("min", today);
	    $("#inputPolutionCertificate").attr("min", today);

	    /* Convert vehicle number to uppercase */
	    $("input[name='vehicleNumber']").on("input", function(){
	        this.value = this.value.toUpperCase();
	    });

	    $("#submitForm").on("submit", function (e) {

	        e.preventDefault();
            $(".error").text("");
            $(".form-control").removeClass("error-border");

	            let isValid = true;
	        let vehicleNumber = $("input[name='vehicleNumber']").val().trim();
	        let vehicleType = $("#vehicleType").val();
	        let seatCapacity = $("#inputSeatCapacity").val();
	        let fuelType = $("#selectFuelType").val();
	        let vendor = $("#vendor").val();
	        let modelName = $("#inputModelName").val().trim();
	        let modelYear = $("#inputModelYear").val();
	        let insuranceCompany = $('#insuranceCompany').val().trim();
	        let insuranceExpiryDate = $("#insuranceExpiryDate").val().trim();
	        let policyNumber = $('#policyNumber').val().trim();
	        let insuranceDate = $("#insuranceExpiryDate").val();
	        let polutionDate = $("#inputPolutionCertificate").val();

	        let vehicleRegex = /^[A-Z]{2}[0-9]{1,2}[A-Z]{1,2}[0-9]{4}$/;

	        if (vehicleNumber === "") {
	            $("#vehicleNumberError").text("Vehicle Number is required");
	            isValid = false;
	        } 
	        else if (!vehicleRegex.test(vehicleNumber)) {
	            $("#vehicleNumberError").text("Example: KA01AB1234");
	            isValid = false;
	        }

	        if (!vehicleType) {
	            $("#vehicleTypeError").text("Select Vehicle Type");
	            isValid = false;
	        }

	        if (seatCapacity === "" || seatCapacity <= 0) {
	            $("#seatCapacityError").text("Enter valid seating capacity");
	            isValid = false;
	        }

	        if (!fuelType) {
	            $("#fuelTypeError").text("Select fuel type");
	            isValid = false;
	        } 

	        if (!vendor) {
	            $("#vendorError").text("Select vendor");
	            isValid = false;
	        }

	        if (modelName === "") {
	            $("#modelNameError").text("Model name required");
	            isValid = false;
	        }

	        if (modelYear === "") {
	            $("#modelYearError").text("Please select Model Year");
	            isValid = false;
	        } else {

	            let modelDate = new Date(modelYear);
	            let today = new Date();

	            if (modelDate > today) {
	                $("#modelYearError").text("Model year cannot be future date");
	                isValid = false;
	            }
	        }

	        if (insuranceExpiryDate === "") {
	            $("#insuranceExpiryError").text("Please select Model Year");
	            isValid = false;
	        } else {

	            let modelDate = new Date(modelYear);
	            let today = new Date();

	            if (modelDate > today) {
	                $("#insuranceExpiryError").text("Insurance expired");
	                isValid = false;
	            }
	        }
	        if (polutionDate === "") {
	            $("#polutionExpiryError").text("Please select polution expiry date");
	            isValid = false;
	        } else {

	            let modelDate = new Date(modelYear);
	            let today = new Date();

	            if (modelDate > today) {
	                $("#polutionExpiryError").text("polution expired");
	                isValid = false;
	            }
	        }
	        
	        if (insuranceCompany === "") {
	            $("#insuranceCompanyError").text("Insurance Company name required");
	            isValid = false;
	        }
	        if (policyNumber === "") {
	            $("#policyNumberError").text("Policy number required");
	            isValid = false;
	        }

	        let today = new Date();
	        today.setHours(0,0,0,0);

	        if (insuranceDate !== "") {
	            let insDate = new Date(insuranceDate);

	            if (insDate <= today) {
	                $("#insuranceDateError").text("Insurance must be future date");
	                isValid = false;
	            }
	        }

	        if (polutionDate !== "") {
	            let polDate = new Date(polutionDate);

	            if (polDate <= today) {
	                $("#polutionDateError").text("Pollution date must be future");
	                isValid = false;
	            }
	        }

	        if (!isValid) return;
	        /* AJAX Submit */

	        $.ajax({
	            url: "vehicleMasterSubmit.jsp",
	            type: "POST",
	            data: $("#submitForm").serialize(),
	            dataType: "json",

	            beforeSend: function () {
	                $("#divLoading").addClass('show');
	            },

	            success: function (response) {

	                $("#divLoading").removeClass('show');

	                if (response.status === "success") {

	                    Swal.fire({
	                        icon: 'success',
	                        title: 'Success',
	                        text: 'Vehicle Added Successfully',
	                        confirmButtonText: 'OK'
	                    }).then(() => {

	                        $("#submitForm")[0].reset();

	                    });

	                } else {

	                    Swal.fire({
	                        icon: 'error',
	                        title: 'Error',
	                        text: 'Something went wrong'
	                    });

	                }

	            },

	            error: function () {

	                $("#divLoading").removeClass('show');

	                Swal.fire({
	                    icon: 'error',
	                    title: 'Error',
	                    text: 'Something went wrong'
	                });

	            }

	        });

	    });

	});