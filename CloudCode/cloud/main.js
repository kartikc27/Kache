// Set your secret key: remember to change this to your live secret key in production
// See your keys here https://dashboard.stripe.com/account






var Stripe = require('stripe');
Stripe.initialize('sk_test_4W9UdSujW1lASIblsmRoBnil');


Parse.Cloud.define("chargeWithStripe", function(request, response) {  

var stripeToken = request.params.stripeToken;
var customerID;

// Create a new customer and then a new charge for that customer:
Stripe.Customers.create({
	card: stripeToken,
    email: 'foo-customer@example.com'
}).then(function(customer) {
  customerID = customer.id;
  response.success(customerID);
})
//response.error("Cannot create a new customer.");

});




Parse.Cloud.define("recipientsStripe", function(request, response) {  

var fullName = request.params.fullName;
var recipientID;
var stripeToken = request.params.stripeToken

// Create a new recipient and then a new charge for that customer:
Stripe.Recipients.create({
	name: fullName,
	type: "individual",
	email: 'foo-customer@example.com',
	card: stripeToken
}).then(function(recipient) {
  recipientID = recipient.id;
  response.success(recipientID);
})
//response.error("Cannot create a new customer."); */


});

