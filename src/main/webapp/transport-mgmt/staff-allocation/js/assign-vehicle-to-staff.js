/**
 * 
 */
$(document).ready(function() {
    /* Search Box Logic */
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

    $(document).on("click", ".unassign-btn", function() {

        let staffId = $(this).attr("data-staffId");
        $("#staffId").val(staffId);

        $.ajax({
            url: "unassignStaff.jsp",
            type: "GET",
            data: { staff_id: staffId },
            dataType: "json",

            beforeSend: function() {
                $("#divLoading").addClass("show");
            },

            success: function(response) {

                $("#divLoading").removeClass("show");

                if (response.status === "success") {

                    console.log("success");

                    Swal.fire({
                        icon: "success",
                        title: "Success",
                        text: "Student Unassigned Successfully",
                        confirmButtonText: "OK",
                        allowOutsideClick: false
                    }).then(() => {

                        $("#updateModal").modal("hide");
                        window.location.reload();

                    });

                } else {

                    Swal.fire({
                        icon: "error",
                        title: "Error",
                        text: "Something went wrong",
                        confirmButtonText: "OK",
                        allowOutsideClick: false
                    });

                }
            },

            error: function(xhr) {

                $("#divLoading").removeClass("show");

                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: "Something went wrong",
                    confirmButtonText: "OK",
                    allowOutsideClick: false
                });

            }
        });

    });

    /* update button logic */
    $(document).on("click", ".assign-btn", function(e) {

        $("#updateModal").modal('show');
        let staffId = $(this).attr("data-staffId");
        $("#staffId").val(staffId);
        let routeNumber = $(this).attr()
        console.log(staffId);
        $.ajax({
            url: "getStaffDetails.jsp",
            type: "GET",
            data: { staff_id: staffId, },
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    let data = response.data;
                    $("#staffId").val(data.staff_id);
                    $("#studentClass").val(data.department);
                    $("#guardianContactNumber").val(data.guardian_number);
                    $("#firstName").val(data.first_name);
                    $("#middleName").val(data.middle_name);
                    $("#lastName").val(data.last_name);
                    $("#pickupDropPoint").val(data.pickup_drop_point);
                    $("#address").val(data.address);

                } else {
                    console.log("Not able to get data.")
                }
            }
        })
    });

    $(document).on("click", ".edit-btn", function(e) {

        $("#updateModal").modal('show');
        let staffId = $(this).attr("data-staffId");
        $("#staffId").val(staffId);
        let routeNumber = $(this).attr()
        console.log(staffId);
        $.ajax({
            url: "editAssignedStaff.jsp",
            type: "GET",
            data: { staff_id: staffId, },
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    let data = response.data;
                    $("#studentId").val(data.student_id);
                    $("#studentClass").val(data.student_class);
                    $("#guardianContactNumber").val(data.guardian_number);
                    $("#firstName").val(data.first_name);
                    $("#middleName").val(data.middle_name);
                    $("#lastName").val(data.last_name);
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
        $.ajax({
            url: "assignStaffDetails.jsp",
            type: "POST",
            data: $(this).serialize(),
            dataType: "json",
            beforeSend: function() {
                $("#divLoading").addClass('show');
            },
            success: function(response) {
                console.log(response);
                $("#divLoading").removeClass('show');
                if (response.status === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: 'Staff Assigned Successfully',
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
                        text: response.message,
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


})

//get vehicles according to route number
document.getElementById("routeNumber").addEventListener("change", function() {

    var routeNumber = this.value;

    fetch("getVehicleForRoute.jsp?routeNumber=" + routeNumber)
        .then(response => response.json())
        .then(data => {

            var vehicleDropdown = document.getElementById("vehicleNumber");
            vehicleDropdown.innerHTML =
                '<option disabled selected hidden>Select Vehicle Number</option>';

            data.forEach(function(vehicle) {
                var option = document.createElement("option");
                option.value = vehicle;
                option.text = vehicle;
                vehicleDropdown.appendChild(option);
            });
        });
});
