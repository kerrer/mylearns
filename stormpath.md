On the Account Details page, in the Security Credentials section, click Create API Key under Api Keys.

This will generate your API Key and download it to your computer as an apiKey.properties file. If you open the file in a text editor, you will see something similar to the following:

 apiKey.id = 144JVZINOF5EBNCMG9EXAMPLE
 apiKey.secret = lWxOiKqKPNwJmSldbiSkEbkNjgh2uRSNAb+AEXAMPLE
Save this file in a secure location, such as your home directory in a hidden .stormpath directory. For example:

$HOME/.stormpath/apiKey.properties
Also change the file permissions to ensure only you can read this file. For example, on *nix operating systems:

$ chmod go-rwx $HOME/.stormpath/apiKey.properties
$ chmod u-w $HOME/.stormpath/apiKey.properties

location of your tenant from Stormpath
==============
curl -i --user 43A5FYF0RSWB8V9P6DB923J3W:djCS5vVKhOcelPTELQfGS256SMmNOvTBR8+LTldk2uI     'https://api.stormpath.com/v1/tenants/current'

retrieve the location of the My Application Stormpath application
==============
curl -u 43A5FYF0RSWB8V9P6DB923J3W:djCS5vVKhOcelPTELQfGS256SMmNOvTBR8+LTldk2uI   -H "Accept: application/json"    'https://api.stormpath.com/v1/tenants/4L44MwB2SYPk0j7Sxc7T62/applications?name=My%20Application'

Create an application test user account
=================
curl --request POST --user 43A5FYF0RSWB8V9P6DB923J3W:djCS5vVKhOcelPTELQfGS256SMmNOvTBR8+LTldk2uI \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d '{
           "givenName": "Jean-Luc",
           "surname": "Picard",
           "username": "jlpicard",
           "email": "capt@enterprise.com",
           "password":"1983tfcWS"
        }' \
 "https://api.stormpath.com/v1/applications/4Lh7UgPaMcEwfZB4NmEblC/accounts"
