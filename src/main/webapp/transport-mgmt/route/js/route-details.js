/**
 * 
 */
	$(document).ready(function (){
		/* Search Box Logic */
		$("#searchBox").on("keyup", function () {

    let value = $(this).val().toLowerCase().trim();

    $("table tbody tr").each(function () {

        let rowText = $(this).text().toLowerCase().trim();

        $(this).toggle(rowText.indexOf(value) > -1);

    });

});



							$(document).on("click", ".delete-btn",function (e){
								 e.preventDefault();
								 var routeNumber = $(this).attr("data-routeNumber");
								 const row = $(this).closest("tr");
								$.ajax({
									url: "routeMasterDelete.jsp",
									type: "POST",
						            data: {routeNumber:routeNumber},
						            dataType:"json",
						            beforeSend: function () {
						                $("#divLoading").addClass('show');
						            },
						            success: function (response) {
						                $("#divLoading").removeClass('show');
						                if(response.status === "success"){
						                	 row.remove();
						                Swal.fire({
						                    icon: 'success',
						                    title: 'Success',
						                    text: 'route Deleted Successfully',
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
							
							})
							
							/* update button logic */
							$(document).on("click", ".update-btn", function (e) {
								
								let routeNumber= $(this).attr("data-routeNumber");
								 $("#updateModal").modal('show');
								$.ajax({
									url:"getRouteDetails.jsp",
									type: "GET",
									data: {routeNumber : routeNumber},
									dataType: "json",
									success: function (response){
										if(response.status === "success"){
											let data= response.data;
											console.log(data);
											$("#routeNumber").val(data.route_number);
											$("#busStop1").val(data.bus_stop_1);
											$("#busStop2").val(data.bus_stop_2);
											$("#busStop3").val(data.bus_stop_3);
											$("#busStop4").val(data.bus_stop_4);
											$("#busStop5").val(data.bus_stop_5);
											$("#busStop6").val(data.bus_stop_6); 		
											
											} else{
											console.log("Not able to get data.")
										}
										
									}
									
								})
								
							});
							  $("#submitForm").on("submit", function (e) {
								  e.preventDefault(); 
							        $.ajax({
							            url: "routeMasterUpdate.jsp",
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
							                    text: 'Route Updated Successfully',
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