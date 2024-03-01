

**Client Manager**
An internal tool that will help with productively.
Built with VueJS

## Quick start
After Fork and Clone.\
run npm install\
If errors, install any missing packages\
npm run serve\

## If you run into any issues
delete the node module
rm -rf node_modules && npm cache clean --force
delete the package-lock.json file as well
npm install again

## if you run into a eslint issue 
try installing it again
npm install eslint-plugin-vue --save-dev

## if you run into any errors mentioning admin writes. Usually will happen if you attempt to install something globally with -g (npm -g install node module)
sudo npm install 

## Promote - This can be used as a troubleshooting step when listings do not populate into an agent's promote account. Returned are the minimum required data fields for the listing to pull from our API into Promote, as provided by Evocalize support, confirmed as of 2/29/2024. 
login using Moxi Test Partner credentials (this can be done from the 'Moxi Company' page)

## User will input the following fields after logging into the platform with API creds - 
*Company UUID* can be found in roster, this will be the UUID for whichever company the listing / listing agent is associated.
*Listing ID* can be found in the url of the listing within Moxi, it's generally a 9 digit number from what I've seen. For example, with this URL - https://www.windermere.com/listing/WA/Tacoma/4102-N-25th-Street-98406/**186688590**