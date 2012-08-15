// FullAddress jQuery Validator
function FullAddressValidator(value, element, paras) {

    // Convert the value variable into something a bit more descriptive
    var CurrentAddress = value;

    // If the address is blank, then this is for the required validator to deal with.
    if (value.length == 0) {
        return true;
    }

    // If we've already validated this address, then just return the previous result
    if ($(element).data("LastAddressValidated") == CurrentAddress) {
        return $(element).data("IsValid");
    }

    // We have a new address to validate, set the IsChecking flag to true and set the LastAddressValidated to the CurrentAddress
    $(element).data("IsChecking", true);
    $(element).data("LastAddressValidated", CurrentAddress);

    // Google Maps doesn't like line-breaks, remove them
    CurrentAddress = CurrentAddress.replace(/\n/g, "");

    // Create a new Google geocoder
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': CurrentAddress }, function (results, status) {

        // The code below only gets run after a successful Google service call has completed.
        // Because this is an asynchronous call, the validator has already returned a 'true' result
        // to supress an error message and then cancelled the form submission.  The code below
        // needs to fetch the true validation from the Google service and then re-execute the
        // jQuery form validator to display the error message.  Futhermore, if the form was
        // being submitted, the code below needs to resume that submit.

        // Google reported a valid geocoded address
        if (status == google.maps.GeocoderStatus.OK) {
            
            // Get the formatted Google result
            var address = results[0].formatted_address;

            // Count the commas in the fomatted address.
            // This doesn't look great, but it helps us understand how specific the geocoded address
            // is.  For example, "CA" will geocde to "California, USA".
            numCommas = address.match(/,/g).length;

            // A full street address will have at least 3 commas.  Alternate techniques involve
            // fetching the address_components returned by Google Maps.  That code looks even more ugly.
            if (numCommas >= 3) {

                // Replace the first comma found with a space
                address = address.replace(/, /, " ");

                // Remove USA from the address (remove this, if this is important to you)
                address = address.replace(/, USA$/, "");

                // Change letters to all uppercase
                address = address.toUpperCase();

                // Check for the map_canvas, if it exists then position the Google Map
                if (exists("#map_canvas")) {
                  $("#map_canvas").show();
                  Map("map_canvas", results[0].geometry.location);
                }

                // Update the form fields
                updateAddressFields(address);

                // Set the textarea value to the geocoded address
                alert('Address will be set to: ' + address)
                $(element).val(address);


                // Cache this latest result
                $(element).data("LastAddressValidated", address);

                // We have a valid geocoded address
                $(element).data("IsValid", true);
            } else {
                // Google Maps was able to geocode the address, but it wasn't specific
                // enough (not enough commas) to be a valid street address.
                $(element).data("IsValid", false);
            }

            // Otherwise the address is invalid
        } else {
            $(element).data("IsValid", false);
        }

        // We're no longer in the midst of validating
        $(element).data("IsChecking", false);

        // Get the parent form element for this address field
        var form = $(element).parents('form:first');

        // This code is being run after the validation for this field,
        // if the form was being submitted before this validtor was
        // called then we need to re-submit the form.
        if ($(element).data("SubmitForm") == true) {
            form.submit();
        } else {
            // Re-validate this property so we can return the result.
            form.validate().element(element);
        }
    });

    // The FullAddress validator always returns 'true' when initially called.
    // The true result will be return later by the geocode function (above)
    return true;
}

// Define a new jQuery Validator method
$.validator.addMethod("fulladdress", FullAddressValidator);
