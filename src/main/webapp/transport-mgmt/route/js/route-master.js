/**
 * 
 */
$(document).ready(function () {

    $("#submitForm").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            url: "routeMasterSubmit.jsp",
            type: "POST",
            data: $(this).serialize(),
            dataType:"json",
            beforeSend: function () {
                $("#divLoading").addClass('show');
            },
            success: function (response) {
                $("#divLoading").removeClass('show');
                if(response.status === "success"){
                Swal.fire({
                    icon: 'success',
                    title: 'Success',
                    text: 'Route Added Successfully',
                    confirmButtonText: 'OK',
                    allowOutsideClick: false
                }).then(() => {
                    $("#submitForm")[0].reset();
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
            error: function (xhr) {
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
