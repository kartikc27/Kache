# Set your secret key: remember to change this to your live secret key in production
# See your keys here https://dashboard.stripe.com/account
stripe.api_key = "sk_test_4W9UdSujW1lASIblsmRoBnil"

def createRecipient (dictionary) {

# Get the card details submitted by the form
token_id = request.POST['stripeToken']

# Create a Recipient
recipient = stripe.Recipient.create(
  name="John Doe",
  type="individual",
  email="payee@example.com",
  card=token_id
)

}