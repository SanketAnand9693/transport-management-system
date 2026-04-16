/**
 * 
 */
$(document).ready( function (){
			$("#submitForm").on("submit", function(e){
					e.preventDefault();
					$(".error").text("");
			        $(".form-control").removeClass("error-border");
				    let isValid = true;
			        let organization = $("#organization").val().trim();
			        let firstName = $("#firstName").val();
			        let middleName = $("#middleName").val();
			        let lastName = $("#lastName").val();
			        let contactNumber = $("#contactNumber").val();
			        let address = $("#address").val().trim();

			        if (organization === "") {
			            $("#organizationError").text("Organization name is required");
			            isValid = false;
			        }

			        if(firstName === ""){
			        	 $("#firstNameError").text("Enter first name");
				            isValid = false;
					}

			        if(middleName === ""){
			        	 $("#middleNameError").text("Enter first name");
				            isValid = false;
					}

			        if(lastName === ""){
			        	 $("#lastNameError").text("Enter first name");
				            isValid = false;
					}

			        if(contactNumber === ""){
			        	 $("#contactNumberError").text("Enter first name");
				            isValid = false;
					}
					
			        if(address === ""){
			        	 $("#addressError").text("Enter first name");
				            isValid = false;
					}

				    if(!isValid) return;
					$.ajax({
							url: "vehicleVendorSubmit.jsp",
							type: "POST",
							data: $(this).serialize(),
							dataType: "json",
							success: function(response){
									if(response.status=== "success"){
										
										 Swal.fire({
							                    icon: 'success',
							                    title: 'Success',
							                    text: 'Vendor Added Successfully',
							                    confirmButtonText: 'OK',
							                    allowOutsideClick: false
							                }).then(() => {
							                    $("#submitForm")[0].reset();
							                    window.location.reload();
							                });
																		
										} 
									else{
										 Swal.fire({
					                         icon: 'error',
					                         title: 'error',
					                         text: 'Something went wrong',
					                         confirmButtonText: 'OK',
					                         allowOutsideClick: false
					                     });			
											}
								}
					
						})
				})
			
		})
	