/**
 * 
 */
$(document)
    .ready(
        function() {

            $("#searchBox")
                .on(
                    "keydown",
                    function(e) {

                        if (e.key === "Enter") {

                            e.preventDefault();

                            let value = $(this).val()
                                .trim();

                            let department = $(
                                "#selectdepartment")
                                .val();

                            let url = window.location.pathname
                                + "?search="
                                + encodeURIComponent(value);

                            if (department) {
                                url += "&department="
                                    + encodeURIComponent(department);
                            }

                            window.location.href = url;

                        }

                    });

            $("#selectdepartment")
                .on(
                    "change",
                    function() {

                        let department = $(this).val();
                        let search = $("#searchBox")
                            .val();

                        let url = window.location.pathname
                            + "?department="
                            + encodeURIComponent(department);

                        if (search) {
                            url += "&search="
                                + encodeURIComponent(search);
                        }

                        window.location.href = url;

                    });
            /* Delete Staff - code */
            $(document).on("click", ".delete-btn", function(e) {
                e.preventDefault();
                var staffId = $(this).attr("data-staffId");
                const row = $(this).closest("tr");
                $.ajax({
                    url: "staffMasterDelete.jsp",
                    type: "POST",
                    data: { staff_id: staffId },
                    dataType: "json",
                    beforeSend: function() {
                        $("#divLoading").addClass('show');
                    },
                    success: function(response) {
                        $("#divLoading").removeClass('show');
                        if (response.status === "success") {
                            row.remove();
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: 'Staff Deleted Successfully',
                                confirmButtonText: 'OK',
                                allowOutsideClick: false
                            }).then(() => {

                            });

                        }
                        else {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                text: 'Something went wrong',
                                confirmButtonText: 'OK',
                                allowOutsideClick: false
                            });

                        }
                    },
                    error: function(xhr) {
                        $("#divLoading").removeClass('show');
                        /* Swal.fire("Error", xhr.responseText, "error"); */
                        Swal.fire({
                            icon: 'error',
                            title: 'error',
                            text: 'Something went wrong',
                            confirmButtonText: 'OK',
                            allowOutsideClick: false
                        });
                    }
                });

            })

            /* update button logic */
            $(document).on("click", ".update-btn", function(e) {

                $("#updateModal").modal('show');
                let staffId = $(this).attr("data-staffId");
                console.log(staffId);
                $.ajax({
                    url: "getStaffDetails.jsp",
                    type: "GET",
                    data: { staff_id: staffId },
                    dataType: "json",
                    success: function(response) {
                        if (response.status === "success") {
                            let data = response.data;
                            $("#staffId").val(data.staff_id);
                            $("#department").val(data.department);
                            $("#guardianContactNumber").val(data.guardian_number);
                            $("#staffFirstName").val(data.first_name);
                            $("#staffMiddleName").val(data.middle_name);
                            $("#staffLastName").val(data.last_name);
                            $("#pickupDropPoint").val(data.pickup_drop_point);
                            $("#address").val(data.address);

                        } else {
                            console.log("Not able to get data.")
                        }
                    }
                })
            });

            /* Update driver code */
            $("#submitForm").on("submit", function(e) {
                e.preventDefault();
                $(".error").text("");
                $(".form-control").removeClass("error-border");
                let isValid = true;

                // GET VALUES
                let staffId = $("#staffId").val().trim();
                let department = $("#department").val().trim();
                let phone = $("#guardianContactNumber").val().trim();
                let firstName = $("#staffFirstName").val().trim();
                let middleName = $("#staffMiddleName").val().trim();
                let lastName = $("#staffLastName").val().trim();
                let pickupDropPoint = $("#pickupDropPoint").val().trim();
                let address = $("#address").val().trim();

                let nameRegex = /^[A-Za-z\s]+$/;
                let phoneRegex = /^[0-9]{10}$/;

                // VALIDATIONS
                if (staffId === "") {
                    $("#staffIdError").text("Please enter staff ID");
                    isValid = false;
                }

                if (department === "") {
                    $("#departmentError").text("Please enter department");
                    isValid = false;
                }

                if (!phoneRegex.test(phone)) {
                    $("#contactNumberError").text("Enter valid 10-digit contact number");
                    isValid = false;
                }

                if (firstName === "" || !nameRegex.test(firstName)) {
                    $("#firstNameError").text("Enter valid first name");
                    isValid = false;
                }

                if (lastName === "" || !nameRegex.test(lastName)) {
                    $("#lastNameError").text("Enter valid last name");
                    isValid = false;
                }

                if (pickupDropPoint === "") {
                    $("#pickupDropError").text("Please enter pickup/drop point");
                    isValid = false;
                }

                if (address === "") {
                    $("#addressError").text("Please enter staff address");
                    isValid = false;
                }

                if (!isValid) return;


                $.ajax({
                    url: "staffMasterUpdate.jsp",
                    type: "POST",
                    data: $(this).serialize(),
                    dataType: "json",
                    beforeSend: function() {
                        $("#divLoading").addClass('show');
                    },
                    success: function(response) {
                        $("#divLoading").removeClass('show');
                        if (response.status === "success") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: 'Staff Updated Successfully',
                                confirmButtonText: 'OK',
                                allowOutsideClick: false
                            }).then(() => {
                                /* $("#submitForm")[0].reset(); */
                                $("#updateModal").modal('hide');
                                window.location.reload();
                            });

                        }
                        else {
                            Swal.fire({
                                icon: 'error',
                                title: 'error',
                                text: 'Something went wrong',
                                confirmButtonText: 'OK',
                                allowOutsideClick: false
                            });

                        }



                    },
                    error: function(xhr) {
                        $("#divLoading").removeClass('show');
                        /* Swal.fire("Error", xhr.responseText, "error"); */
                        Swal.fire({
                            icon: 'error',
                            title: 'error',
                            text: 'Something went wrong',
                            confirmButtonText: 'OK',
                            allowOutsideClick: false
                        });
                    }
                });
            });



        });