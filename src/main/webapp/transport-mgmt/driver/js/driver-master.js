/**
 * 
 */
$(document).ready(function () {

    /* Disable past licence dates */
    let today = new Date().toISOString().split("T")[0];
    $("#licenceDate").attr("min", today);

    $("#submitForm").on("submit", function (e) {

        e.preventDefault();
        $(".error").text("");
        $(".form-control").removeClass("error-border");
        let isValid = true;

        let driverId = $("#driverId").val().trim();
        let firstName = $("#firstName").val().trim();
        let middleName = $("#middleName").val().trim();
        let lastName = $("#lastName").val().trim();
        let phone = $("#phoneNumber").val().trim();
        let licenceNumber = $("#licenceNumber").val().trim();
        let licenceType = $("#licenceType").val();
        let licenceDate = $("#licenceDate").val();
        let address = $("#driverAddress").val().trim();
        let vehicleType = $("#selectType").val();
        let experience = $("#experience").val();
        let training = $("#training").val();

        let nameRegex = /^[A-Za-z\s]+$/;
        let phoneRegex = /^[0-9]{10}$/;
        let driverIdRegex = /^[A-Za-z0-9]+$/;

        /* Driver ID */

      if (driverId === "") {
		    $("#driverIdError").text("Please enter Driver ID");
		    isValid = false;
		}
		else if (!driverIdRegex.test(driverId)) {
		    $("#driverIdError").text("Driver ID must be alphanumeric");
		    isValid = false;
		}

        /* First Name */
        if (firstName === "" || !nameRegex.test(firstName)) {
        	$("#firstNameError").text("First name is required");
            isValid = false;
        }

        /* Middle Name */
      /*   if (middleName === "" || !nameRegex.test(middleName)) {
            Swal.fire("Validation Error","Enter valid Middle Name","warning");
            return;
        } */

        /* Last Name */
        if (lastName === "" || !nameRegex.test(lastName)) {
        	$("#lastNameError").text("Last name is required");
            isValid = false;
        }

        /* Phone Number */
        if (!phoneRegex.test(phone)) {
        	$("#contactNumberError").text("Enter contact number");
            isValid = false;
        }

        /* Licence Number */
        if (licenceNumber === "") {
        	$("#licenceNumberError").text("Licence number is required");
            isValid = false;
        }

        /* Licence Date */
        if (licenceDate === "") {
        	$("#licenceDateError").text("Licence date is required");
            isValid = false;
        }

        let licenceExpiry = new Date(licenceDate);
        let todayDate = new Date();
        todayDate.setHours(0,0,0,0);

        if (licenceExpiry <= todayDate) {
        	$("#licenceExpiryError").text("First name is required");
            isValid = false;
        }
        if (!licenceType) {
        	$("#licenceTypeError").text("Please select licence type");
            isValid = false;
        }

        /* Address */
        if (address === "") {
        	$("#driverAddressError").text("Enter address");
            isValid = false;
        }

        /* Vehicle Type */
        if (!vehicleType ) {
        	$("#vehicleTypeError").text("Select vehicle type");
            isValid = false;
        }

        /* Experience */
        if (experience === "" || experience < 0 || experience > 50) {
        	$("#experienceError").text("Experience is required");
            isValid = false;
        }

        /* Training */
    /*     if (training === "") {
        	$("#driverIdError").text("First name is required");
            isValid = false;
        } */

        if(!isValid) return;

        /* AJAX Submit */

        $.ajax({
            url: "driverMasterSubmit.jsp",
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
                        text: 'Driver Added Successfully',
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
