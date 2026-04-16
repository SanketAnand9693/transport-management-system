/**
 * 
 */
$(document).ready(function () {

	    $("#submitForm").on("submit", function (e) {
	        e.preventDefault();
	        $(".error").text("");
            $(".form-control").removeClass("error-border");
	        let isValid = true;

	        // GET VALUES
	        var staffId = $("#staffId").val().trim();
	        var department = $("input[name='department']").val().trim();
	        var phone = $("#guardianContactNumber").val().trim();
	        var firstName = $("#staffFirstName").val().trim();
	        var middleName = $("#staffMiddleName").val().trim();
	        var lastName = $("#staffLastName").val().trim();
	        var pickupDropPoint = $("#pickupDropPoint").val().trim();
	        var address = $("#address").val().trim();

	        // VALIDATIONS

	        if (staffId === "") {
	       	 $("#staffIdError").text("Please enter staff ID");
			    isValid = false;
	        }

	        if (department === "") {
	       	 $("#departmentError").text("Please enter department");
			    isValid = false;
	        }

	        if (phone === "") {
	       	 $("#contactNumberError").text("Please enter contact number");
			    isValid = false;
	        }

	        if (firstName === "") {
	       	 $("#firstNameError").text("Enter first name");
			    isValid = false;
	        }

	  /*       if (middleName === "") {
	            Swal.fire("Validation Error", "Middle name is required", "warning");
	            return;
	        } */

	        if (lastName === "") {
	       	 $("#lastNameError").text("Enter last name");
			    isValid = false;
	        }

	        if (pickupDropPoint === "") {
	       	 $("#pickupDropError").text("Please enter pickup drop point");
			    isValid = false;
	        }

	        if (address === "") {
	       	 $("#addressError").text("Please enter staff address");
			    isValid = false;
	        }

	        if(!isValid) return;

	        // AJAX SUBMIT
	        $.ajax({
	            url: "staffMasterSubmit.jsp",
	            type: "POST",
	            data: $("#submitForm").serialize(),
	            dataType: "json",

	            beforeSend: function () {
	                $("#divLoading").addClass("show");
	            },

	            success: function (response) {
	                $("#divLoading").removeClass("show");

	                if (response.status === "success") {
	                    Swal.fire({
	                        icon: "success",
	                        title: "Success",
	                        text: "Staff Added Successfully",
	                        confirmButtonText: "OK"
	                    }).then(() => {
	                        $("#submitForm")[0].reset();
	                    });

	                } else {
	                    Swal.fire("Error", "Something went wrong", "error");
	                }
	            },

	            error: function () {
	                $("#divLoading").removeClass("show");
	                Swal.fire("Error", "Server Error", "error");
	            }
	        });

	    });

	});